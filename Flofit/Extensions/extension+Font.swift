import Foundation
import SwiftUI

extension Font {
    static let TitleBold = Font.title.bold()
    static let TitleReguler = Font.title
    static let BodySemiBold = Font.system(.body, weight: .semibold)
    static let BodyRegular = Font.body
    static let FootnoteSemiBold = Font.system(.footnote, weight: .semibold)
    static let FootnoteRegular = Font.footnote
}
