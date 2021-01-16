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
    @IBOutlet weak var mainTitleLabel: UILabel!
    
    @IBOutlet weak var selectButton: UIButton!
    
    var cellModels: [ServiceCellModel] = []
    var services: [Service] = []
    var checkBool: [Int] = []

  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.registerNib(ServiceCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchServiceData()
        cellModels = createCellModels(services: services)
        mainTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        selectButton.backgroundColor = .systemBlue
        selectButton.setTitle("Выбрать", for: .normal)
        selectButton.layer.cornerRadius = 8
        selectButton.setTitleColor(.white, for: .normal)
        
    

    }
    
    @IBAction func selectBtn(_ sender: Any) {
        
        let check = self.checkBool
        
        if check == [0] {
            let alert = UIAlertController(title: "", message: "хотите приобрести пакет XL", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "Да", style: .default, handler: nil)
            let cnclBtn = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alert.addAction(okBtn)
            alert.addAction(cnclBtn)
            
            present(alert, animated: true, completion: nil)
            
        } else if check == [1] {
            let alert = UIAlertController(title: "", message: "хотите приобрести пакет Выделение", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "Да", style: .default, handler: nil)
            let cnclBtn = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alert.addAction(okBtn)
            alert.addAction(cnclBtn)
            
            present(alert, animated: true, completion: nil)

        } else {
            let alert = UIAlertController(title: "", message: "Выберите пакет", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "Ок", style: .default, handler: nil)
            alert.addAction(okBtn)
            
            present(alert, animated: true, completion: nil)

        }
        
    }
    
    
    private func createCellModels(services: [Service]) -> [ServiceCellModel] {
        let cellModels = services.map {
            ServiceCellModel(serviceImageURL: URL(string: $0.icon.the52X52),
                             serviceTitle: $0.title,
                             serviceText: $0.listDescription ?? "",
                             servicePrice: $0.price,
                             isSelected: false)
            
        }
//        cellModels.first?.isSelected = true
        return cellModels
    }
    
  
    
    private func fetchServiceData() {
        let path = Bundle.main.path(forResource: "result", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do  {
            let data = try Data(contentsOf: url)
            let results = try JSONDecoder().decode(Main.self, from: data)
            let mainTitle = results.result.title
            

            self.services = results.result.list
            self.mainTitleLabel.text = mainTitle
            
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        cellModels.forEach { $0.isSelected = false }
        let model = cellModels[indexPath.item]
        model.isSelected.toggle()
        print([indexPath.item])
        self.checkBool = [indexPath.item]
        
        
//        cellModels.forEach { $0.isSelected = false }
//        let model = cellModels[indexPath.item]
//        model.isSelected = true
        collectionView.reloadData()
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

