import Foundation
import MapKit

// Earthquake model
// in mapkit we must use a class, not a struct, because we need to subclass NSObject for MapKit

struct QuakeResults: Decodable {
    let features: [Quake]
}

class Quake: NSObject, Decodable {

    // what info do we need for an earthquake?  Investigate by looking at the earthquake api from usgs
    // magnitude
    // place
    // time
    // coordinate
    
    let magnitude: Double
    let place: String
    let time: Date
    let latitude: Double
    let longitude: Double
    
    enum QuakeCodingKeys: String, CodingKey {
        case magnitude = "mag"
        case properties
        case place
        case time
        case latitude
        case longitude
        case geometry
        case coordinates
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuakeCodingKeys.self)
        let properties = try container.nestedContainer(keyedBy: QuakeCodingKeys.self, forKey: .properties)
        let geometry = try container.nestedContainer(keyedBy: QuakeCodingKeys.self, forKey: .geometry)
        // nested unkeyed container
        var coordinates = try geometry.nestedUnkeyedContainer(forKey: .coordinates)
        
        self.magnitude = try properties.decode(Double.self, forKey: .magnitude)
        self.place = try properties.decode(String.self, forKey: .place)
        self.time = try properties.decode(Date.self, forKey: .time)
        self.longitude = try coordinates.decode(Double.self)
        self.latitude = try coordinates.decode(Double.self)

        super.init()
    }
}
