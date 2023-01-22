//
//  thirdViewController.swift
//  #5 picket DZ
//
//  Created by Andrew on 14/01/23.
//

import UIKit

class thirdViewController: UIViewController {
    weak var delegate: twoVC?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var instaTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var addFriendButton: UIBarButtonItem!
    
    var dateOfBirthdayPicker = UIDatePicker()
    var agePicker = UIPickerView()
    var genderPicker = UIPickerView()
    
    let genders = ["Мужчина","Женщина"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instaTextField.placeholder = "Введите Инстаграм друга"
        nameTextField.placeholder = "Введите имя друга"
        dateTextField.placeholder = "Выберите дату рождения"
        ageTextField.placeholder = "Выберите возраст"
        genderTextField.placeholder = "Выберите пол"
        
        //DatePicker
        dateTextField.inputView = dateOfBirthdayPicker
        dateOfBirthdayPicker.preferredDatePickerStyle = .wheels
        dateOfBirthdayPicker.locale = .init(identifier: "Russian")
        datePicketParam()

        createPicker()
        
        //PickerView
        genderPicker.tag = 0
        agePicker.tag = 1
        
        genderTextField.inputView = genderPicker
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        ageTextField.inputView = agePicker
        agePicker.delegate = self
        agePicker.dataSource = self
    }
    
    func datePicketParam () {
        // создаем тул бар
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //создаем бар баттон
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDateAction))
        toolbar.setItems([doneButton], animated: true)
        //добавляем тул бар
        dateTextField.inputAccessoryView = toolbar
        dateOfBirthdayPicker.datePickerMode = .date
    }
    
    func createPicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneAction))
        toolbar.setItems([doneButton], animated: true)
        
        ageTextField.inputAccessoryView = toolbar
        genderTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneDateAction () {
        //выбираем формат
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none

        dateTextField.text = formatter.string(from: dateOfBirthdayPicker.date)
        //убрать пикер по кнопке done
        view.endEditing(true)
    }
    @objc func doneAction(){
        // убрать пикер по кнопке
        view.endEditing(true)
    }
    
    
    //Алер ошибки если инста не введена
    func errorInst () {
        let  alert = UIAlertController(title: "Ошибка", message: "Введите инстаграм", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }

    //Алерт с внесением инсты
    @IBAction func instaAlert(_ sender: Any, forEvent event: UIEvent) {
        let alert = UIAlertController(title: "Введите instagram", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Отменить", style: .default))
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if alert.textFields?.first?.text == "" {
                self.errorInst()
            } else {
                self.instaTextField.text = alert.textFields?.first?.text
            }
        })
        
        alert.addTextField { text in
            text.placeholder = "Поле для ввода"
        }
        self.present(alert, animated: true, completion: nil)
    }
    

    // Back twoVC c алертом ошибки
    @IBAction func addFriendButtonAction(_ sender: Any) {
        if nameTextField.text == "" || dateTextField.text == "" || ageTextField.text == "" || instaTextField.text == "" {
            let alert = UIAlertController(title: "НЕ ВСЕ ЗАПОЛНЕНО", message: "Заполните все поля верно", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        } else {
            delegate?.update(name: nameTextField.text!, age: ageTextField.text!, date: dateTextField.text!)
            
            print ("workkkkkkkkkkkkkk")
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true)
        }
    }

    
    // Test method back to TwoVC
    @IBAction func nazadButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    //Method close keyBoard если тыкнуть на экрану
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        nameTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        genderTextField.resignFirstResponder()
        instaTextField.resignFirstResponder()
    }
}


extension thirdViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0: return genders.count
        case 1: return 100
        default: return 0
        }
    }
}

extension thirdViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0: return genders[row]
        case 1: return "\(row + 1)"
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0: genderTextField.text = genders[row]
        case 1: ageTextField.text = "\(row + 1)"
        default: return
        }
    }
}
