//
//  HomeViewController.swift
//  IOSProject
//
//  Created by Ryan Stich on 2021-03-12.
//

import UIKit
import EventKit
import EventKitUI

class HomeViewController: UIViewController, EKEventViewDelegate{

    
    let store = EKEventStore()
    
    @IBOutlet weak var workout: UIButton!
    @IBOutlet weak var schedule: UIButton!
    
    
    @IBOutlet weak var imageView: UIImageView!
    let label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.layer.cornerRadius = 10
        label.frame = CGRect(x: 7.5, y: imageView.bounds.origin.y, width: 300, height: 285)
        label.textAlignment = .left
        label.text = "High Energy HIIT"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        self.imageView.addSubview(label)
        workout.layer.cornerRadius = 7.5
        schedule.layer.cornerRadius = 7.5
        workout.layer.borderWidth = 1.5
        workout.layer.borderColor = UIColor.white.cgColor
        schedule.layer.borderWidth = 1.5
        schedule.layer.borderColor = UIColor.white.cgColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func fitness()  {
        store.requestAccess(to: .event) { [weak self]  (success, err) in
            if success, err == nil {
                DispatchQueue.main.async {
                    
                    guard let store = self?.store else {return}
                    
                    let newEvent = EKEvent(eventStore: store)
                    
                    newEvent.title =  "New Workout"
                    newEvent.startDate = Date()
                    let vc = EKEventViewController()
                    vc.delegate = self
                    vc.event = newEvent
                    self?.present(vc, animated: true)
                }
            }
        }
    }
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        
    }
    @IBAction func event(_ sender: Any) {
        fitness()
    }
    
}
