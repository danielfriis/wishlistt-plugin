require [
    'Config'
    'text!view/widget.html'
    ], (Config, widgetTemplate) ->

        init = ->
            # check that config doesn't have errors
            if Config.errors.length > 0
                for err in Config.errors
                    if typeof err is 'string'
                        console.log "Wishlistt-plugin: #{err}"
                    else
                        console.log err
                return

            # create a new DOM node from the template
            element = document.createElement 'div'
            element.innerHTML = widgetTemplate

            # the template has a single root node so we unwrap the
            # created DOM node and add the root node
            widgetElement = element.firstChild
            document.body.insertBefore widgetElement

        if document.readyState in ['complete', 'loaded']
            init()
        else
            document.addEventListener 'DOMContentLoaded', init
