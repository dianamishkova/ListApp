//
//  ViewController.swift
//  ListApp
//
//  Created by Диана Мишкова on 19.10.24.
//

import UIKit

class ListVC: UIViewController {
    
    enum Section {
        case main 
    }

    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createSingleColumnFlowLayout(in: view))
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseID)
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, PhotoTypeDtoOut> = {
        var dataSource = UICollectionViewDiffableDataSource<Section, PhotoTypeDtoOut>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseID, for: indexPath) as! ItemCell
            cell.set(item: item)
            return cell
        })
        return dataSource
    }()
    
    private var items: [PhotoTypeDtoOut] = []
    private var currentPage = 0
    private var pagesCount: Int32 = 0
    private var typeId: Int32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        getItems(page: currentPage)
    }

    private func layoutUI() {
        view.addSubview(collectionView)
    }

    private func getItems(page: Int) {
        NetworkManager.shared.getItems(page: page) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let items):
                self.pagesCount = items.totalPages
                self.items.append(contentsOf: items.content)
                self.updateData()
            case .failure(let error):
                print(error.rawValue)
            }
            
        }
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PhotoTypeDtoOut>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
}

extension ListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            currentPage += 1
            if currentPage > pagesCount {
                return
            }
            getItems(page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        typeId = items[indexPath.row].id
        presentCameraController()
    }
    
    private func presentCameraController() {
        let cameraController = CameraVC()
        cameraController.typeId = typeId
        cameraController.configure()
        present(cameraController, animated: true)
    }
    
}
