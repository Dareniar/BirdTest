//
//  CalloutView.swift
//  BirdTest
//
//  Created by Danil Shchegol on 23.02.2020.
//  Copyright © 2020 Danil Shchegol. All rights reserved.
//

import UIKit
//view that pops up when user taps on annotation
final class CalloutView: UIView {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let imageURL: URL?
    
    init(annotation: BuildingAnnotation, frame: CGRect = .zero) {
        self.imageURL = URL(string: annotation.imageURL ?? "")
        super.init(frame: frame)
        
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(imageView)
        
        nameLabel.text = annotation.name
        addressLabel.text = annotation.address
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 280),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 260)
        ])
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            addressLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            addressLabel.widthAnchor.constraint(equalToConstant: 260),
            imageView.widthAnchor.constraint(equalToConstant: 280),
            imageView.heightAnchor.constraint(equalToConstant: imageURL == nil ? 0 : 280),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        imageView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //load image only when view appears on screen and only when image hasn't been loaded yet
        if imageView.image == nil, let url = imageURL {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
