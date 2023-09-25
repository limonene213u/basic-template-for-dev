# Node.jsをベースにする
FROM node:16

# Vue CLIをインストール
RUN npm install -g @vue/cli

# アプリケーションディレクトリを作成
WORKDIR /app

# 依存関係をインストール
COPY ./vue-app/package.json ./vue-app/package-lock.json ./
RUN npm install

# アプリケーションのソースをコピー
COPY ./vue-app ./
