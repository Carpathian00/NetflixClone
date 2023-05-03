//
//  HeroHeaderView.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 10/04/23.
//

import UIKit
import SDWebImage

class HeroHeaderView: UIView {
    
    var homeVCDelegate: HomeViewControllerDelegate?
    private var headerItem: Item?
    
    private lazy var barStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false;

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 40
        
        return stackView
    }()
    
    private lazy var saveButton: UIButton = {
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 14)

        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Save", attributes: container)
        configuration.image = UIImage(systemName: "plus")
        
        configuration.imagePlacement = .top
        configuration.imagePadding = 8
        let button = UIButton(configuration: configuration, primaryAction: nil)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        
        return button
    }()
    
    private lazy var infoButton: UIButton = {
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 14)

        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Info", attributes: container)
        configuration.image = UIImage(systemName: "info.circle")
        
        configuration.imagePlacement = .top
        configuration.imagePadding = 8
        let button = UIButton(configuration: configuration, primaryAction: nil)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        
        button.addTarget(self, action: #selector(tapInfoButton(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var playButton: UIButton = {
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 16, weight: .semibold)

        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Play", attributes: container)
        configuration.image = UIImage(systemName: "play.fill")
        
        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .label
        button.tintColor = UIColor(named: "themeColor1")

        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(tapPlayButton(sender:)), for: .touchUpInside)

        return button
    }()

    private let heroImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private func addGradient() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(barStackView)
        barStackView.addArrangedSubview(saveButton)
        barStackView.addArrangedSubview(playButton)
        barStackView.addArrangedSubview(infoButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let barStackViewConstraints = [
            barStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            barStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ]
        
        let saveButtonConstraints = [
            saveButton.widthAnchor.constraint(equalToConstant: 60),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        ]

        let infoButtonConstraints = [
            infoButton.widthAnchor.constraint(equalToConstant: 60),
            infoButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let playButtonConstraints = [
            playButton.heightAnchor.constraint(equalToConstant: 40),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        NSLayoutConstraint.activate(barStackViewConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(infoButtonConstraints)
        NSLayoutConstraint.activate(saveButtonConstraints)
    }
    
    public func configure(with model: Item) {
        self.headerItem = model
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterPath ?? "")") else {
            return
        }

        DispatchQueue.main.async {
            let transformer = SDImageResizingTransformer(size: CGSize(width: super.bounds.width, height: 450), scaleMode: .aspectFill)
            self.heroImageView.sd_setImage(with: url, placeholderImage: nil, context: [.imageTransformer: transformer])
        }
                
     
    }
    
    @objc
    func tapInfoButton(sender: UIButton) {
        homeVCDelegate?.moveToDetailPage(model: self.headerItem, fromTableHeader: true, isPlayOnly: false)
    }
    
    @objc
    func tapPlayButton(sender: UIButton) {
        homeVCDelegate?.moveToDetailPage(model: self.headerItem, fromTableHeader: true, isPlayOnly: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }


}
