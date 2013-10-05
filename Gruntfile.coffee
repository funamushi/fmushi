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
          "bower_components/easeljs/lib/easeljs-0.7.0.min.js"
        ]
        dest: "<%= meta.build.client %>/vendor.min.js"
      app:
        src: ["<%= meta.build.client %>/**/*.js"]
        dest: "<%= meta.build.client %>/app.js"
          
    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
      app:
        files:
          '<%= meta.build.client %>/app.min.js': ['<%= concat.app.dest %>']

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

  grunt.registerTask 'development', ['coffee', 'concat:vendor']
  grunt.registerTask 'production',  ['coffee', 'concat', 'uglify']
  