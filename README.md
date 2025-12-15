# Multi AWS Cognito UserPool Export Script

## Overview
This repository provides a shell script to export Amazon Cognito User Pool information
from **multiple AWS accounts** into a single CSV file.

The script is designed to run on **AWS CloudShell** and supports environments
where **AWS CLI profiles cannot be used**, by leveraging **STS AssumeRole (Switch Role)**.

---

## Key Features
- Export Cognito User Pool information across multiple AWS accounts
- Clearly identify which AWS account each User Pool belongs to
- Output results in CSV format for auditing and reporting
- No local AWS CLI profile configuration required
- Suitable for restricted corporate environments

---

## Output Format
The script generates a CSV file with the following columns:

```text
No,AccountId,AccountName,UserPoolId,UserPoolName,Status,CreationDate
```

---

### 日本語補足
本リポジトリは、AWS CloudShell 環境のみを利用し、
STS AssumeRole（スイッチロール）を用いて
複数 AWS アカウントに存在する Cognito UserPool 情報を
横断的に取得・CSV 出力する Bash スクリプトです。
AWS CLI プロファイルの利用が制限された
セキュリティ要件の厳しい環境下での
運用・監査・棚卸し用途を想定しています。

---

## Key Features
- 複数 AWS アカウントの Cognito UserPool 情報を一括取得
- STS AssumeRole によるアカウント横断アクセス
- AWS CloudShell のみで実行可能
- CSV 形式での出力（監査・棚卸し向け）

---

## Usage
1. AWS CloudShell を起動
2. get_cognito.sh に対象アカウント ID と Role 名を設定
3. スクリプトを実行

```bash
./get_cognito.sh
```

---

## License
MIT License
