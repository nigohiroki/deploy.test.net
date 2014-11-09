module.exports = (grunt) ->
  configObject = {
    pkg: grunt.file.readJSON 'package.json'
    aws_config: require("./shared/config/aws") # awsのIDを設定
  }
  grunt.initConfig configObject

  grunt.task.loadTasks "tasks"
