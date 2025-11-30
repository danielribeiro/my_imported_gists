// ==UserScript==
// @name        Apple News Firefox Windows Spoof
// @namespace   your-namespace
// @match       https://apple.news/*
// @version     0.1
// @description Spoofs the user agent to Firefox on Windows for Apple News.
// @author      You
// @grant       none
// ==/UserScript==

(function() {
    'use strict';

    // Define the Firefox on Windows user agent string
    const firefoxWindowsUserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:125.0) Gecko/20100101 Firefox/125.0';

    // Override the navigator.userAgent property
    Object.defineProperty(navigator, 'userAgent', {
        get: function() {
            return firefoxWindowsUserAgent;
        }
    });

    // You might also want to override other related properties for better compatibility
    // such as navigator.appVersion, navigator.platform, and navigator.vendor.
    // However, doing so might have unintended consequences on other scripts or the website's behavior.
    // Use with caution.

    // Example of overriding navigator.appVersion (optional)
    Object.defineProperty(navigator, 'appVersion', {
        get: function() {
            return '5.0 (Windows)';
        }
    });

    // Example of overriding navigator.platform (optional)
    Object.defineProperty(navigator, 'platform', {
        get: function() {
            return 'Win32';
        }
    });

    // Example of overriding navigator.vendor (optional)
    Object.defineProperty(navigator, 'vendor', {
        get: function() {
            return ''; // Firefox doesn't typically have a vendor string
        }
    });

    console.log('Apple News user agent spoofed to Firefox on Windows.');
})();