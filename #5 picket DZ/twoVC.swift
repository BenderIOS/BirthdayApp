//
//  twoVC.swift
//  #5 picket DZ
//
//  Created by Andrew on 07/01/23.
//

import UIKit
protocol twoVCDelegate: AnyObject {
    func update(name: String, age: String, date: String)
}

class twoVC: UIViewController, twoVCDelegate {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var AgeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? thirdViewController else { return}
        destination.delegate = self
    }
    
    func update(name: String, age: String, date: String) {
        print("gavno glavnoe stabotalo")
        nameLabel.text = name.capitalized
        AgeLabel.text = age + " лет"
        dateLabel.text = date

        //create foto
        let foto = UIImageView(frame: CGRect(x: 20, y: 135, width: 80, height: 80))
        foto.image = UIImage(named: "LINTi_NJEp4")
        foto.tintColor = .systemGray
        foto.layer.cornerRadius = 30
        foto.layer.masksToBounds = true
        self.view.addSubview(foto)
        
    }
}
