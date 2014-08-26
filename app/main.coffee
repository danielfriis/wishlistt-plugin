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

        values =
            title: $(Config.selectors.title).text()
            price: $(Config.selectors.price).text()
            picture: document.URL + $(Config.selectors.picture).attr('src')

        # create iframe
        iframeContainer = $ iframeTemplate
        iframeWrapper = iframeContainer.find('.container')
        iframeElement = iframeWrapper.find('iframe')

        iframeContainer.on 'click', '.close', ->
            widgetElement.removeClass 'loading'
            iframeWrapper.animate { right: '-350px' },
                duration: 500,
                easing: 'ease-in-out'
                complete: -> iframeContainer.remove()

        iframeElement.on 'load', ->
            iframeElement.get(0).contentWindow.postMessage values, '*'
            iframeWrapper.animate right: '0px'

        # create widget
        widgetElement = $ widgetTemplate
        widgetElement.find('.title').text values.title
        widgetElement.find('.price').text values.price
        widgetElement.find('.picture img').attr src: values.picture

        widgetElement.on 'click', ->
            $(document.body).append iframeContainer
            $(this).addClass 'loading'


        $(document.body).append widgetElement

        window.onmessage = (e) ->
            console.log('Message from iframe side: ' + e.data)
