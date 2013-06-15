---
layout: post
title: Flexible media - CSS3
category: css
tags: [css, flexible media]
author: [wei2912]

status: draft
original: http://css-tricks.com/rundown-of-handling-flexible-media/](http://css-tricks.com/rundown-of-handling-flexible-media/
---
##Flexible images

When you take the responsive web design route, part of the deal is fluid grids. That is, container elements set in percentage widths. Just one example: an _article_ tag that holds a blog post might be 320px wide on a small screen device and 690px wide on some large screen. Text can be resized and will flow nicely to fill a container. That's not too hard. But media - images, video players, and audio players - demand a bit more attention (e.g. a video that sticks off the edge of the screen == bad). This post is to round up the methods of handling that.

If you're comfortable with IE 7 and up support. This little beauty will do you fine:

    img {
      max-width: 100%;
    
      /* just in case, to force correct aspet ratio */
      height: auto !important;
    }

If you are caring about IE 7 support (I hope not, but I understand there are scenarios in which you must), use this to make sure the images survive the scale-down:

    img { 
      -ms-interpolation-mode: bicubic; 
    }

[See here](http://css-tricks.com/ie-fix-bicubic-scaling-for-images/) for more on that.

If you need to care about IE 6 (again...) [this Ethan Marcotte article](http://unstoppablerobotninja.com/entry/fluid-images/) has a JavaScript solution. Kind of a bummer loading extra JavaScript for a browser that is already much slower, but c'est la vie.

##A shift in thinking

There was a time in which resizing images was quite the taboo. Browsers sucked at resizing images and bandwidth was being wasted. That attitude is all but gone now mostly because browsers are now pretty good at resizing images and having them look good. In fact, with "retina" displaying becoming a thing, serving too-large-for-container images is kinda good, because scaling them down makes them look all the sharper.

However the bandwidth thing is still a (big) issue. Which is what makes the responsive images thing such a hot issue right now. Point is: when thinking about flexible images, work in some thinking about responsive images too. You can read more up on the current solutions to that here.

##Flexible video

Flexible video is a little more complex than images. If you are using HTML5 _video_ tag directly, the good news is that it holds its aspect ratio just like images do, so the same technique holds:

    video {
      max-width: 100%;
    
      /* just in case, to force correct aspet ratio */
      height: auto !important;
    }

However, I'm starting to think it's a pretty bad idea to use HTML5 _video_ tag directly. The required formats have been shifting around for years now and it's not over yet. Add to that the fact that 1) hosting video is bandwidth intensive and expensive 2) streaming is another whole complicated beast 3) maintaining appropriate quality across formats and devices and available bandwidth is hard and 4) skinning consistant controls on the player is hard and ... well ... screw using HTML5 video directly.

Instead, I highly recommend using a video service like YouTube or Vimeo. When you embed videos from these services, you embed an _iframe_. What comes inside the iframe might be HTML5 video, but you don't have to deal with it directly.

All that to say: _iframe_s have an aspect ratio problem.

Thierry Koblentz solved this issue years ago in his A List Apart article Creating Intrinsic Ratios for Video.

The basic idea is that you create a video wrapper div with zero height and a top padding set in percentages. That percentage will actually be a percentage of the width, making it maintain aspect ratio. Then you absolutely position the video inside, which gives you that elusive ability to maintain aspect ratio. We'd be targeting the iframe for absolute position, as again, video doesn't need this but iframes do. The basics:

    .video-wrapper {
      height: 0;
      padding-bottom: 56.25%; /* 16:9 */
      position: relative;
    }
    .video-wrapper iframe {
      position: absolute;
      top: 0; left: 0; right: 0; bottom: 0;
    }

Check out [the article](http://www.alistapart.com/articles/creating-intrinsic-ratios-for-video/) on that for more nuances and details about older browser support. I also cover all of this and include some homebrew JavaScript solutions (with demos) in my .net mag article [Create Fluid Width Videos.](http://www.netmagazine.com/tutorials/create-fluid-width-videos)

##Enough complexity, enter simplicity

If you're using jQuery and you've had enough of the complication surrounding the issue of flexible width video, I invite you to try FitVids.js. I co-authored this little jQuery plugin with Dave Rupert to specifically deal with this problem. It uses the exact same concepts explained above, only it does it automatically. That means 1) no non-semantic wrapper in your authored markup 2) aspect ratios that match the individual video (not all videos are the same).

[FitVids.js](http://fitvidsjs.com/) works out of the box with all the major video players and is super easy to extend to work with any player.

##Using Sublime Video?

[I have a tutorial](http://css-tricks.com/making-sublimevideo-fluid-width/) on how to make their player fluid width.

##Using MediaElements.js?

[MediaElements.js](http://mediaelementjs.com/) is a very nice HTML5 video player that alleviates some of the issues I mentioned above with HTML5 video. Namely, it provides a nice consistent player skin and has the ability to fall back to older tech to play videos, like Flash and Silverlight. It's not a total silver bullet as it doesn't save you from the platform wars on mobile (which don't have Flash or Silverlight generally) or help with streaming or quality issues, but it's still nice.

There is a lot of fixed pixel calculation stuff going on in MediaElements.js, but I've been able to force it to be fluid width in the past with some !important overrides:

    .mejs-container {
      width: 100% !important;
      height: auto !important;
      padding-top: 57%;
    }
    .mejs-overlay, .mejs-poster {
      width: 100% !important;
      height: auto !important;
    }
    .mejs-overlay-button {
      /* Tinker until placed correctly for you */
      margin: 50px 0 0 -38px !important;
    }
    .mejs-mediaelement video {
      position: absolute;
      top: 0; left: 0; right: 0; bottom: 0;
      width: 100% !important;
      height: 100% !important;
    }

##Responsive Video?

Remember how responsive images is a hot topic because we're trying to be responsible and not serve images that are un-needed-ly large? Video has that same problem only compounded by ... uhm ... as many frames as there are in the entire video (probably a lot).

One half-janky solution is to serve different video sources depending on browser window width. I have a tutorial on that here.

Another solution is to use media attributes on the video sources and just hope that the support gets better and it doesn't get removed.

    <video controls    
       <source src="video-small.mp4" type="video/mp4" media="all and (max-width: 480px)"    
       <source src="video-small.webm" type="video/webm" media="all and (max-width: 480px)"    
       <source src="video.mp4" type="video/mp4"    
       <source src="video.webm" type="video/webm"    
    </video>

The best solution is to use a video service and they'll handle it for you.

##Flexible Audio

You only "see" HTML5 audio if you specifically use the controls attribute on the element.

    <audio controls src="audio.ogg">
    <p>Fallback.</p>
    </audio>

The good news is that you just chuck width: 100%; on that bad boy and it'll be flexy flexy:

    audio {
        width: 100%;
    }

WebKit browsers are maxing the width of them out at 800px for some reason. But the player remains centered within the space. Opera and Firefox have no such maximum. They all have slightly different players but all do basically the same thing (play the sound and have play and pause buttons and stuff).

The only other very popular embedded sound player right now is the SoundCloud player and it's fluid width by default (go team!).

