---
layout: post
title: Writing Posts in NixTuts
status: book
category: NixTuts

bookurl: /NixTuts/NixTutsContrib.html
book: Contributing to NixTuts

summary: In this tutorial, we're going to teach you how to write tutorials for NixTuts.

location: _posts/NixTuts/2012-10-12-NixTutsContrib-Posts.md
---

Before I start to talk about writing tutorials, I advise you to have a tab open to our [GitHub repository](https://github.com/linuxtuts/linuxtuts.github.com).

## Different types of posts

Right now it's going to get complex... but don't be worried. All the information you need is right here!

Let's talk about the different types of posts we have.

### 1) Page

A page is simply a page. It is required to have these tags:

    ---
    layout: post
    status: page

    title: titlehere
    ---

Only thing different would be the "title" tag. This determines the title of your page.

Your page should be located in the root directory and written in _html_ (if you need to learn it, check out [codeacademy.com](http://www.codecademy.com/tracks/web)). After that, it should be added to the navigation.

I believe in examples, so let's show one.

#### HTML

    ---
    layout: post
    status: page
    
    title: FAQ
    
    location: faq.html
    ---
    <p>Q: What does "NixTuts" mean?</p>
    <p>A: *nix Tutorials in full form. We refer to tutorials as "tuts" too. *nix is commonly used as a reference to Unix-like systems in IRC.</p>
    
    <p>Q: Why do you have tutorials (CSS, JS etc.) that aren't related to *nix?</p>
    <p>A: Many *nix users want to learn those too so we included them.</p>
    .
    .
    .
    
Most of you should already know this is the FAQ. Let's observe what is inside.

At the top of the file is the "tags". They are included in a YAML header (basically three dashes, one at the start and another at the end). These tags will tell the formatter how to format your page.

Then, it's all your HTML.

This file is located in _faq.html_ (as specified by the **location** tag). Pages have no naming convention other than _WRITE-THE-SHORTEST-TITLE-POSSIBLE-AND-DO-NOT-WRITE-ONE-AS-LONG-AS-THIS-ONE.html_

The *location* tag is an indicator of where the post is in the site directory. It is used to generate [prose.io](prose.io) links that enable users to easily edit the site.

#### Adding to the navigation

Adding to the navigation is a breeze too. Go to "_includes/nav.html" where you can see a whole list of navigation links.

	<nav class="clearfix">
	    <ul class="clearfix">
	        <li><a href='/'>Home</a></li>
	        <li><a href='/programs.html'>Programs</a></li>
	        <li><a href='/alltutorials.html'>All Tutorials</a></li>
	        <li><a href='/about.html'>About</a></li>
	        <li><a href='/NixTuts/NixTutsContrib.html'>Contributing</a></li>
	        <li><a href='/faq.html'>FAQ</a></li>
	    </ul>
	</nav>

Throw in your link. You should already understand this piece of code since you needed to write HTML. If not, follow the syntax.

<!--more-->

### 2) Post/Draft

Posts and drafts are much more complex. They have a lot of tags but they provide huge flexibility in how you could present your content. Why are we so strict on those tags? Because they will contain crucial information, like warning the reader of incomplete content in case they use it on a production server.

Here are the required tags:

    ---
    layout: post
    status: post

    title: History of Computer Viruses
    category: Viruses
    tags: [history, viruses]
    author: [wei2912, manu-27993]
    summary: Random summary here!
    ---

This is a bit more complex, isn't it? <p class="notice">Refer to the repository.</p>

The status depends on what you consider your post to be. We have three levels:

1. Published (status: post)
2. In progress (status: draft)
3. To be created/rewritten in the future (rename your file to YYYY-MM-DD-titlehere.md so that it would not be published)

The title is self explanatory. The category is just a one word category for where your post should belong on the homepage in those geeky green boxes. You are advised to use the same category (for example Linux and GNU/Linux - if another post is in GNU/Linux switch it to Linux).

The tags and author are "arrays". Tags are used to find related posts, so add specific ones and not brief ones like "Linux". After that would be "author". Author is where you put your name if you wrote/contributed to the post. Use your GitHub username as it will link to GitHub.

"summary" is VERY important too. Without it your post will have nothing displayed on the front page. You can use HTML to write it.

There are more tags which can help you in improving the content of your page:

    .
    .
    .
    sources: ["http://blah.com", "https://github.com/thisandthatandotherstuff"]

Sources are links which you received information from. It is best to use the direct links to the articles. This is to give credit. Note that each string is enclosed in double quotes - this is required for URLs.

<p class="notice">NOTE: The tags "img" and "imgalt" have been removed as they can and should be replaced with more versatile options. Refer to <a href="https://github.com/linuxtuts/linuxtuts.github.com/commit/c0e13b5a340b0e3ce3b5b047a3595b039ab76dfd">Remove old tags "img" and "imgalt"</a> by wei2912</p>

#### Writing in Markdown

We'll be coming up with a tutorial about Markdown soon. Meanwhile check out this documentation at [Daring Fireball](http://daringfireball.net/projects/markdown/). You can also take a look at our other posts which are very well written. All posts are in "_posts".

#### Linking to a post

Just change the directory and remove the date. Also change the extension ".md" to ".html". For example, instead of using "/_posts/2012-02-25-heyaya.md", use "/categoryhere/heyaya.html".

### 3) Book

Books are series of tutorials. Their naming convention is "DateOfBook-titlehere.md" They consist of two parts:

1. Content/main page.
2. Links to other tutorials

In fact, this post is part of a book, [Contributing to NixTuts](/NixTuts/NixTutsContrib.html).

#### Content/main page/bookstart

The content/main page/bookstart looks like this:

    ---
    layout: post
    status: bookstart

    title: Contributing to NixTuts
    category: NixTuts

    author: [wei2912, Digit]
    summary: Learn what you can do for NixTuts, your favorite tutorial website! We've stripped in our own tutorials as to how you can contribute to us! Not only do you contribute to our website, you also contribute to the Open Source world, the Free Software world and of course, GNU/Linux.
    ---

Title refers to the title of the book. Category refers to the category of the book (books have categories, don't they?). Author refers to the author (of course). You'll need a summary too.

You write the content/main page just like how you do with a post. __MAKE SURE THAT IT REFERS TO ALL PAGES IN THE BOOK THROUGH LINKS CLEARLY AND CLEANLY__.

#### Other tutorials

The tutorials in the book have a naming convention too - "DateOfBook-BookName_titlehere.md". The file looks like this:

    ---
    layout: post
    status: book

    title: Writing Posts in NixTuts

    book: Contributing to NixTuts
    bookurl: /NixTuts/NixTutsContrib.html
    
    summary: Heya~
    .
    .
    .

The tags in a book can merge with the tags in a post. The above are the strictly necessary tags.

Book is used to refer to the name of the book while the bookurl is used to refer to the url of the book. By naming conventions it will be "/category/booknamehere.html".

<p class="notice">Refer to the repository.</p>

#### Linking to a book

Link to the book as a whole. If you are linking to a tutorial in a book, use "/posts/\_BOOK\_titlehere.html".

### I don't get the naming scheme...

Let's talk about the naming scheme seperately.

1) Anything which is incomplete is to be prepended with YYYY-MM-DD-titlehere.md if it is a post/book. If it's a page, don't add it to navigation.

2) A **page** title is: **In Source** /title.html **Actual** /title.html

3) A **post** title is: **In Source** /_posts/YYYY-MM-DD-post.md **Actual** /category/post.html

4) A **book (bookstart)** title is: **In Source** /_posts/YYYY-MM-DD-book.md **Actual** /category/book.html

5) A **book page** title is: **In Source** /_posts/YYYY-MM-DD-BookTitle-PageTitle.md **Actual** /category/BookTitle-PageTitle.html

Hopefully this makes it much clearer :)
    
## Conclusion

Writing tutorials isn't that hard. It's much harder than many other sites, but it comes with a lot of advantages. We coded up this complex matrix of tags for you to easily implement your tutorials in a standardized way. If you need any help, feel free to contact us at our channel. There'll always be someone there :) We wish you good luck with your tutorials!
