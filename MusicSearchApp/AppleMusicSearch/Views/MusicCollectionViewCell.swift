//
//  MusicCollectionViewCell.swift
//  AppleMusicSearch
//
//  Created by 김건우 on 11/30/23.
//

import UIKit

import Then
import SnapKit
import ReactorKit
import RxSwift
import Kingfisher

class MusicCollectionViewCell: UICollectionViewCell, ReactorKit.View {
    // MARK: - Views
    private let songNameLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .headline)
        $0.numberOfLines = 1
    }
    
    private let artistNameLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .caption1)
        $0.numberOfLines = 1
    }
    
    private let coverImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 15.0
        $0.clipsToBounds = true
    }
    
    // MARK: - Properties
    var disposeBag: DisposeBag = DisposeBag()
    var musicCellReactor: MusicCellReactor?
    
    // MARK: - Intializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func bind(reactor: MusicCellReactor) { 
        if let url = URL(string: reactor.currentState.coverImageUrl ?? "") {
            coverImageView.kf.setImage(with: .network(url))
        }
        songNameLabel.text = reactor.currentState.songName
        artistNameLabel.text = reactor.currentState.artistName
    }
    
    func setupUI() {
        self.addSubview(songNameLabel)
        self.addSubview(artistNameLabel)
        self.addSubview(coverImageView)
    }
    
    func setupConstraint() {
        coverImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(self.snp.height).multipliedBy(0.75)
        }
        
        songNameLabel.snp.makeConstraints {
            $0.top.equalTo(coverImageView.snp.bottom).offset(8)
            $0.leading.equalTo(self.snp.leading).offset(8)
            $0.trailing.equalTo(self.snp.trailing).offset(-8)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        artistNameLabel.snp.makeConstraints {
            $0.top.equalTo(songNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(self.snp.leading).offset(8)
            $0.trailing.equalTo(self.snp.trailing).offset(-8)
            $0.centerX.equalTo(self.snp.centerX)
        }
    }
    
    func setupAttributes() { }
}
