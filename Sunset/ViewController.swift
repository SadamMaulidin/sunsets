import UIKit

class ViewController: UIViewController, UITableViewDataSource {
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var sunriseLabel: UILabel!
	@IBOutlet weak var sunsetLabel: UILabel!
	@IBOutlet weak var daylengthLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let sun = Sun()
    var dataKeys = [String]()
    var dataValues = [Date]()
    var twentyFourHourClock = true
	

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
        
		NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reloadData(notification:)), name: Notification.Name("reloadData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.receiveLocation(notification:)), name: Notification.Name("receiveLocation"), object: nil)
        
        // Double tap
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
	}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sun.getDataCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        if self.dataValues.isEmpty{
            reusableCell.textLabel?.text = "Row \(indexPath.row)"
        }else{
            reusableCell.textLabel?.text = self.dataKeys[indexPath.row]
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "HH:mm"
            if !self.twentyFourHourClock{
                dateFormatter.dateFormat = "h:mm a"
            }
            
            reusableCell.detailTextLabel?.text = dateFormatter.string(from: self.dataValues[indexPath.row])
        }
        return reusableCell
    }
    @objc func doubleTapped(){
        self.twentyFourHourClock = !self.twentyFourHourClock
        self.tableView.reloadData()
    }
    
    /**
        Receives the notification that theres a new sun profile to be used
     */
    @objc func reloadData(notification:Notification){
		print("Reload notification recieved")
		presentSunData()
	}
    
    /**
        Receives the notification that theres a new location to be used
     */
    @objc func receiveLocation(notification:Notification){
        print("Present Location notification received")
        presentLocation()
    }
	
    /**
        Presents the new sun profile data in the view
     */
	func presentSunData(){
		DispatchQueue.main.async {
            self.dataKeys = self.sun.getKeys()
            self.dataValues = self.sun.getValues()
            self.tableView.reloadData()
		}
	}
    
    /**
        Presents the location in the view
     */
    func presentLocation(){
        DispatchQueue.main.async {
            self.locationLabel.text = self.sun.getLocation()
        }
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

