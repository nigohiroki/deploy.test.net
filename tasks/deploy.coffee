module.exports = (grunt) ->
  # タスクの定義
  grunt.registerTask "deploy", 'S3 deploy tool', () ->
    # AWS の初期化
    AWS = require('aws-sdk')
    AWS.config.update(grunt.config('aws_config'))

    # ファイルシステム relases ディレクトリにpull
    fs   = require('fs')
    path = require('path')
    d    = new Date()
    release_path = "./releases/" + d.getFullYear() + d.getMonth() + d.getDate() + d.getHours() + d.getMinutes() + d.getSeconds()

    # git clone 設定
    git = require("nodegit").__proto__
    package_json = grunt.file.readJSON 'package.json'
    ###
    git.Repo.clone package_json.repository.url, release_path, null, () ->
      console.log "test"
    ###

    spawn = require('child_process').spawn
    pwd   = spawn 'pwd', ['-P']
    pwd.stdout.on 'data', (data) ->
      console.log 'stdout : ' + data
    pwd.stderr.on 'data', (data) ->
      console.log 'stderr : ' + data
    pwd.on 'exit', (code) ->
      console.log 'exit code : ' + code

    ###
    # 5つ以上releaseがあれば古い方から削除
    # 強制的にrmdirする
    rmdir_force  = (dir) ->
      list = fs.readdirSync dir
      for file in list
        filename = path.join dir, file
        stat     = fs.statSync filename
        if stat.isDirectory()
          rmdir_force filename
        else
          fs.unlinkSync filename
      fs.rmdirSync dir
    releases_dir = fs.readdirSync "./releases"
    if releases_dir.length > 4
      rmdir_force path.join "./releases", releases_dir.sort()[0]

    # 一旦シンボリックリンクを解除 currentにシンボリックリンクを付与
    if fs.existsSync "./current"
      fs.unlinkSync "./current"
    fs.symlinkSync release_path, "./current", []
    ###
