module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    mytask: { foo: 'bar' }

  grunt.task.loadTasks "tasks"
