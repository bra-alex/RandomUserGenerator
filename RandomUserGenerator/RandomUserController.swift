//
//  RandomUserController.swift
//  RandomUserGenerator
//
//  Created by Don Bouncy on 01/03/2023.
//

import Foundation

struct Results: Codable{
    let results: [User]
}

struct User: Codable{
    let dob: DOB
    let name: Name
    let nat: String
    let cell: String
    let phone: String
    let email: String
    let gender: String
    let picture: Picture
    let location: Location
    let registered: Registered
    
    struct Name: Codable{
        let title: String
        let first: String
        let last: String
        
        var fullName: String{
            "\(title) \(first) \(last)"
        }
    }
    
    struct Location: Codable{
        let street: Street
        let city: String
        let state: String
        let country: String
        let postcode: String
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<User.Location.CodingKeys> = try decoder.container(keyedBy: User.Location.CodingKeys.self)
            self.street = try container.decode(User.Location.Street.self, forKey: User.Location.CodingKeys.street)
            self.city = try container.decode(String.self, forKey: User.Location.CodingKeys.city)
            self.state = try container.decode(String.self, forKey: User.Location.CodingKeys.state)
            self.country = try container.decode(String.self, forKey: User.Location.CodingKeys.country)
            if let code = try? container.decode(Int.self, forKey: User.Location.CodingKeys.postcode) {
                self.postcode = String(code)
                    } else {
                        self.postcode = try container.decode(String.self, forKey: User.Location.CodingKeys.postcode)
                    }
        }
        
        struct Street: Codable{
            let number: Int
            let name: String
            
            var fullStreet: String{
                "\(number) \(name)"
            }
        }
    }
    
    struct DOB: Codable{
        let date: Date
    }
    
    struct Registered: Codable{
        let date: Date
    }
    
    struct Picture: Codable{
        let large: String
    }
}

class RandomUserController: ObservableObject {
    @Published var user: User?
    
    func loadData() async {
        guard let url = URL(string: "https://randomuser.me/api/") else {
            print("Couldn't parse url")
            return
        }
        
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            let res = response as! HTTPURLResponse
            print(res.statusCode)
            
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            if res.statusCode == 200{
                let decodedData = try decoder.decode(Results.self, from: data)
                    DispatchQueue.main.async {
                        self.user = decodedData.results.first
                    }
                
            }
        } catch {
            print(String(describing: error))
        }
        
    }
}
