Rubyでクローラーを作る予定で、Dockerで開発環境を準備しました。  
結果的にはCocProxyでのSSL関係が上手く行ってません。  

コンテナを立ち上げたら、cocproxyを起動します。

## build

    docker-compose build

## 実行

    docker-compose up

## Gemfileを更新したら

実行する

    docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:3.0 bundle install
    
## 思い出し

- ファイル名は小文字から始める
- クラス名は大文字から始める

### キャッシュを無視

    http://[対象のURL]?clearcache=1