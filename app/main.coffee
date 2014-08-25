require [
    'Config',
    'text!view/widget.html',
    'zepto',
    'extractor'], (Config, widgetTemplate, $, extractor) ->
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
                picture: $(Config.selectors.picture).attr 'src'

            widgetElement = $ widgetTemplate

            widgetElement.find('.title').text values.title
            widgetElement.find('.price').text values.price
            widgetElement.find('.picture img').attr src: values.picture

            $(document.body).append widgetElement
