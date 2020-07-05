//
//  Copyright © 2020 Schnaub. All rights reserved.
//

import UIKit
import LinkPresentation

public final class AgrumeShareHelper: NSObject {
  private let title: String
  
  public init(title: String) {
    self.title = title
  }

  /// Save the current photo shown in the user's photo library using Long Press Gesture
  /// Make sure to have NSPhotoLibraryUsageDescription (ios 10) and NSPhotoLibraryAddUsageDescription (ios 11+) in your info.plist
  public func makeLongPressGesture(for image: UIImage?, viewController: UIViewController) {
    guard let image = image else {
      return
    }
    
    let activityController = UIActivityViewController(activityItems: [ImageItemSource(image: image, title: self.title)], applicationActivities: nil)
    viewController.present(activityController, animated: true)
  }
  
  final class ImageItemSource: NSObject, UIActivityItemSource {
    let image: UIImage
    let title: String
    
    init(image: UIImage, title: String) {
      self.image = image
      self.title = title
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
      image
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
      image
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
      let imageProvider = NSItemProvider(object: image)
      let metadata = LPLinkMetadata()
      metadata.imageProvider = imageProvider
      metadata.title = self.title
      
      return metadata
    }
  }
}
