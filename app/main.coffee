require [
    'zepto',

    'Config',

    'text!view/widget.html',
    'text!view/iframe.html',

    'zeptoFx',
    'zeptoFxMethods',
], ($, Config, widgetTemplate, iframeTemplate) ->
    $ ->
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

        resolve = (url, base_url) ->
            doc      = document
            old_base = doc.getElementsByTagName('base')[0]
            old_href = old_base && old_base.href
            doc_head = doc.head || doc.getElementsByTagName('head')[0]
            our_base = old_base || doc_head.appendChild(doc.createElement('base'))
            resolver = doc.createElement('a')

            our_base.href = base_url
            resolver.href = url
            resolved_url  = resolver.href # browser magic at work here

            if old_base
                 old_base.href = old_href
            else
                doc_head.removeChild(our_base)
            resolved_url

        if not values.picture.match 'https?://'
            values.picture = resolve values.picture, document.URL

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
        widgetElement.find('.wishlistt-picture img').attr src: values.picture

        widgetElement.on 'click', ->
            $(document.body).append iframeContainer
            iframeBackground.fadeTo 300, .5
            iframeWrapper.animate { right: '0px' },
                duration: 500,
                easing: 'ease-in-out'

        $(document.body).append widgetElement
