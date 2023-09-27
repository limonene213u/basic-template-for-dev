#!/bin/sh

mkdir -p react_app
cd ./react_app

# create-react-appでReactアプリケーションをセットアップ
npx create-react-app .

# package.jsonの内容を変数に格納（必要に応じて）
PACKAGE_JSON_CONTENT=$(cat package.json | jq '.
    + {
        "scripts": {
            "start": "react-scripts start"
        }
    }
    # 他の変更や追加が必要な場合はこちらに
')

# 変数の内容をpackage.jsonに書き込み（必要に応じて）
echo "$PACKAGE_JSON_CONTENT" > package.json

cd ..

echo "
react_frontend/
|
react_app/
|
|-- public/       # Static files
|   |-- index.html
|   |-- favicon.ico
|-- src/          # React source files
|   |-- components/  # React components
|   |-- App.js       # Main React component
|   |-- index.js     # Entry point
|-- package.json  # Dependencies and scripts
|-- Dockerfile.react
" > Directory_map.txt
#!/bin/sh

mkdir -p react_app
cd ./react_app

# create-react-appでReactアプリケーションをセットアップ
npx create-react-app .

# 他の変更や追加が必要な場合の例
# package.jsonの内容を変数に格納
PACKAGE_JSON_CONTENT=$(jq '
    .scripts += {
        "new-script": "some-command"
    }
' package.json)

# 変数の内容をpackage.jsonに書き込み
echo "$PACKAGE_JSON_CONTENT" > package.json

cd ..

echo "
react_frontend/
|
react_app/
|
|-- public/       # Static files
|   |-- index.html
|   |-- favicon.ico
|-- src/          # React source files
|   |-- components/  # React components
|   |-- App.js       # Main React component
|   |-- index.js     # Entry point
|-- package.json  # Dependencies and scripts
|-- Dockerfile.react
" > Directory_map.txt
