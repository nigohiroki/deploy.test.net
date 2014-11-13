module.exports = (grunt) ->
  # タスクの定義
  grunt.registerTask "deploy", 'S3 deploy tool', () ->
    # AWS の初期化
    AWS = require('aws-sdk')
    AWS.config.update(grunt.config('aws_config'))

    # ファイルシステム relases ディレクトリにpull
    fs = require('fs')
    d  = new Date()
    release_path = "./releases/" + d.getFullYear() + d.getMonth() + d.getDate() + d.getHours() + d.getMinutes()
    fs.mkdir release_path

    # git clone
    git = require("nodegit").__proto__
    
    package_json = grunt.file.readJSON 'package.json'

    git.Repo.clone package_json.repository.url, release_path, null, () ->
      console.log "success"
