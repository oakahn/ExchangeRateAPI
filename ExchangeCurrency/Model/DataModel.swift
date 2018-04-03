import Foundation

class CurrencyModel{
    var name: String
    var rate: Double
    init(name:String, rate:Double) {
        self.name = name
        self.rate = rate
    }
}

class DataModel{
    var listModel = [CurrencyModel]()
}
