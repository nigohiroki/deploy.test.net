module.exports = (grunt) ->
  aws_config   = require("./shared/config/aws")
  configObject = {
    pkg: grunt.file.readJSON 'package.json'
    aws_config: require("./shared/config/aws") # awsのIDを設定
    repository_name: 'nigohiroki.github.io'
    gitclone:
      clone:
        options:
          repository: "https://github.com/nigohiroki/nigohiroki.github.io.git"
          branch: 'master'
          cwd: 'releases'
    aws_s3:
      options:
        accessKeyId:     aws_config.access_key_id
        secretAccessKey: aws_config.secret_access_key
        region:          aws_config.region
        uploadConcurrency: 5
        downloadConcurrency: 5
      production:
        options:
          bucket: grunt.file.readJSON('package.json').name
          differential: true
        files: [
          { cwd: 'current',dest: 'current', action: 'delete' },
          { expand: true, cwd: 'current', src: ['**'], dest: 'current' }
        ]
  }
  grunt.initConfig configObject

  grunt.loadNpmTasks 'grunt-git'
  grunt.loadNpmTasks 'grunt-aws-s3'
  grunt.task.loadTasks "tasks"
