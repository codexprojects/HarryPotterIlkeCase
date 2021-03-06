//
//  File.swift
//  Harry Potter Ilke
//
//  Created by Ilke Yucel on 26.07.2021.
//

import UIKit

class ImageDownsamplingOperation: Operation {

    // MARK: Properties

    /// Operation identifier.
    let identifier: UUID

    /// `URL` to localy stored image.
    let imageURL: URL

    /// The maximum width and height in pixels of a thumbnail.
    let maxDimentionInPixels: CGFloat

    /// The `UIImage` that has been downsampled.
    private(set) var downsampledImage: UIImage?

    // MARK: Initialization

    init(identifier: UUID, imageURL: URL, maxDimentionInPixels: CGFloat) {
        self.identifier = identifier
        self.imageURL   = imageURL
        self.maxDimentionInPixels  = maxDimentionInPixels
    }

    // MARK: Operation overrides

    override func main() {
        guard !isCancelled else { return }
        downsampledImage = downsample(imageAt: imageURL, maxDimentionInPixels: maxDimentionInPixels)
    }

    // MARK: Private

    /// Performs downsampling image from the specified `URL` to `maxDimentionInPixels` size.
    ///
    /// - Parameters:
    ///   - imageURL: The `URL` to local stored image file.
    ///   - maxDimentionInPixels: The maximum width and height in pixels of a thumbnail.
    /// - Returns: The downsampled image.
    private func downsample(imageAt imageURL: URL, maxDimentionInPixels: CGFloat) -> UIImage {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!
        let downsampledOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                                  kCGImageSourceShouldCacheImmediately: true,
                                  kCGImageSourceCreateThumbnailWithTransform: true,
                                  kCGImageSourceThumbnailMaxPixelSize: maxDimentionInPixels] as CFDictionary

        let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampledOptions)!

        return UIImage(cgImage: downsampledImage)
    }
}
