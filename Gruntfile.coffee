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
      dev:
        options: 
          script: 'app.js'
          port: 3000
          # debug: true

    open:
      dev:
        path: 'http://localhost:<%= express.dev.options.port %>'
    
    watch:
      express:
        files: ['app.js', 'lib/**/*.js']
        tasks: ['express:dev']
        options:
          nospawn: true
      coffeeServer:
        files: ['app.coffee', '<%= meta.src.server%>/**/*.coffee']
        tasks: ['coffee:server']
      clientClient:
        files: ['<%= meta.src.client %>/**/*.coffee']
        tasks: ['coffee:client']

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-open'

  grunt.registerTask 'build:dev', ['coffee', 'concat:vendor']
  grunt.registerTask 'build:production',  ['coffee', 'concat', 'uglify']

  grunt.registerTask 'default', ['build:dev', 'express:dev', 'open:dev', 'watch']

  