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
            src: ['{,*/}*.coffee'],
            dest: '<%= meta.build.client %>'
            rename: (dest, src) -> 
              dest + '/' + src.replace(/\.coffee$/, '.js');
          }              
        ]

    concat:
      options:
        separator: ";"
        stripBanners: true,
        banner: "/*! <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today('yyyy-mm-dd') %> */\n"
      vendor:
        src: [
          "bower_components/jquery/jquery.min.js"
          "bower_components/lodash/dist/lodash.min.js"
          "bower_components/backbone/backbone-min.js"
          "bower_components/tweenjs/build/tween.min.js"
          "bower_components/pixi/bin/pixi.js"
          "bower_components/two/build/two.min.js"
        ]
        dest: "<%= meta.build.client %>/vendor.js"
      app:
        src: [
          "<%= meta.build.client %>/fmushi.js"
          "<%= meta.build.client %>/models/*.js"
          "<%= meta.build.client %>/views/*.js"
          ]
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
        files: ['app.coffee', '<%= meta.src.server%>/{,*/}*.coffee']
        tasks: ['coffee:server']
      coffeeClient:
        files: ['<%= meta.src.client %>/{,*/}*.coffee']
        tasks: ['coffee:client', 'open:dev']
        # options:
        #   livereload: 35729

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-open'

  grunt.registerTask 'build:dev', ['coffee', 'concat:vendor']
  grunt.registerTask 'build:production',  ['coffee', 'concat', 'uglify']

  grunt.registerTask 'default', ['build:dev', 'express:dev', 'open:dev', 'watch']

  