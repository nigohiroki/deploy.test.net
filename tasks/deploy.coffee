module.exports = (grunt) ->
  # タスクの定義
  grunt.registerTask "deploy", 'S3 deploy tool', () ->
    access_id = grunt.config('aws_config').access_key_id
    grunt.log.writeln 'this is my local task.'
    grunt.log.writeln 'access_id = ' + access_id

