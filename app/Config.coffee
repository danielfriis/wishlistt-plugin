define ['zepto'], ($) ->

    class Config

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
            @selectorType = CONFIG.selectorType || 'og'
            @selectors = CONFIG.selectors || {}
            # set defaults
            @selectors.price ?= 'meta[itemprop="price"]'
            @selectors.currency ?= 'meta[itemprop="priceCurrency"]'
            @selectors.image ?= 'meta[property="og:image"]'
            @selectors.title ?= 'meta[property="og:title"]'
            @selectors.link ?= 'meta[property="og:url"]'

            @placement = placement
            @colors = colors

    new Config()
