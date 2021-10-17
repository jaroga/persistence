import Foundation
import CoreLocation

struct GasStation: Decodable {
    let address: String
    let place: String
    let coordinates: CLLocationCoordinate2D
    let timetable: String
    let price: Double
    
    let idProduct: String
    let productName: String
    let shortProductName: String
    
    let idProvince: String
    let provinceName: String
    
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case address = "Dirección"
        case timetable = "Horario"
        case latitude = "Latitud"
        case longitude = "Longitud (WGS84)"
        case price = "PrecioProducto"
        case place = "Localidad"
        
        case idProduct = "IDProducto"
        case productName = "Nombre Producto"
        case shortProductName = "Nombre Corto Producto"
        
        case idProvince = "IDProvincia"
        case provinceName = "Nombre Provincia"
        
        case date = "Fecha"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        address = try values.decode(String.self, forKey: .address)
        place = try values.decode(String.self, forKey: .place)
        timetable = try values.decode(String.self, forKey: .timetable)
        
        let lat = try values.decode(String.self, forKey: .latitude).replacingOccurrences(of: ",", with: ".")
        let lon = try values.decode(String.self, forKey: .longitude).replacingOccurrences(of: ",", with: ".")
        
        let latDouble = Double(lat)!
        let lonDouble = Double(lon)!
        coordinates = CLLocationCoordinate2D(latitude: latDouble, longitude: lonDouble)
        
        let priceString = try values.decode(String.self, forKey: .price).replacingOccurrences(of: ",", with: ".")
        price = Double(priceString)!
        
        idProduct = try values.decode(String.self, forKey: .address)
        productName = try values.decode(String.self, forKey: .place)
        shortProductName = try values.decode(String.self, forKey: .timetable)
        
        idProvince = try values.decode(String.self, forKey: .address)
        provinceName = try values.decode(String.self, forKey: .place)
        
        date = Date() // try values.decode(Date.self, forKey: .date)
        
    }
}

extension GasStation: Identifiable {
    var id: UUID {
        return UUID()
    }
}

extension GasStation {
    init(cdGasStation: CDGasStation) {
        self.address = cdGasStation.address ?? "NO address"
        self.place = cdGasStation.place ?? "NO place"
        self.price = cdGasStation.price
        self.timetable = cdGasStation.timetable ?? "NO timetable"
        self.coordinates = CLLocationCoordinate2D(latitude: cdGasStation.latitude, longitude: cdGasStation.longitude)
        
        self.idProduct = cdGasStation.belongsProduct?.idProduct ?? "NO idProduct"
        self.productName = cdGasStation.belongsProduct?.productName ?? "NO productName"
        self.shortProductName = cdGasStation.belongsProduct?.shortProductName ?? "NO shortProductName"
        
        self.idProvince = cdGasStation.belongsProvince?.idProvince ?? "NO idProvince"
        self.provinceName = cdGasStation.belongsProvince?.provinceName ?? "NO provinceName"
        
        self.date = cdGasStation.belongsGasPrice?.date ?? Date()
    }
}
