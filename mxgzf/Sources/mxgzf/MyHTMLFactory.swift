import Foundation
import Publish
import Plot

struct MyHTMLFactory: HTMLFactory {
    
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<MySite>) throws -> HTML {
        
        let items = context.allItems(sortedBy: \.date, order: .descending)
        return HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .img(
                    .class("profile"),
                    .alt("My profile picture"),
                    .src("/images/profile.jpg")
                ),
                .contentBody(index.content.body),
                .footer(
                    .h3("My blog posts"),
                    .ul(
                        .id("posts"),
                        .forEach(items) { item in
                            .li(.article(
                                .a(.href(item.path), .text(item.title)),
                                .p(.text(item.description))
                            ))
                        }
                    ),
                    .p(
                        .text("Subscribe to new posts using "),
                        .a(.href("/feed.rss"), .text("RSS")),
                        .text(".")
                    ),
                    .p(.text("◼"))
                )
            )
        )
    }

    func makeItemHTML(for item: Item<MySite>,
                      context: PublishingContext<MySite>) throws -> HTML {
        
        let htmlDate = MySite.htmlDateFormatter.string(from: item.date)
        let textualDate = MySite.textualDateFormatter.string(from: item.date)
        
        return HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .article(
                    .header(
                        .h1(
                            .text(item.title)
                        ),
                        .p(
                            .text("by "),
                            .a(.href("/"), .text("Maximilian Götzfried")),
                            .text(" on "),
                            .element(named: "time datetime=\"\(htmlDate)\" title=\"\(textualDate)\"", text: textualDate)
                        )
                    ),
                    .contentBody(item.body),
                    .p(.text("◼"))
                )
            )
        )
    }
    
    func makeSectionHTML(for section: Section<MySite>,
                         context: PublishingContext<MySite>) throws -> HTML {
        // Has an empty HTML, because my website doesn't use sections at the moment
        HTML()
    }
    
    func makePageHTML(for page: Page,
                      context: PublishingContext<MySite>) throws -> HTML {
        // Has an empty HTML, because my website doesn't have pages at the moment
        HTML()
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<MySite>) throws -> HTML? {
        // Has an empty HTML, because tags are deactivated for now
        HTML()
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<MySite>) throws -> HTML? {
        // Has an empty HTML, because tags are deactivated for now
        HTML()
    }
}
