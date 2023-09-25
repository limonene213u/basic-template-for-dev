FROM ruby:3.1

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# アプリケーションディレクトリを作成
WORKDIR /app

# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションのソースをコピー
COPY . ./
