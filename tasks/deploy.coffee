module.exports = (grunt) ->
  # タスクの定義
  grunt.registerTask "deploy", 'S3 deploy tool', () ->
    key_id    = grunt.config('aws_config').access_key_id
    secret_id = grunt.config('aws_config').secret_access_key
    grunt.log.writeln 'this is my local task.'
    grunt.log.writeln 'access_id = ' + key_id

