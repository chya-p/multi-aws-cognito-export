# Multi AWS Account Cognito UserPool Export Script

## 概要
AWS CloudShell 環境のみを利用し、AssumeRole（STS）を用いて  
複数 AWS アカウントを横断し、Cognito UserPool 情報を CSV 形式で出力する  
Bash スクリプトです。

ローカル環境で AWS CLI 設定ができないセキュリティ制約下でも  
運用可能な構成となっています。

---

## 主な機能
- 複数 AWS アカウントの Cognito UserPool 一覧取得
- AssumeRole によるアカウント切り替え
- アカウント ID / アカウント名 を含めた CSV 出力
- 数十アカウントを想定したスケーラブルな設計

---

## 前提条件
- AWS CloudShell を利用できること
- 各対象 AWS アカウントで AssumeRole（スイッチロール）が可能であること
- 各アカウントに共通の Role 名が存在すること
- jq が利用可能であること（CloudShell には標準搭載）

---

## 設定方法
スクリプト内の以下の箇所を編集してください。

```bash
ACCOUNTS=(
  "123456789012"
  "234567890123"
)

ROLE_NAME="ReadOnlyRole"

