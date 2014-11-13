module.exports = (grunt) ->
  # タスクの定義
  grunt.registerTask "deploy", 'S3 deploy tool', () ->
    AWS = require('aws-sdk')
    AWS.config.update(grunt.config('aws_config'))
