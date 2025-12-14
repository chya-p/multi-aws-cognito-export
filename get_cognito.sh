
---

# ② GitHub 公開用にぼかしたコード（安全版）

```bash
#!/bin/bash
set -euo pipefail

OUTPUT_FILE="Cognito_UserPool.csv"

# ===== サンプル設定（ダミー）=====
ACCOUNTS=(
  "123456789012"
  "234567890123"
)

ROLE_NAME="ReadOnlyRole"
# ===============================

echo "No,AccountId,AccountName,UserPoolId,UserPoolName,Status,CreationDate" > "$OUTPUT_FILE"

global_no=1

for ACCOUNT_ID in "${ACCOUNTS[@]}"; do
  ROLE_ARN="arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}"

  CREDS=$(aws sts assume-role \
    --role-arn "$ROLE_ARN" \
    --role-session-name "cognito-export-session" \
    --output json)

  export AWS_ACCESS_KEY_ID=$(echo "$CREDS" | jq -r '.Credentials.AccessKeyId')
  export AWS_SECRET_ACCESS_KEY=$(echo "$CREDS" | jq -r '.Credentials.SecretAccessKey')
  export AWS_SESSION_TOKEN=$(echo "$CREDS" | jq -r '.Credentials.SessionToken')

  ACCOUNT_NAME=$(aws iam list-account-aliases \
    --query "AccountAliases[0]" \
    --output text 2>/dev/null || true)

  [ "$ACCOUNT_NAME" = "None" ] && ACCOUNT_NAME="$ACCOUNT_ID"

  POOL_JSON=$(aws cognito-idp list-user-pools --max-results 60 --output json)
  POOL_COUNT=$(echo "$POOL_JSON" | jq '(.UserPools // []) | length')

  if [ "$POOL_COUNT" -eq 0 ]; then
    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
    continue
  fi

  OFFSET=$((global_no - 1))

  echo "$POOL_JSON" | jq \
    --arg acct "$ACCOUNT_ID" \
    --arg name "$ACCOUNT_NAME" \
    --argjson offset "$OFFSET" '
    (.UserPools // []) | to_entries[] |
    ($offset + .key + 1) as $no |
    [.value.Id, .value.Name, .value.Status, (.value.CreationDate | tostring)] as $v |
    [$no, $acct, $name] + $v | @csv
  ' >> "$OUTPUT_FILE"

  global_no=$((global_no + POOL_COUNT))
  unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
done

