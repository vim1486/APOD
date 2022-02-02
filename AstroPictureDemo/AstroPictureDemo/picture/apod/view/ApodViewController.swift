//
//  ApodViewController.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//


import UIKit

class ApodViewController: UIViewController {
    
    var presentor:ViewToPresenterProtocol?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var table: UITableView!
    var currentDate = Date()
    var lastSelectedDate = Date()
    
    var apod:PictureModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentDate = Date()
        
        self.datePicker.maximumDate = self.currentDate
        self.datePicker.addTarget(self, action: #selector(self.pickedDate), for: .valueChanged)
        
        table.register(UINib(nibName: kPictureCellName, bundle: nil),
                       forCellReuseIdentifier: kPictureCellName)
        addTapGesture()
//        presentor?.startFetching(day: self.currentDate.toDateString())
        presentor?.startFetching(day: "1986-08-14")
        showProgressIndicator(view: self.view)
    }
    
    @objc private func pickedDate(picker: UIDatePicker) {
        self.lastSelectedDate = picker.date
    }
    
    @IBAction func sel_btnSearch(sender : UIButton) {
        if(self.lastSelectedDate != self.currentDate){
            presentor?.startFetching(day:self.lastSelectedDate.toDateString())
            self.currentDate = self.lastSelectedDate
        }
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGetstureDetected))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapGetstureDetected() {
        self.view.endEditing(true)
    }
}

extension ApodViewController:PresenterToViewProtocol {
    
    func showPicture(picture:PictureModel) {
        hideProgressIndicator(view: self.view)
        self.apod = picture
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    func showError() {
        hideProgressIndicator(view: self.view)
        let alert = UIAlertController(title: "Alert", message: "Error fetching picture.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ApodViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height * 0.9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kPictureCellName, for: indexPath) as! PictureCell
        
        if(self.apod != nil){
            cell.configure(picture: self.apod!)
            cell.onPlayClick = {(_ sender: UIButton) in
                // Play video here
                guard let playBackUrl = self.apod?.url else {
                    return
                }
                DispatchQueue.main.async {
                    if let url = URL(string: playBackUrl){
                        let presentVC = VideoPlaybackController.init(url: url)
                        self.present(presentVC, animated: true) {}
                    }
                }
            }
            
            return cell
        }
        
        return cell
    }
}
