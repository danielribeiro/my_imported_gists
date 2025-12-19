// ==UserScript==
// @name         HN Dark Mode
// @namespace    http://tampermonkey.net/
// @version      2025-12-19
// @description  Hn dark mode
// @author       Danielrb
// @match        https://news.ycombinator.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=ycombinator.com
// @run-at       document-start
// @license      MIT
// @sandbox      DOM
// @grant        GM_addStyle
// ==/UserScript==

(function() {
    'use strict';
        // CSS mostly taken from: https://news.ycombinator.com/item?id=45112226
        let darkMode = `
    body {
        background-color: #262626 !important;
    }

    body > center > table, input, textarea {
        background-color: #222 !important;
    }

    /* Bright text */
    td.title a:link, span.comment font, span.comment font a:link, u a:link, span.yclinks a:link, body:not([id]),
    td:nth-child(2):not(.subtext) > a:link, input, textarea, p > a, a > u, .c00, .c00 a:link,
    a[href="http://www.ycombinator.com/apply/"], a[href="https://www.ycombinator.com/apply/"] {
        color: #ccc !important;
    }

    .admin td {
        color: #aaa !important;
    }

    /* search box and comment box */
    input, textarea {
        border: 1px solid #828282 !important;
    }

    /* selecting the logo*/
    a[href="https://news.ycombinator.com"] > img {
        opacity: 0.4;
        filter: grayscale(0.4);
    }
`
    GM_addStyle(darkMode);

})();