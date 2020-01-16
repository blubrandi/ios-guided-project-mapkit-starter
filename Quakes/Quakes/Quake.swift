import Foundation
import MapKit

// Earthquake model
// in mapkit we must use a class, not a struct, because we need to subclass NSObject for MapKit

class Quake: NSObject, Decodable {

    // what info do we need for an earthquake?  Investigate by looking at the earthquake api from usgs
    // magnitude
    // place
    // time
    // coordinate
    
    let magnitude: Double
    let place: String
    let time: Date
    
    enum QuakeCodingKeys: String, CodingKey {
        case magnitude = "mag"
        case properties
        case place
        case time
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuakeCodingKeys.self)
        
        let properties = try container.nestedContainer(keyedBy: QuakeCodingKeys.self, forKey: .properties)
        self.magnitude = try properties.decode(Double.self, forKey: .magnitude)
        self.place = try properties.decode(String.self, forKey: .place)
        time = try properties.decode(Date.self, forKey: .time)

        super.init()
    }
}
