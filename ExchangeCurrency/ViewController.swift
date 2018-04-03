import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController, IModelPresenter {
    @IBOutlet weak var tableViewCurrency: UITableView!
    let listModel:DataModel = DataModel()
    var name:[String] = []
    var rate:[Double] = []
    var refreshControl: UIRefreshControl! = UIRefreshControl()
    lazy var presenter = ModelPresenter(self)
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencySelectLabel: UILabel!
    @IBOutlet weak var rateCurrencyText: UILabel!
    @IBOutlet weak var inputText: UITextField!
    var totalRate:Double?
    var thaiBaht:Double?
    @IBOutlet weak var currentThaiBath: UILabel!
    
    func onGetExchangeRatesSuccess(responseData: DataModel) {
        name.removeAll()
        rate.removeAll()
        for i in 0...responseData.listModel.count - 1{
            name.append(responseData.listModel[i].name)
            rate.append(responseData.listModel[i].rate)
            if responseData.listModel[i].name == "THB"{
                thaiBaht = responseData.listModel[i].rate
                let rateThaiBaht = String(format:"%.2f", thaiBaht ?? 0)
                currentThaiBath.text = "1 USD = \(rateThaiBaht) THB"
            }
        }
        dataRefresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getName()
    }
    
    @objc func refreshTableView() {
        presenter.getName()
    }
    
    func dataRefresh(){
        refreshControl.addTarget(self, action:  #selector(refreshTableView), for: UIControlEvents.valueChanged)
        tableViewCurrency.addSubview(refreshControl)
        tableViewCurrency.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        if checkEmpty(){
            totalRate = (Double(rateCurrencyText.text!)!) * (Double(inputText.text!)! / (thaiBaht ?? 0))
            inputText.resignFirstResponder()
            alertConfirm()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return name.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataTableViewCell
        cell.nameCurrency.text = name[indexPath.row]
        cell.rateCurrency.text = String(rate[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currencyLabel.text = name[indexPath.row]
        currencySelectLabel.text = name[indexPath.row]
        rateCurrencyText.text = String(rate[indexPath.row])
    }
    
    func checkEmpty() -> Bool{
        if rateCurrencyText.text == "0" || inputText.text == ""{
            return false
        }
        return true
    }
    
    func alertConfirm(){
        let alert = UIAlertController(title: "OK", message: "Exchange  \(currencyLabel.text!)  with  \(inputText.text!)  บาท  ได้เป็นเงินจำนวน \(totalRate!) \(currencyLabel.text!)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

