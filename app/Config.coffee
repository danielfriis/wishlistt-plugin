define ['zepto'], ($) ->

    class Config

        REQUIRED: ['selectors']

        constructor: ->
            @errors = []

            # get wishlistt-plugin script tag
            scriptElement = $('script[data-wishlistt]')

            # try to load JSON
            try
                CONFIG = JSON.parse scriptElement.text()
            catch error
                @errors.push 'failed to parse config JSON:'
                @errors.push error
                return

            # check config contains required fields
            for opt in @REQUIRED
                unless CONFIG[opt]
                    @errors.push "#{opt} not set in config"
                    return

            # and for selectors
            for opt in ['title', 'picture', 'price']
                unless CONFIG['selectors'][opt]
                    @errors.push "#{opt} selector not set in config"

            # set config properties
            @selectorType = CONFIG.selectorType || 'css'
            @selectors = CONFIG.selectors

    new Config()
