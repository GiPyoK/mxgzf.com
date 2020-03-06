---
title: Relaunching my website using Swift
description: I recently rebuilt my website using Swift and John Sundell's Publish framework
date: 2020-03-05 12:00
tags: Swift, Publish, Website, HTML, CSS
typora-copy-images-to: ../../Resources/images
typora-root-url: ../../Resources
---

I recently rebuilt my website using Swift and John Sundell's [Publish](https://github.com/JohnSundell/Publish) framework and i can't recommend it enough. It was a lot of fun.

It's just great to be able to use the familiar `DateFormatter` to format dates of blog posts. Or to use a `forEach` loop to create a list of posts that are sorted using a key path:

```swift
let items = context.allItems(sortedBy: \.date, order: .descending)
return HTML(
    .body(
        .ul(
            .id("posts"),
            .forEach(items) { item in
                .li(
                    .article(
                        .a(.href(item.path), .text(item.title)),
                        .p(.text(item.description))
                    )
                )
            }
        )
    )
)
```

### Installation and setup

After following the [instructions](https://github.com/JohnSundell/Publish#installation) you end up with two things:

- A Swift package that generates a static website every time you hit “Run”. Including a sitemap and a RSS feed. It also applies syntax highlighting to your code blocks if you want to, it adds CNAME files if you need to and pushes it to your GitHub pages repo if you wish to.
- And a local HTTP server to test your site

If you look at [my code](https://github.com/mxgzf/mxgzf.com) you see that the final result is pretty straightforward and well organized. I chose a very reduced approach. That's why there are only three Swift files in my package.

### Adding additional resources

Publish requires that resources (images, stylesheets, …) are put in a separate folder `Resources`, outside of the `Content` folder:

<img src="/images/Publish-resources-in-a-separate-folder@2x.png" alt="Publish requires that resources are put in a separate folder Resources" style="zoom:50%;" />

During the publishing process it copies the resources to the root level of the `Output` folder:

<img src="/images/Publish-output-folder@2x.png" alt="During the publishing process resources are copied to the root level of the Output folder" style="zoom:50%;" />

This is implemented in `PublishingStep.copyResources(at:to:includingFolder:)`.

### Adding images to posts when editing

I found that [Typora](https://typora.io) is the best solution to write new posts, especially when it comes to dealing with images. Typora supports both custom root urls and copying images to custom folders.

To support Publish's resource structure i add these two lines to the YAML front matter of the markdown document of each post:

```yaml
typora-copy-images-to: ../../Resources/images
typora-root-url: ../../Resources
```

So whenever i add an image to a post, for example by drag & drop, it automatically copies the image to the `Resources` folder of my Publish repository and sets the image url to `/images/<filename>`. The only requirement is that the markdown document needs to be saved to the `posts` folder before adding images.

By the way: These custom metadata fields are ignored during the publishing process because i don't define them in the `WebsiteItemMetadata` struct of my site definition. So they don't show up in the generated HTML.

### Flashing the posts list

I decided to put the list of blog posts at the end of the index page. I know, this is weird. But at the moment it is more important to present me as a freelancer than list my posts.

I thought it would be nice to flash the posts list when a visitor follows the link in the description that jumps to that list, similar to what Stack Overflow is doing [when linking to answers](https://stackoverflow.com/questions/49726196/swift-3-function-inside-dispatchqueue/49763932#49763932).

To do this, i added  `.id("posts")` to the posts list in `MyHTMLFactory.makeIndexHTML(for:context:)`. Then, to flash the posts list when the anchor is clicked, i added an animation to `.posts:target` in the CSS:

```css
#posts:target {
    animation: flash 2s;
}
@keyframes flash {
   from { background: rgba(254, 255, 0, 0.40); }
   to { background: transparent; }
}
```

This solution is similar to [this CodePen](https://codepen.io/Founts/pen/mPwbbW).

### Supporting dark mode

To support dark mode i first tell the browser in the stylesheet that my site supports both light and dark mode. It will then redraw the site when the user switches between these modes:

```css
:root {
    color-scheme: light dark;
}
```

Then, i defined the colors using a `@media` query:

```css
@media (prefers-color-scheme: dark) { … }
```

### Highlighting syntax

Publish has a plug-in for John Sundell's [Splash](https://github.com/JohnSundell/Splash), a Swift syntax highlighter that adds colors to your code blocks by adding CSS classes to your HTML:

```html
<span class="keyword">func</span> hello(world: <span class="type">String</span>) -> <span class="type">Int</span>
```

Adding this plugin is pretty simple because you just have to add one line of code to your main `publish` call:

```swift
try MySite().publish(
    withTheme: .myTheme,
    additionalSteps: [],
    plugins: [
        .splash(withClassPrefix: "")
    ]
)
```

For the colors i just use Xcode's default colors:

```css
/* light colors */
pre code .keyword { color: #9b2393; }
pre code .type { color: #0b4f79; }
pre code .call { color: #326d74; }
pre code .property { color: #326d74; }
pre code .number { color: #1c00cf; }
pre code .string { color: #c41a16; }
pre code .comment { color: #5d6c79; }
pre code .dotAccess { color: #326d74; }
pre code .preprocessing { color: #643820; }

/* dark colors */
pre code .keyword { color: #fc5fA3; }
pre code .type { color: #5dd8ff; }
pre code .call { color: #67b7a4; }
pre code .property { color: #67b7a4; }
pre code .number { color: #d0bf69; }
pre code .string { color: #fc6a5d; }
pre code .comment { color: #6c7986; }
pre code .dotAccess { color: #67b7a4; }
pre code .preprocessing { color: #fd8f3f; }
```

### The code

You can find the Swift package for my website on GitHub at [mxgzf/mxgzf.com](https://github.com/mxgzf/mxgzf.com) and the generated website at [mxgzf/mxgzf.github.io](https://github.com/mxgzf/mxgzf.github.io).

### More

Check out the following links if you want to learn more about creating and maintaining websites using Swift and Publish:

[This list of pull requests](https://github.com/JohnSundell/Publish/pulls?utf8=✓&q=is%3Apr) gives you a good overview what others contributed to Publish.

Two plug-ins for Publish:

- [CNAMEPublishPlugin](https://github.com/SwiftyGuerrero/CNAMEPublishPlugin) generates CNAME files to support custom domain names
- [TidyHTMLPublishStep](https://github.com/john-mueller/TidyHTMLPublishStep) formats your HTML using [SwiftSoup](https://github.com/scinfu/SwiftSoup)

Other sites built with Publish:

- [https://github.com/abrampers/personal-site-swift](https://github.com/abrampers/personal-site-swift) →[https://abrampers.com](https://abrampers.com)
- [https://github.com/acam002/Blog](https://github.com/acam002/Blog) →[https://acam002.github.io](https://acam002.github.io)
- [https://github.com/alvareztech/alvareztech](https://github.com/alvareztech/alvareztech) →[https://alvarez.tech](https://alvarez.tech)
- [https://github.com/brorhb/brurberg-dev](https://github.com/brorhb/brurberg-dev) →[https://www.brurberg.dev](https://www.brurberg.dev)
- [https://github.com/crelies/christianelies.de](https://github.com/crelies/christianelies.de) →[https://christianelies.de](https://christianelies.de)
- [https://github.com/fbernutz/die-himmelstraeumerin-blog](https://github.com/fbernutz/die-himmelstraeumerin-blog) →[https://fbernutz.github.io](https://fbernutz.github.io)
- [https://github.com/hggz/hggz.github.io](https://github.com/hggz/hggz.github.io) →[https://hggz.github.io](https://hggz.github.io)
- [https://github.com/hngry/hungry.dev](https://github.com/hngry/hungry.dev) →[https://hungry.dev](https://hungry.dev)
- [https://github.com/Jimmy-Lee/jimmy-lee](https://github.com/Jimmy-Lee/jimmy-lee) →[https://jimmy-lee.github.io](https://jimmy-lee.github.io)
- [https://github.com/leontedev/Publish-leonte.dev](https://github.com/leontedev/Publish-leonte.dev) →[https://www.leonte.dev](https://www.leonte.dev)
- [https://github.com/lozhuf/lauriehufford.com](https://github.com/lozhuf/lauriehufford.com) →[https://www.lauriehufford.com](https://www.lauriehufford.com)
- [https://github.com/mazo20/personalWebsite](https://github.com/mazo20/personalWebsite) →[https://mkowalski.me](https://mkowalski.me)
- [https://github.com/navanchauhan/My-Website-Swift](https://github.com/navanchauhan/My-Website-Swift) →[https://navanchauhan.github.io](https://navanchauhan.github.io)
- [https://github.com/ncreated/ncreated.com](https://github.com/ncreated/ncreated.com) →[https://ncreated.com](https://ncreated.com)
- [https://github.com/nitesuit/Blog](https://github.com/nitesuit/Blog) →[https://www.staskus.io](https://www.staskus.io)
- [https://github.com/peteschaffner/peteschaffner.com](https://github.com/peteschaffner/peteschaffner.com) →[https://peteschaffner.com](https://peteschaffner.com)
- [https://github.com/Rubenfer/RubenAppWeb-Project](https://github.com/Rubenfer/RubenAppWeb-Project) →[https://ruben.app](https://ruben.app)
- [https://github.com/SwiftyDorado/static-blog](https://github.com/SwiftyDorado/static-blog) →[https://swiftydorado.github.io](https://swiftydorado.github.io)
- [https://github.com/TonyStarkLi/Blog](https://github.com/TonyStarkLi/Blog) →[https://www.tonystarkli.com](https://www.tonystarkli.com)
- [https://github.com/zorkdev/Website](https://github.com/zorkdev/Website) →[https://www.attilanemet.com](https://www.attilanemet.com)


