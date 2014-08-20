module.exports = (grunt) ->

    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        paths:
            src: 'src'
            dest: 'dist'
            # tmpl: 'templates'
            # css: 'css'

        clean: { dist: [ 'dist' ] }

        # copy:
        #     dist:
        #         files: [
        #             { expand: true, src: ['<%= paths.tmpl %>/**'], dest: '<%= paths.dest %>' }
        #             { expand: true, src: ['<%= paths.css %>/**'], dest: '<%= paths.dest %>' }
        #         ]

        coffee:
            dist:
                expand: true
                src: [ '<%= paths.src %>/**/*.coffee' ]
                dest: '<%= paths.dest %>'
                ext: '.js'

    grunt.loadNpmTasks 'grunt-contrib-clean'
    # grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-coffee'

    grunt.registerTask 'default', [ 'clean', 'coffee' ]
