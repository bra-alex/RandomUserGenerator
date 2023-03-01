//
//  RandomUserController.swift
//  RandomUserGenerator
//
//  Created by Don Bouncy on 01/03/2023.
//

import Foundation

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
    }
    
    struct Location: Codable{
        let street: Street
        let city: String
        let state: String
        let country: String
        let postcode: String
        
        struct Street: Codable{
            let number: Int
            let name: String
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
            
            if res.statusCode == 200{
                if let decodedData = try? JSONDecoder().decode([String: [User]].self, from: data){
                    DispatchQueue.main.async {
                        self.user = decodedData["results"]?.first
                    }
                }
            }
        } catch {
            print("Could't fetch data")
        }
        
    }
}
