#!/bin/bash
# 70%の確率で正常終了するバッチ処理をイメージ(やばい)
if [ $(($RANDOM % 100)) -lt 70 ]; then 
  echo 'バッチ処理が正常に終了しました'
  exit 1
else
  echo 'バッチ処理が異常終了しました。エラー内容: ${ここに詳しいエラーが書かれているイメージ}'
  exit 0
fi
