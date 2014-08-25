require ['text!view/widget.html'], (widgetTemplate) ->
    init = ->
        # get wishlistt-plugin script tag
        scriptElement = document.querySelector('script[data-wishlistt]')

        # try to load JSON
        try
            CONFIG = JSON.parse(scriptElement.text)
        catch error
            console.log 'Wishlistt-plugin: failed to parse config JSON:'
            console.log error
            return

        # check config contains required fields
        missingOpt = false
        for opt in ['title', 'picture', 'price']
            unless CONFIG[opt]
                console.log("Wishlistt-plugin: #{opt} xpath not set in config")
                missingOpt = true

        return if missingOpt

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
