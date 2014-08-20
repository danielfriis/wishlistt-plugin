module.exports = (grunt) ->

    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        paths:
            src: 'app'
            lib: 'bower_components'
            dest: 'dist'
            build: '<%= paths.dest %>/build'
            www: 'www'
            # tmpl: 'templates'
            # css: 'css'

        clean: { dist: [ 'dist' ] }

        copy:
            dist:
                files: [
                    { expand: true, cwd: '<%= paths.www %>', src: ['**'], dest: '<%= paths.dest %>' }
                    # { expand: true, src: ['<%= paths.tmpl %>/**'], dest: '<%= paths.dest %>' }
                    # { expand: true, src: ['<%= paths.css %>/**'], dest: '<%= paths.dest %>' }
                    { expand: true, src: [ '<%= paths.lib %>/**' ], dest: '<%= paths.dest %>' }
                ]

        coffee:
            dist:
                expand: true
                cwd: '<%= paths.src %>'
                src: [ '**/*.coffee' ]
                dest: '<%= paths.dest %>'
                ext: '.js'

        requirejs:
            compile:
                options:
                    baseUrl: '<%= paths.dest %>'

                    out: '<%= paths.build %>/wishlist.js'
                    optimize: 'none' # uglify2

                    name: '<%= paths.lib %>/almond/almond'
                    include: ['main']
                    # exclude: ['']
                    # stubModules: ['text']
                    wrap: true

                    paths:
                        # jquery: 'libs/jquery'
                        # text: 'libs/text'

        watch:
            files: [ '<%= paths.src %>/**', '<%= paths.www %>/**' ]
            tasks: [ 'build' ]

        connect:
            server:
                options:
                    base: '<%= paths.dest %>'

    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-requirejs'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-connect'

    grunt.registerTask 'default', [ 'build' ]

    grunt.registerTask 'dev', [ 'build', 'connect', 'watch' ]
    grunt.registerTask 'build', [ 'clean', 'copy', 'coffee', 'requirejs' ]
