//tasks/mytask.js
module.exports = function(grunt) {
  //タスクの定義
  grunt.registerTask('mytask', 'my local task.', function() {
    var foo = grunt.config('mytask').foo;
    grunt.log.writeln('this is my local task.');
    grunt.log.writeln('foo = ' + foo);
  });
};
