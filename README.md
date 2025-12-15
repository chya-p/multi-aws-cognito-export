# Multi AWS Account Cognito UserPool Export Script

## Overview
This repository provides a Bash script that exports Amazon Cognito User Pool information
across multiple AWS accounts into a single CSV file.
The script is designed to run exclusively on AWS CloudShell and supports environments
where AWS CLI profiles cannot be used, by leveraging STS AssumeRole (Switch Role).
It is intended for operational tasks such as cross-account inventory management,
auditing, and security reviews in restricted corporate environments.

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
