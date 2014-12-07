module.exports = (grunt) ->
  # AWSのkey, secret, regionを設定
  aws_config   = require("./shared/config/aws")
  # git関連のパラメータを設定
  git_config   = require("./shared/config/git")
  
  # 各タスクの設定
  configObject = {
    pkg: grunt.file.readJSON 'package.json'
    # リポジトリの名前を入れる
    repository_name: git_config.repository_name
    # git cloneの設定, リポジトリのURL, branchを設定
    gitclone:
      clone:
        options:
          repository: git_config.repository
          branch: git_config.branch
          cwd: 'releases'
    # s3 uploadシステムの設定
    aws_s3:
      options:
        accessKeyId:     aws_config.access_key_id
        secretAccessKey: aws_config.secret_access_key
        region:          aws_config.region
        uploadConcurrency: 5
        downloadConcurrency: 5
      production:
        options:
          # bucket名の設定
          bucket: aws_config.bucket
          differential: true
        files: [
          { cwd: 'current',dest: 'current', action: 'delete' },
          { expand: true, cwd: 'current', src: ['**'], dest: 'current' }
        ]
  }
  grunt.initConfig configObject

  # taskの利用
  grunt.loadNpmTasks 'grunt-git'
  grunt.loadNpmTasks 'grunt-aws-s3'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.task.loadTasks "tasks"
