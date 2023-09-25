# Alpine 3.18.3をベースにする
FROM alpine:3.18.3

# 必要なパッケージをインストール
RUN apk update && apk add \
    apache2 \
    php82 \
    php82-apache2 \
    nodejs \
    npm

# Apacheの設定
RUN mkdir -p /run/apache2

# ドキュメントルートの設定
WORKDIR /var/www/html

# Apacheを前景で実行
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
