//
//  GetDriverService.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/17/24.
//

import Combine
import Foundation

class GetDriverService{
    func getDrivers(completion: @escaping (Result<[Driver], Error>) -> Void) {
        guard let getDriverURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.getDriver)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: getDriverURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
                return
            }
            
            do {
                let drivers = try JSONDecoder().decode([Driver].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(drivers))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func updateDriver(driverId: Int, firstName: String, lastName: String, phoneNumber: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let updateDriverURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.updateDriver)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: updateDriverURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "DriverId": driverId,
            "FirstName": firstName,
            "LastName": lastName,
            "PhoneNumber": phoneNumber
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard data != nil else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
                return
            }
            
            do {
                // Assuming the response is just a success/failure without additional data
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        completion(.success(true))
                    }
                    print("\(firstName)")
                } else {
                    throw URLError(.badServerResponse)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func addDriver(firstName: String, lastName: String, phoneNumber: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let addDriverURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.addDriver)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: addDriverURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "FirstName": firstName,
            "LastName": lastName,
            "PhoneNumber": phoneNumber
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(true))
            }
        }.resume()
    }
    
    func deleteDriver(driverId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        guard let deleteDriverURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.deleteDriver)/?DriverId=\(driverId)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: deleteDriverURL)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        completion(.success(true))
                    }
                } else if httpResponse.statusCode == 400 {
                        DispatchQueue.main.async {
                        completion(.failure(URLError(.cannotParseResponse)))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(URLError(.badServerResponse)))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
            }
        }.resume()
    }
}

