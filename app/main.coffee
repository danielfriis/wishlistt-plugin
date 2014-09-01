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

        # abort if we're not on a product page
        isProductPage = $(Config.selectors.title).length > 0 and
            $(Config.selectors.image).length > 0

        return unless isProductPage

        # extract values
        values =
            title: $(Config.selectors.title).text()
            price: "#{$(Config.selectors.currency).text() || ''} #{$(Config.selectors.price).text()}"
            image: $(Config.selectors.image).attr('src')
            link: document.URL

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

        # placement and colors according to config
        widgetElement.css Config.placement.side, '0'
        widgetElement.css
            backgroundColor: Config.colors.background
            color: Config.colors.foreground
            top: Config.placement.top

        # set product image
        widgetElement.find('.wishlistt-image img').attr src: values.image

        widgetElement.on 'click', ->
            $(document.body).append iframeContainer
            iframeBackground.fadeTo 300, .5
            iframeWrapper.animate { right: '0px' },
                duration: 500,
                easing: 'ease-in-out'

        $(document.body).append widgetElement
