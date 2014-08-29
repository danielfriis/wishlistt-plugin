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
            for opt in ['title', 'image', 'price']
                unless CONFIG['selectors'][opt]
                    @errors.push "#{opt} selector not set in config"

            placement = side: 'right', top: '20%'
            if CONFIG.placement
                side = CONFIG.placement.side
                if side not in ['right', 'left']
                    @errors.push 'invalid placement.side value'
                else placement.side = side

                top = CONFIG.placement.top
                if not top.match '[0-9]+.*'
                    @errors.push 'invalid placement.top value'
                else placement.top = top

            colors = foreground: 'white', background: 'black'
            if CONFIG.colors
                foreground = CONFIG.colors.foreground
                if foreground then colors.foreground = foreground

                background = CONFIG.colors.background
                if background then colors.background = background

            # set config properties
            @selectorType = CONFIG.selectorType || 'css'
            @selectors = CONFIG.selectors
            @placement = placement
            @colors = colors

    new Config()
