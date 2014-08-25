require ['text!view/widget.html'], (widgetTemplate) ->
    init = ->
        console.log 'Init Wishlistt plugin'

        scriptElement = document.querySelector('script[data-main="wishlist"]')
        CONFIG = JSON.parse(scriptElement.text)

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
