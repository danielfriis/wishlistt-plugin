require [
    'zepto',

    'Config',
    'urlResolve',

    'text!view/widget.html',
    'text!view/iframe.html',

    'zeptoFx',
    'zeptoFxMethods',
    'zeptoDetect',
], ($, Config, urlResolve, widgetTemplate, iframeTemplate) ->
    $ ->
        return if $.os.phone or $.os.wp

        # check that config doesn't have errors
        if Config.errors.length > 0
            for err in Config.errors
                if typeof err is 'string'
                    console.log "Wishlistt-plugin: #{err}"
                else
                    console.log err
            return

        # abort if we're not on a product page
        isProductPage = $(Config.selectors.title).length > 0
        return unless isProductPage

        # extract values
        values =
            title: $(Config.selectors.title).text()
            price: $(Config.selectors.price).text()
            picture: $(Config.selectors.picture).attr('src')
            link: document.URL

        if not values.picture.match 'https?://'
            values.picture = urlResolve values.picture, document.URL

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
            iframeElement.get(0).contentWindow.postMessage values, '*'

        # create widget
        widgetElement = $ widgetTemplate
        # placement according to config
        widgetElement.get(0).style[Config.placement.side] = '0'
        widgetElement.get(0).style.top = Config.placement.top
        # set product image
        widgetElement.find('.wishlistt-picture img').attr src: values.picture

        widgetElement.on 'click', ->
            $(document.body).append iframeContainer
            iframeBackground.fadeTo 300, .5
            iframeWrapper.animate { right: '0px' },
                duration: 500,
                easing: 'ease-in-out'

        $(document.body).append widgetElement
