require [
    'zepto',

    'Config',

    'text!view/widget.html',
    'text!view/iframe.html',

    'zeptoFx',
], ($, Config, widgetTemplate, iframeTemplate) ->
    $ ->
        console.log 'Init Wishlistt plugin'

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

        values =
            title: $(Config.selectors.title).text()
            price: $(Config.selectors.price).text()
            picture: $(Config.selectors.picture).attr('src')

        if values.picture.match 'https?://' is -1
            values.picture = document.URL + values.picture

        # create iframe
        iframeContainer = $ iframeTemplate
        iframeBackground = iframeContainer.find('.background')
        iframeWrapper = iframeContainer.find('.container')
        iframeElement = iframeWrapper.find('iframe')

        iframeContainer.on 'click', '.close, .background', ->
            iframeWrapper.animate { right: '-350px' },
                duration: 500,
                easing: 'ease-in-out'
                complete: -> iframeContainer.remove()

        iframeElement.on 'load', ->
            iframeElement.get(0).contentWindow.postMessage values, '*'

        # create widget
        widgetElement = $ widgetTemplate
        widgetElement.find('.picture img').attr src: values.picture

        widgetElement.on 'click', ->
            $(document.body).append iframeContainer
            iframeWrapper.animate { right: '0px' },
                duration: 500,
                easing: 'ease-in-out'

        $(document.body).append widgetElement

        window.onmessage = (e) ->
            console.log('Message from iframe side: ' + e.data)
