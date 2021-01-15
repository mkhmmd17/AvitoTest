//
//  ViewController.swift
//  TestAV
//
//  Created by muslim on 14.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    typealias Service = List
    
    @IBOutlet private var collectionView: UICollectionView!
    var cellModels: [ServiceCellModel] = []
    var services: [Service] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.registerNib(ServiceCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchServiceData()
        cellModels = createCellModels(services: services)

    }
    
    private func createCellModels(services: [Service]) -> [ServiceCellModel] {
        return services.map {
            ServiceCellModel(serviceImageURL: URL(string: $0.icon.the52X52),
                             serviceTitle: $0.title,
                             serviceText: $0.listDescription ?? "",
                             servicePrice: $0.price,
                             isSelected: $0.isSelected)
        }
    }
    
    private func fetchServiceData() {
        let path = Bundle.main.path(forResource: "result", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do  {
            let data = try Data(contentsOf: url)
            let results = try JSONDecoder().decode(Main.self, from: data)
            self.services = results.result.list
            print (results)
        } catch {
            print(error.localizedDescription)
        }
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = cellModels[indexPath.item]
        let cell = collectionView.dequeue(ServiceCell.self, indexPath: indexPath)
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = cellModels[indexPath.item]
        return ServiceCell.cellSize(text: model.serviceText,
                                    attributes: [.font : UIFont.systemFont(ofSize: 16)])
    }
    
}

