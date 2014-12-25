S3デプロイツール
===============

デプロイツールの説明

## 概要
Github(Bitbucket)リポジトリの内容をS3にアップロードするためのツール

### デプロイまでの流れ
1. git cloneでローカルにソースファイルを落としてくる(releases/2014~　のように最新の日付となる)
2. currentに最新日付のディレクトリをリンクする(シンボリックリンク)
3. currentの内容を結合しminifyする
4. currentの内容をS3にアップロードする

### 構造(5つのモジュール)
* gitclone (git cloneを行うマネージャー required)
* link (cloneしたファイルをcurrentに紐付ける required)
* concat (jsファイルを一つに結合する)
* uglify (jsファイルをminifyする)
* aws_s3 (S3にアップロードする required)

## 設定
ソースファイルをclone

    git clone git@github.com:nigohiroki/deploy.test.net.git

configファイル作成

    cp shared/config/aws_temp.coffee shared/config/aws.coffee
    cp shared/config/git_temp.coffee shared/config/git.coffee
    
aws, configファイルを編集

    vim shared/config/aws.coffee
    module.exports =
      access_key_id:     'xxxxxxxxx'
      secret_access_key: 'xxxxxxxxxxxxxxxxxx'
      region:            'REGION'
      bucket:            'BUCKET NAME'
      
git, configファイルを編集

    vim shared/config/git.coffee
    module.exports =
     repository_name: 'REPOSITORY NAME'
     repository: 'REPOSITORY URL'
     branch: 'TARGET BRANCH'
     
## 使い方
コマンド

    grunt deploy

## 結合、minify設定

tasks/deploy.coffeeの設定を変更する
    vim tasks/deploy.coffee
    module.exports = (grunt) ->
    # タスクの定義
    grunt.registerTask "deploy", 'S3 deploy tool', () ->
        # git clone 
        grunt.task.run 'gitclone'
        # cloneしてきたものをcurrentにlink
        grunt.task.run 'link'
        # jsの前処理
        # 結合
        grunt.task.run 'concat'
        # minify
        grunt.task.run 'uglify'
        # s3 upload
        grunt.task.run 'aws_s3'
        
結合しない場合 'concat' をコメントアウト
minifyしない場合 'uglify' をコメントアウト

## 追加機能モジュール開発方法

vim tasks/xxx.coffee
で新規ファイルを作成する

vim tasks/deploy.coffee
を編集する
    
    grunt.task.run 'xxx'

を追加

### 外部ライブラリを使う場合

    sudo npm install xxx --save-dev

でライブラリをインストール
Gruntfile.coffeeを変更
    
    grunt.loadNpmTasks 'xxx'

vim tasks/deploy.coffee
を編集する
    
    grunt.task.run 'xxx'

を追加

参考資料
[jsのfilesystem]: http://nodejs.org/api/fs.html "jsのファイルシステムについて"
[CoffeeScript]: http://coffeescript.org/ "coffeescriptについて"
