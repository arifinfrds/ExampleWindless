//
//  ViewController.swift
//  Example Windless
//
//  Created by Arifin Firdaus on 6/26/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import UIKit
import Windless
import SDWebImage

class ViewController: UIViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        headerImageView.windless.start()
        titleLabel.windless.start()
        subtitleLabel.windless.start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchPhoto(id: 1)
    }
    
    
    // MARK: - UI Setup
    
    func updateUI(photo: Photo) {
        if let photoUrl = URL(string: getHTTPS(from: photo)) {
            headerImageView.sd_setImage(with: photoUrl) {[weak self] (imageView, error, imageChacheType, url) in
                self?.headerImageView.windless.end()
            }
        }
        titleLabel.text = photo.title
        subtitleLabel.text = photo.url
        
        titleLabel.windless.end()
        subtitleLabel.windless.end()
    }
    
    
    // MARK: - Networking
    
    func fetchPhoto(id: Int) {
        NetworkManager().requestPhoto(forId: id) {[weak self] (photo, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let photo = photo else {
                return
            }
            self?.updateUI(photo: photo)
            
        }
    }
    
    
    // MARK: - Helper
    
    func getHTTPS(from photo: Photo) -> String {
        let http = photo.thumbnailURL!
        var comps = URLComponents(string: http)!
        comps.scheme = "https"
        let https = comps.string!
        return https
    }
    
    
}

