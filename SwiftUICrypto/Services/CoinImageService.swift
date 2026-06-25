//
//  CoinImageService.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 15/06/26.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    
    private let imageNme: String
    
    init (coin: CoinModel) {
        self.coin = coin
        self.imageNme = coin.id
        getcoinImage()
    }
    
    private func getcoinImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)!
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] image in
                
                guard let self = self, let downloadedImage = image else { return }
                
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImages(image: downloadedImage, imageName: self.imageNme, folderName: self.folderName)
            })
    }
}
