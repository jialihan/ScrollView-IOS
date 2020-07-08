//
//  SlideView.swift
//  ScrollView
//
//  Created by Han Jiali on 6/19/20.
//  Copyright © 2020 Han Jiali. All rights reserved.
//

import UIKit

class SlideView: UIView {

       let imageView: UIImageView = {
            let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 150))
            imgView.layer.borderWidth = 1.0
            imgView.layer.borderColor = UIColor.lightGray.cgColor
            return imgView
        }()
        let headline: UILabel = {
            let label = UILabel(frame: CGRect(x: 20, y: 300, width: 100, height: 90))
            label.textAlignment = .center
            label.text = "header field"
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 2
            return label
        }()
        let text: UILabel = {
               let label2 = UILabel(frame: CGRect(x: 20, y: 400, width: 314, height: 75))
                label2.textAlignment = .center
                label2.text = "text field"
                label2.textColor = UIColor.gray
                label2.adjustsFontForContentSizeCategory = true
                label2.lineBreakMode = .byWordWrapping
                label2.numberOfLines = 3
                return label2
            }()
       
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .white
            setUpViews()
            setUpConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setUpViews(){
            self.backgroundColor = .white
            self.addSubview(imageView)
            self.addSubview(headline)
            self.addSubview(text)
        }
        
        func setUpConstraints() {
            // image
            self.translatesAutoresizingMaskIntoConstraints = false
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 112).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 294).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 320).isActive = true
            let space:CGFloat = (self.frame.width - 320) / 2;
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: space).isActive = true
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -space).isActive = true

            
            // headline
            headline.translatesAutoresizingMaskIntoConstraints = false
            headline.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
            headline.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            
            // text
            text.translatesAutoresizingMaskIntoConstraints = false
            text.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 10).isActive = true
            text.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        }
        
}
