import UIKit
import Flutter

class TeamViewController: UITableViewController {
  
  var team : Array<FLTPlayer>?
  
  private var appDelegate : AppDelegate? {
    get {
      return UIApplication.shared.delegate as! AppDelegate?
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    team = appDelegate!.team
    tableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
  }
    
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let team = team {
      return team.count
    } else {
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
    let player = team![indexPath.row]
    cell.textLabel!.text = player.name
    cell.detailTextLabel?.text = "";
    if let isLiked = player.isLiked {
      if (isLiked.boolValue) {
        cell.detailTextLabel?.text = "❤️";
      }
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let player = team![indexPath.row]
    appDelegate?.api2flutter?.show(player, completion: { (error : Error?) in
      if let error = error {
        NSLog("error: %@", error.localizedDescription)
      } else {
        let vc = FlutterViewController(engine: self.appDelegate!.engine!, nibName: nil, bundle: nil)
        let navigationController = self.parent as! UINavigationController?
        navigationController?.pushViewController(vc, animated: true)
      }
    })
  }
}
