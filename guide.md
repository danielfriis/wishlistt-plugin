# Wishlistt plugin

The Wishlistt plugin enables merchants to embed a widget that seamlessy integrates the Wishlistt functionality to an online web store. Users can add an item from a product page to a Wishlistt list with a few clicks, or can sign up directly from the plugin.

## Functionality
The plugin adds a button to all product pages which, when clicked, will present the user with options to save the current product to an existing wish list, add a new wish list, sign in or sign up as a new user.

The placement and colors of the plugin can be customized as described below.

## Installation
To install the plugin, simply add the following script tag to any page where the widget should be shown.

    <script type="text/javascript" src="http://wishlistt.com/plugin/script" data-wishlistt async="async">
    {
        "selectors": {
            "title": ".title",
            "price": ".price",
            "picture": ".picture"
        },
        "placement": {
            "side": "right",
            "top": "20%"
        }
    }
    </script>

### Customization options
The following options are

###### `selectors` required

- `"title"`: The CSS selector of the title of the product, e.g. `".title"`
- `"price"`: The CSS selector of the price of the product, e.g. `".price"`
- `"picture"`: The CSS selector an image tag of the product, e.g. `".product img"` or `".picture"`

###### `placement`

- `"side"`: Which side the widget should align to. Possible values are `"right"` and `"left"`. Default: `"right"`.
- `"top"`: CSS unit of how far the widget should be from the top of the page, e.g. `"100px"`, `"35em"`, `"50%"`. Default: `"20%"`.