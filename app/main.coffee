require ['test'], (Test) ->

    # Test.hello()

    console.log 'Init'

    scriptElement = document.querySelector('script[data-main="wishlist"]')
    CONFIG = JSON.parse(scriptElement.text)
