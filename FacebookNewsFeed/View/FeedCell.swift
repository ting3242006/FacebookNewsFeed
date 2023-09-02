//
//  FeedCell.swift
//  FacebookNewsFeed
//
//  Created by Ting on 2023/8/16.
//

import Foundation
import UIKit

class FeedCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            
            statusImageView.image = nil
            
            if let statusImageUrl = post?.statusImageUrl {
                
                if let statusImageUrl = post?.statusImageUrl, let url = URL(string: statusImageUrl) {
                    startLoading()
                    let session = URLSession.shared
                    let task = session.dataTask(with: url) { data, response, error in
                        
                        if let error = error {
                            print(error)
                            self.stopLoading()
                            return
                        }
                        
                        if let data = data, let image = UIImage(data: data) {
                            
                            DispatchQueue.main.async { [weak self] in
                                self?.statusImageView.image = image
                                self?.stopLoading()
                            }
                        }
                    }
                    task.resume()
                }
            }
            
            setupNameLocationStatusAndProfileImage()
            
            if let numLikes = post?.numLikes, let numComments = post?.numComments {
                likesCommentsLabel.text = "\(numLikes) Likes     \(numComments) Comments"
            }
        }
    }
    
    var feedViewController: FeedViewController?
    
    private func setupNameLocationStatusAndProfileImage() {
        
        if let name = post?.name {
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: "\nDecember 18 • San Francisco • ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 155, green: 161, blue: 171)]))
            
            nameLabel.font = UIFont.systemFont(ofSize: 14)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "globe_small")
            attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
            attributedText.append(NSAttributedString(attachment: attachment))
            
            nameLabel.attributedText = attributedText
        }
        
        if let statusText = post?.statusText {
            statusTextView.text = statusText
        }
        
        if let profileImageName = post?.profileImageName {
            profileImageView.image = UIImage(named: profileImageName)
        }
        
        if let statusImageName = post?.statusImageName {
            statusImageView.image = UIImage(named: statusImageName)
        }
    }
    
    @objc func animate() {
        feedViewController?.animateImageView(statusImageView: statusImageView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        return label
    }()
    
    let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Meanwhile, Beast turned to the dark side."
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
       let label = UILabel()
        label.text = "222 Likes    333 Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        
        return view
    }()
    
    let likeButton: UIButton = FeedCell.buttonForTitle(title: "Like", imageName: "like")
    
    let commentButton: UIButton = FeedCell.buttonForTitle(title: "Comment", imageName: "comment")
    
    let shareButton: UIButton = FeedCell.buttonForTitle(title: "Share", imageName: "share")
    
    var activityIndicator: UIActivityIndicatorView!
    
    static func buttonForTitle(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }
    
    func setupViews() {
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        
        statusImageView.addSubview(activityIndicator)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animate))
        statusImageView.addGestureRecognizer(tapGesture)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        // button contraints
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.3)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLineView, likeButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        
        // 可以用上面的方式寫看看
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: statusImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: statusImageView.centerYAnchor)
        ])
    }
    
    private func startLoading() {
        activityIndicator.startAnimating()
    }
    
    private func stopLoading() {
        activityIndicator.stopAnimating()
    }
}

