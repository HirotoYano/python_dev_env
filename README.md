# python_dev_env

## 事前準備
.envファイルを作成して、以下の情報を追加

`
USER=

UID=

GID=
`

## 使い方
- 環境立ち上げ
`fish env_launch.sh -s コンテナ名`

- コンテナにログイン
`fish env_launch.sh -e コンテナ名`

- 環境削除
`fish env_launch.sh -d コンテナ名`
