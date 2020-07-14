# DockerでFlaskの環境構築

## Dockerイメージとは

[Docker Hub](https://hub.docker.com/)などのレジストリに置いてあります。イメージを自分のローカルマシンにpullすることによって、イメージを共有することができます。

pythonのイメージは[こちら](https://hub.docker.com/_/python)にある。

イメージにはタグがある。今回は`python`イメージの`3.8.3`を使用する。

https://hub.docker.com/layers/python/library/python/3.8.3/images/sha256-b8c37d821abb6d1bb4110bbad9368ae2da3b100a57ef14ed25ce5c1f6b79a2c9?context=explore

## Dockerfileとは

公開されているDockerイメージから新しくイメージを作成できる。

今回用意した`Dockerfile`の内容

```dockerfile
FROM python:3.8.3 # このイメージを元に新たなイメージを作成する

WORKDIR /flask_app # このディレクトリで作業するという命令
COPY requirements.txt requirements.txt # ローカルにあるファイルを/flask_app配下にコピー
RUN pip install -r requirements.txt # コマンド実行
```

## Dockerコンテナとは

アプリケーションの実行環境です。イメージをもとにコンテナを起動します。

## Docker Compose について

コンテナを一括で構築、連携、管理することができる。docker-compose.ymlを共有することで同じ開発環境を共有することができる。

### Compose実行のステップ

1. `Dockerfile`を用意するか、`Docker Hub`などに置いてあるイメージを使用する
   今回は、Dockerfileを使用します。
2. `docker-compose.yml`を定義する
3. `docker-compose up`を実行する

今回用意した`docker-compose.yml`の内容

```yaml
version: '3.8'

services:
  flask: # サービス名。任意のもので構わない
    build: . # 同じディレクトリにあるDockerfileで作成されるイメージを使用してコンテナを起動する
    volumes:
      - type: bind # bindマウント。ホスト側（source）とコンテナ側（target）でディレクトリを共有する
        source: .
        target: /flask_app
    ports: # ホスト:コンテナのポート番号で、ポートを公開
      - "5000:5000"
    tty: true # コンテナ起動したままにする
```

