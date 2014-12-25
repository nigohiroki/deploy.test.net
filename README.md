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

## 使い方
git clone 
