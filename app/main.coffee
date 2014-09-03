require [
    'zepto',

    'Config',
    'urlResolve',
    'detect',

    'text!view/widget.html',
    'text!view/iframe.html',

    'zeptoFx',
    'zeptoFxMethods',
], ($, Config, urlResolve, detect, widgetTemplate, iframeTemplate) ->
    $ ->
        return if detect.os.phone or detect.os.wp

        # check that config doesn't have errors
        if Config.errors.length > 0
            for err in Config.errors
                if typeof err is 'string'
                    console.log "Wishlistt-plugin: #{err}"
                else
                    console.log err
            return

        # extract values
        values =
            if Config.selectorType is 'css'
                title: $(Config.selectors.title).text()
                price: "#{$(Config.selectors.currency).text() || ''} #{$(Config.selectors.price).text()}"
                image: $(Config.selectors.image).attr('src')
                link: $(Config.selectors.link).text()
            else if Config.selectorType in ['opengraph', 'og']
                title: $(Config.selectors.title).attr('content')
                price: "#{$(Config.selectors.currency).attr('content') || ''} #{$(Config.selectors.price).attr('content')}"
                image: $(Config.selectors.image).attr('content')
                link: $(Config.selectors.link).attr('content')

        # set if not
        if not values.link? or values.link.length is 0
            values.link = document.URL

        # abort if we're not on a product page
        isProductPage = values.title and values.image
        return unless isProductPage

        if not values.image.match 'https?://'
            values.image = urlResolve values.image, document.URL

        # create iframe
        iframeContainer = $ iframeTemplate
        iframeBackground = iframeContainer.find('.wishlistt-background')
        iframeWrapper = iframeContainer.find('.wishlistt-container')
        iframeElement = iframeWrapper.find('iframe')

        iframeContainer.on 'click', '.wishlistt-close, .wishlistt-background', ->
            iframeBackground.fadeTo 300, 0
            iframeWrapper.animate { right: '-350px' },
                duration: 500,
                easing: 'ease-in-out'
                complete: -> iframeContainer.remove()

        iframeElement.on 'load', ->
            payload = { wish: values, colors: Config.colors }
            iframeElement.get(0).contentWindow.postMessage JSON.stringify(payload), '*'

        # create widget
        widgetElement = $ widgetTemplate
        widgetElement.on 'load', ->
            payload = { wish: values, colors: Config.colors }
            widgetElement.get(0).contentWindow.postMessage JSON.stringify(payload), '*'

        # placement and colors according to config
        widgetElement.css Config.placement.side, '0'
        widgetElement.css top: Config.placement.top

        showPlugin = ->
            $(document.body).append iframeContainer
            iframeBackground.fadeTo 300, .5
            iframeWrapper.animate { right: '0px' },
                duration: 500,
                easing: 'ease-in-out'

        $(document.body).append widgetElement

        window.onmessage = (e) ->
            if e.data is 'show_iframe' then showPlugin()
