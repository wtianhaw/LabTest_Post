//
//  PostListVC.swift
//  LabTest
//
//  Created by Wong Tian Haw on 20/03/2022.
//

import UIKit
import Combine

class PostListVC: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var postVm: PostVM = {
        return PostVM()
    }()
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "My Post Cards"
        postVm.apply(.list)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindVM()
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UIColor(named: "theme")
        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.standardAppearance = barAppearance
        navigationItem.scrollEdgeAppearance = barAppearance
        self.navigationController?.navigationBar.barTintColor = .white
        self.view.backgroundColor = UIColor(named: "theme_bg")
        self.collectionView.backgroundColor = UIColor(named: "theme_bg")
    }
    
    private func setupUI(){
        //        searchBar.placeholder = "Search your image by keywords"
        self.navigationController?.navigationBar.barTintColor = .black
        self.title = "My Post Cards"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PostCell.getNib(), forCellWithReuseIdentifier: PostCell.identifier)
        
        self.collectionView.bindHeadRefreshHandler({ [weak self] in
            guard let `self` = self else { return }
            if !self.collectionView.headRefreshControl.isTriggeredRefreshByUser {
                self.postVm.apply(.list)
            }
            
        }, themeColor: .gray, refreshStyle: .replicatorCircle)
        
        self.collectionView.bindFootRefreshHandler({ [weak self] in
            guard let `self` = self else { return }
            
            if !self.collectionView.footRefreshControl.isTriggeredRefreshByUser {
                
                self.postVm.apply(.getMoreData)
            }
            
        }, themeColor: .gray, refreshStyle: .replicatorCircle)
    }
    
    private func bindVM(){
        
        self.postVm.bindHeaderRefreshCtrl(self.collectionView.headRefreshControl)
        self.postVm.bindFooterRefreshCtrl(self.collectionView.footRefreshControl)
        
        self.postVm.$searchResultList
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] list in
                guard let `self` = self else { return }
                self.collectionView.reloadData()
            })
            .store(in: &self.cancellables)
    }
    
}

extension PostListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.postVm.searchResultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.identifier, for: indexPath) as? PostCell {
            cell.model = self.postVm.searchResultList[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  15
        let cellwidth = (collectionView.frame.size.width - padding) / 2
        let height = (screenSize.height < 670.0) ? screenSize.height / 1.5 :  screenSize.height / 2
        
        print(screenSize)
        return CGSize(width: cellwidth, height: height)
    }
    
}

extension UINavigationController {
    func transparentNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
    
    func setTintColor(_ color: UIColor) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
        self.navigationBar.tintColor = color
    }
    
    func backgroundColor(_ color: UIColor) {
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.barTintColor = color
        navigationBar.shadowImage = UIImage()
    }
}
