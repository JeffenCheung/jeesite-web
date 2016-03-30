/*!
 * jQuery Cookie Plugin v1.4.1
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2013 Klaus Hartl
 * Released under the MIT license
 */
(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD
		define(['jquery'], factory);
	} else if (typeof exports === 'object') {
		// CommonJS
		factory(require('jquery'));
	} else {
		// Browser globals
		factory(jQuery);
	}
}(function ($) {

	var pluses = /\+/g;

	function encode(s) {
		return config.raw ? s : encodeURIComponent(s);
	}

	function decode(s) {
		return config.raw ? s : decodeURIComponent(s);
	}

	function stringifyCookieValue(value) {
		return encode(config.json ? JSON.stringify(value) : String(value));
	}

	function parseCookieValue(s) {
		if (s.indexOf('"') === 0) {
			// This is a quoted cookie as according to RFC2068, unescape...
			s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\');
		}

		try {
			// Replace server-side written pluses with spaces.
			// If we can't decode the cookie, ignore it, it's unusable.
			// If we can't parse the cookie, ignore it, it's unusable.
			s = decodeURIComponent(s.replace(pluses, ' '));
			return config.json ? JSON.parse(s) : s;
		} catch(e) {}
	}

	function read(s, converter) {
		var value = config.raw ? s : parseCookieValue(s);
		return $.isFunction(converter) ? converter(value) : value;
	}

	var config = $.cookie = function (key, value, options) {

		// Write

		if (value !== undefined && !$.isFunction(value)) {
			options = $.extend({}, config.defaults, options);

			if (typeof options.expires === 'number') {
				var days = options.expires, t = options.expires = new Date();
				t.setTime(+t + days * 864e+5);
			}

			return (document.cookie = [
				encode(key), '=', stringifyCookieValue(value),
				options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
				options.path    ? '; path=' + options.path : '',
				options.domain  ? '; domain=' + options.domain : '',
				options.secure  ? '; secure' : ''
			].join(''));
		}

		// Read

		var result = key ? undefined : {};

		// To prevent the for loop in the first place assign an empty array
		// in case there are no cookies at all. Also prevents odd result when
		// calling $.cookie().
		var cookies = document.cookie ? document.cookie.split('; ') : [];

		for (var i = 0, l = cookies.length; i < l; i++) {
			var parts = cookies[i].split('=');
			var name = decode(parts.shift());
			var cookie = parts.join('=');

			if (key && key === name) {
				// If second argument (value) is a function it's a converter...
				result = read(cookie, value);
				break;
			}

			// Prevent storing a cookie that we couldn't decode.
			if (!key && (cookie = read(cookie)) !== undefined) {
				result[name] = cookie;
			}
		}

		return result;
	};

	config.defaults = {};

	$.removeCookie = function (key, options) {
		if ($.cookie(key) === undefined) {
			return false;
		}

		// Must not alter options, thus extending a fresh object...
		$.cookie(key, '', $.extend({}, options, { expires: -1 }));
		return !$.cookie(key);
	};

}));

// sinc 1.4.2 add cookieList by jeffen@pactera 2016/1/17
//So on any page you can get the items like this.
//var list = new cookieList("MyItems"); // all items in the array.
//Adding items to the cookieList
//list.add("foo"); 
//Note this value cannot have a comma "," as this will spilt into
//two seperate values when you declare the cookieList.
//Clearing the items
//list.clear();
(function ($) {
    $.fn.extend({
        cookieList: function (cookieName, value) {
			//This is not production quality, its just demo code.
			//When the cookie is saved the items will be a comma seperated string
			//So we will split the cookie by comma to get the original array
			
			var cookie = $.cookie(cookieName);
			//Load the items or a new array if null.
			var items = cookie ? cookie.split(/,/) : new Array();

			//Return a object that we can use to access the array.
			//while hiding direct access to the declared items array
			return {
			    "add": function(val) {
			        //Add to the items.
			        items.push(val);
			        //Save the items to a cookie.
			        $.cookie(cookieName, items.join(','));
			    },
			    "remove": function (val) {
			        //EDIT: Thx to Assef and luke for remove.
			        indx = items.indexOf(val);
			        if(indx!=-1) items.splice(indx, 1);
			        $.cookie(cookieName, items.join(','));
			    },
			    "clear": function() {
			        items = null;
			        //clear the cookie.
			        $.cookie(cookieName, null);
			    },
			    "items": function() {
			        //Get all the items.
			        return items;
			    }
			};
        }
    });
})(jQuery);


/**
  Usage:
  var cookieList2 = $.fn.cookieList2("cookieName");
  cookieList2.add(1);
  cookieList2.add(2);
  cookieList2.remove(1);
  var index = cookieList2.indexOf(2);
  var length = cookieList2.length();
  **/
(function ($) {
    $.fn.extend({
        cookieList2: function (cookieName) {
            var cookie = $.cookie(cookieName);

            var items = cookie ? eval("([" + cookie + "])") : [];

            return {
                add: function (val) {
                    var index = items.indexOf(val);

                    // Note: Add only unique values.
                    if (index == -1) {
                        items.push(val);
                        $.cookie(cookieName, items.join(','), { expires: 365, path: '/' });
                    }
                },
                remove: function (val) {
                    var index = items.indexOf(val);

                    if (index != -1) {
                        items.splice(index, 1);
                        $.cookie(cookieName, items.join(','), { expires: 365, path: '/' });
                     }
                },
                indexOf: function (val) {
                    return items.indexOf(val);
                },
                clear: function () {
                    items = null;
                    $.cookie(cookieName, null, { expires: 365, path: '/' });
                },
                items: function () {
                    return items;
                },
                length: function () {
                    return items.length;
                },
                join: function (separator) {
                    return items.join(separator);
                }
            };
        }
    });
})(jQuery);