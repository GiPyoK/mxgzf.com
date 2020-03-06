---
title: NSSearchField bezel weirdness
description: Setting NSSearchField.isBordered to either true or false after setting the NSSearchField.bezelStyle, the bezel will not be applied properly
date: 2020-01-09 12:00
tags: AppKit, NSSearchField
typora-copy-images-to: ../../Resources/images
typora-root-url: ../../Resources
---

Setting `NSSearchField.isBordered` to either `true` or `false` after setting the `NSSearchField.bezelStyle`, the bezel will *not* be applied properly. So if you want `.bezelStyle = .roundedBezel` it is better to not set `isBordered` at all.

I think we can file that under "AppKit weirdness".

And yes, i'm creating the UI of this Mac app programmatically. I've learned my lesson after loosing many hours by merging storyboards, xibs and nibs for several clients in the past decade.

