#!/bin/bash
message=$1
if [ -z "$message" ]; then
    echo "第１引数で送信メッセージを指定してください"
    exit 1
fi
# post処理(環境変数 SLACK_WEB_HOOKの設定が必要)
curl -X POST -H 'Content-type: application/json' \
   --data "{'text':'${message}'}" \
   $SLACK_WEB_HOOK
