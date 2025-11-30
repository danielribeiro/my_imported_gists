"""
Saves all webp images
"""
import io
from mitmproxy import http


def response(flow: http.HTTPFlow) -> None:
    if flow.response.headers.get("content-type", "").startswith("image/webp"):
        s = flow.response.content
        name = flow.request.pretty_url.replace('/', '_').replace(':', '_').replace('http', 'req').replace('?', '_').replace('&', '_')
        f = open("~/mitm/%s.webp" % name, "wb")
        f.write(s)
        f.close()
