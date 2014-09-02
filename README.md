# Wishlistt plugin

The Wishlistt plugin enables merchants to embed a widget that seamlessy integrates the Wishlistt functionality to an online web store. Users can add an item from a product page to a Wishlistt list with a few clicks, or can sign up directly from the plugin.

## Functionality
The plugin adds a button to all product pages which, when clicked, will present the user with options to save the current product to an existing wish list, add a new wish list, sign in or sign up as a new user.

The placement and colors of the plugin can be customized as described below.

## Installation
To install the plugin, simply add the following script tag to any page where the widget should be shown.

    <script type="text/javascript" src="http://wishlistt.com/plugin/script" data-wishlistt async="async">
    {
        "selectorType": "css",
        "selectors": {
            "title": ".title",
            "price": ".price",
            "currency": ".priceCurrency",
            "image": ".image img"
        },
        "placement": {
            "side": "right",
            "top": "20%"
        },
        "color": {
            "foreground": "white",
            "background": "blue"
        }
    }
    </script>

## Configuration
Here are the different options to select price, title etc. and to customize the look and feel of the widget.

### Selectors
`"selectorType"` defines the type of selector to be used. Can either be `"css"` or `"opengraph"` (default).
If you are using `opengraph`, the plugin will automatically try to select common meta tags, as `meta[itemprop="price"]`. If the webshop does not have these, one will need to define them, or alternatively use CSS-selectors.

`"selectors"`:

- `"title"`: The title of the product. Opengraph default: `"meta[property="og:title"]"`.
- `"price"`: The price of the product. Opengraph default: `"meta[itemprop="price"]"`.
- `"currency"`: The price currency. Opengraph default: `"meta[itemprop="priceCurrency"]"`.
- `"image"`: The image tag of the product. Opengraph default: `"meta[property="og:image"]"`.

### Placement
The `"placement"` object defines the placement of the widget. Its options are:

- `"side"`: Which side the widget should align to. Possible values are `"right"` and `"left"`. Default: `"right"`.
- `"top"`: CSS unit of how far the widget should be from the top of the page, e.g. `"100px"`, `"35em"`, `"50%"`. Default: `"20%"`.

### Color
The `color` object defines the color of the widget. Its options are:

- `"foreground"`: The foreground color, i.e. the color of the text, of the widget, header and buttons. Default is white.
- `"background"`: The background color of the widget, header and buttons. If the same as the foreground color, the text will not be visible. Default is black.
