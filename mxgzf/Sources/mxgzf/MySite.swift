import Foundation
import Publish
import Plot

struct MySite: Website {
    
    /// Basics values
    var url = URL(string: "https://mxgzf.github.io")!
    var title = "Maximilian Götzfried"
    var name = "Maximilian Götzfried"
    var description = "Freelance developer for all Apple platforms"
    var language: Language { .english }
    var imagePath: Path? { nil }
    
    /// We don't really use sections for now
    enum SectionID: String, WebsiteSectionID {
        case posts
    }
    
    /// We just use basic metadata values
    struct ItemMetadata: WebsiteItemMetadata {}
    
    /// All dates use the same time zone and locale
    static func dateFormatter(with format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Europe/Berlin")
        formatter.locale = Locale(identifier: "en-US")
        formatter.dateFormat = format
        return formatter
    }
    
    /// Formats dates like `2020-02-23`. For `<time>` elements.
    static var htmlDateFormatter = dateFormatter(with: "yyyy-dd-MM")
    
    /// Formats dates like `February 23, 2020`. For posts and post lists.
    static var textualDateFormatter = dateFormatter(with: "MMMM d, yyyy")
}

extension Theme where Site == MySite {
    static var myTheme: Self {
        Theme(htmlFactory: MyHTMLFactory())
    }
}
