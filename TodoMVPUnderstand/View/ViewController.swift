//
//  ViewController.swift
//  TodoMVPUnderstand
//
//  Created by 滝野翔平 on 2022/08/21.
//

import UIKit

// MARK: -- View
class ViewController: UIViewController {
    
    
    @IBOutlet weak var TodoInput: UITextField!
    @IBOutlet weak var PlusButton: UIButton!
    @IBOutlet weak var tableCell: UIView!
    
    private var presenter: PresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        presenter.didTapAddButton(todoText: TodoInput.text)
    }
}

extension ViewController: UITableViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfTodo
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.TodoInput?.text = presenter.todo(forRow: indexPath.row)?.todo
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let todo = presenter.todo(forRow: indexPath.row) else {
            return
        }
        let alert = UIAlertController(title: "『\(todo.todo)』を削除しますか？", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            //OKボタン
            self.presenter.didTapTodoCell(at: indexPath)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: PresenterOutput {
    
    func updateTodo() {
        TodoInput.text = ""
        tableCell.reloadData()
    }
    
    func todoValidation(validation: TodoValidation) {
        self.TodoInput.text = ""
        let alert = UIAlertController(title: validation.alert, message: "", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
