path = require('path')

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    meta:
      src:
        server: 'src/server'
        client: 'src/client'
      build:
        server: 'lib'
        client: 'public/js'
        css:    'public/css'
      test: 'tests'

    coffee:
      server:
        files: [
          {
            'app.js': 'app.coffee'
          }, {
            expand: true
            cwd: '<%= meta.src.server %>'
            src: ['**/*.coffee']
            dest: '<%= meta.build.server %>'
            ext: '.js'
          }
        ]
      client:
        options:
          bare: false
        files: [
          {
            expand: true,
            cwd: '<%= meta.src.client %>'
            src: ['**/*.coffee']
            dest: '<%= meta.build.client %>'
            ext: '.js'
          }
        ]

    concat:
      options:
        separator: ";"
      vendor:
        src: [
          "bower_components/lodash/dist/lodash.min.js"
          "bower_components/EaselJS/lib/easeljs-0.7.0.min.js"
          "bower_components/PreloadJS/lib/preloadjs-0.4.0.min.js"
          "bower_components/TweenJS/lib/tweenjs-0.5.0.min.js"
        ]
        dest: "<%= meta.build.client %>/vendor.js"
      app:
        src: ["<%= meta.build.client %>/**/*.js"]
        dest: "<%= meta.build.client %>/app.js"
          
    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
      app:
        files:
          '<%= meta.build.client %>/app.min.js': ['<%= concat.app.dest %>']

    express:
      development:
        options: 
          port: 3000
          hostname: '0.0.0.0'
          server: path.resolve('./app.js')
          bases: [path.resolve('./public')]
          serverreload: true
          # livereload: true
    open:
      all:
        path: 'http://localhost:<%= express.development.options.port %>'
    
    watch:
      server:
        files: ['app.coffee', '<%= meta.src.server%>/**/*.coffee']
        tasks: ['coffee:server']
      client:
        files: ['<%= meta.src.client %>/**/*.coffee']
        tasks: ['coffee:client']

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-express'
  grunt.loadNpmTasks 'grunt-open'

  grunt.registerTask 'default', [
    'coffee'
    'concat:vendor'
    'express:development'
    'open'
    'watch'
    ]

  grunt.registerTask 'production',  ['coffee', 'concat', 'uglify']
  