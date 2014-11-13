module.exports = (grunt) ->
  # タスクの定義
  grunt.registerTask "deploy", 'S3 deploy tool', () ->
    # AWS の初期化
    AWS = require('aws-sdk')
    AWS.config.update(grunt.config('aws_config'))

    # ファイルシステム relases ディレクトリにpull
    fs = require('fs')
    d  = new Date()
    fs.mkdir "./releases/" + d.getFullYear() + d.getMonth() + d.getDate() + d.getHours() + d.getMinutes()

    # git clone
    git = require("nodegit").__proto__
    console.log git
