import Foundation
import Alamofire
import AlamofireObjectMapper

protocol IModelPresenter{
//    func onGetCurrency(responseData: ModelResponse)
    func onGetExchangeRatesSuccess(responseData: DataModel)
}

class ModelPresenter{

    var callBack: IModelPresenter
    
    init(_ view: IModelPresenter) {
        self.callBack = view
    }
    
    func getName(){
        let url = "https://v3.exchangerate-api.com/bulk/e7ff8a5935f9c94ec8311dbe/USD"
        Alamofire.request(url).responseJSON { (res) in
            res.result.ifSuccess {
                do{
                    if let data = res.data{
                      let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                      let rates = json!["rates"] as? [String: Any]
                      let dataModel = DataModel()
                      for (key,r) in rates! {
                           dataModel.listModel.append(CurrencyModel.init(name: key, rate: r as! Double))
                      }
                        self.callBack.onGetExchangeRatesSuccess(responseData: dataModel)
                      }
                   } catch {
                        print("Error deserializing JSON: \(error)")
                   }
            }
            res.result.ifFailure {
                print(res.error?.localizedDescription)
            }
//
//            do{
//                if let data = res.data{
//                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
//                    let rates = json!["rates"] as? [String: Any]
//                    let dataModel = DataModel()
//                    for (key,r) in rates! {
//                        dataModel.listModel.append(CurrencyModel.init(name: key, rate: r as! Double))
//                    }
//                    self.callBack.onGetExchangeRatesSuccess(responseData: dataModel)
//                }
//            } catch {
//                print("Error deserializing JSON: \(error)")
//            }
        }
    }
//    func getExchange(){
//            let url = "http://data.fixer.io/api/latest?access_key=773c58fde8c36cf15783d552e316bb32&format=1"
//            Alamofire.request(url).responseObject {
//                (response : DataResponse<ModelResponse>) in
//                self.callBack.onGetCurrency(responseData: response.value!)
//        }
//    }
}
