import Foundation

class Storage {
    
    @AppDataStorage(key: "linkmodel", defaultValue: [])
    static var storedTitleAndLinkArray : [LinkModel]
}

@propertyWrapper
struct AppDataStorage <T: Codable> {
    private let key : String
    private let defaultValue: T
    
    init(key: String, defaultValue: T){
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue : T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return defaultValue
            }
            
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}


struct LinkModel: Decodable, Encodable {
    var title : String
    var link : String
    
    //init(title: String, link: String) под капотом
    //self.title = title
    //self.link = link
}
