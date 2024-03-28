//
//  GetCustomerService.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/18/24.
//

import Foundation
import Combine

class GetCustomerService {
    func getCustomers(completion: @escaping (Result<[Cust], Error>) -> Void) {
        guard let getCustomerURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.getCustomer)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: getCustomerURL)
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
                let customers = try JSONDecoder().decode([Cust].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(customers))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func updateCustomer(city: String, custLat: Double, custLong: Double, customerName: String, pickupTime: String, state: String, streetAddress: String, zip: String, customerId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let updateCustomerURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.updateCustomer)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: updateCustomerURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "City": city,
            "Cust_Lat": custLat,
            "Cust_Log": custLong,
            "CustomerName": customerName,
            "PickupTime": pickupTime,
            "State": state,
            "StreetAddress": streetAddress,
            "Zip": zip,
            "CustomerId": customerId
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
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
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        completion(.success(true))
                    }
                    print("\(customerName)")
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
    
    func addCustomer(customerName: String, streetAddress: String, city: String, state: String, zip: String, custLat: Double, custLong: Double, pickupTime: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let addCustomerURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.addCustomer)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: addCustomerURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let custLat: Double = 40.7544543
        let custLong: Double = -89.5327948

        let body: [String: Any] = [
            "City": city,
            "Cust_Lat": custLat,
            "Cust_Log": custLong,
            "CustomerName": customerName,
            "PickupTime": pickupTime,
            "State": state,
            "StreetAddress": streetAddress,
            "Zip": zip
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
    
    func deleteCustomer(customerId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let deleteCustomerURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.deleteCustomer)/?CustomerId=\(customerId)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: deleteCustomerURL)
        
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
