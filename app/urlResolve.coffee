define [], ->
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
