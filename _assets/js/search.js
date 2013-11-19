"use strict";

var capitalizeFirst = function (str) {
    var temp = str.charAt(0).toUpperCase();
    for (var i = 1; i < str.length; i++) {
        temp += str.charAt(i).toLowerCase();
    }
    return temp;
};

var filterPostsByPropertyValue = function (posts, property, value) {
    var filteredPosts = [];
    // The last element is a null terminator
    if (posts[posts.length - 1] == null) {
        posts.pop();
    }
    for (var i = 0; i < posts.length; i++) {
        var post = posts[i],
            prop = post[property];

        // Last element of tags is null
        if (post.tags[post.tags.length - 1] == null) {
            post.tags.pop();
        }

        // The property could be a string, such as a post's category,
        // or an array, such as a post's tags
        if (prop.constructor === String) {
            if (prop.toLowerCase() === value.toLowerCase()) {
                filteredPosts.push(post);
            }
        } else if (prop.constructor === Array) {
            for (var j = 0; j < prop.length; j++) {
                if (prop[j].toLowerCase() === value.toLowerCase()) {
                    filteredPosts.push(post);
                    break;
                }
            }
        }
    }

    return filteredPosts;
};

var getParam = function (param) {
    var queryString = window.location.search.substring(1),
        queries = queryString.split("&");
    for (var i = 0; i < queries.length; i++) {
        var pair = queries[i].split("=");
        if (pair[0] === param) {
            return pair[1];
        }
    }
    return null;
};

var noResultsFound = function (property, value) {
    $('#banner').text('No results found.');
    $('#results').append("<p>We couldn't find anything associated with '" + value + "' here.</p>");
};

var resultsFound = function (property, value, posts) {
    $('#banner').text(capitalizeFirst(property) + " Listing for ‘" + capitalizeFirst(value) + '’');
    for (var i = 0; i < posts.length; i++) {
        var post = posts[i];
        var tags = post.tags;
        var category = post.category;

        var postid = "#post" + i;
        $('#results').append('<div class="post clearfix" id="' + postid + '"></div>');
        $(postid).append('<h2><a href="' + post.url + '">' + post.title + '</a></h2> <h3>' + post.date + '</h3>');
        $(postid).append('<p>' + post.summary + '</p>');
    }
};

$(function () {
    $("#banner").text("");

    var map = {
        'category': getParam('category'),
        'tags': getParam('tags'),
    };

    var count = 3; // number of variables in map

    $.each(map, function (type, value) {
        if (value !== null && type !== null) {
            count--;

            $.getJSON('/search.json', function (data) {
                var posts = filterPostsByPropertyValue(data, type, value);
                if (posts.length === 0) {
                    noResultsFound(type, value);
                } else {
                    resultsFound(type, value, posts);
                }
            }).error(function () {
                $("#banner").text("search.json loading failed! We'll sort this out soon.");
            });
        }
    });

    if (count === 3) {
        $("#banner").text("No/invalid parameter(s) was(were) passed so we couldn't return anything. Sorry!");
        $('#results').append("<p>Valid parameteres: category | tags </p>");
    }
});
