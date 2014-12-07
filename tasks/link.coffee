module.exports = (grunt) ->
  # タスクの定義
  grunt.registerTask "link", 'S3 deploy tool', () ->
    # ファイルシステム relases ディレクトリにpull
    fs   = require('fs')
    path = require('path')
    d    = new Date()
    release_path = "./releases/" + d.getFullYear() + d.getMonth() + d.getDate() + d.getHours() + d.getMinutes() + d.getSeconds()
   
    # cloneしてきたものをrename
    fs.renameSync './releases/' + grunt.config.data.repository_name, release_path

    # 5つ以上releaseがあれば古い方から削除
    # 強制的にrmdirする
    rmdir_force  = (dir) ->
      list = fs.readdirSync dir
      for file in list
        filename = path.join dir, file
        stat     = fs.statSync filename
        if stat.isDirectory()
          rmdir_force filename
        else
          fs.unlinkSync filename
      fs.rmdirSync dir
    releases_dir = fs.readdirSync "./releases"
    if releases_dir.length > 4
      rmdir_force path.join "./releases", releases_dir.sort()[0]

    # 一旦シンボリックリンクを解除 currentにシンボリックリンクを付与
    if fs.existsSync "./current"
      fs.unlinkSync "./current"
    fs.symlinkSync release_path, "./current", []
