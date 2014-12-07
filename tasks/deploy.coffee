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
