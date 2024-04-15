//
//  GetVehicleService.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/20/24.
//

import Foundation

class GetVehicleService {
    func getVehicles(completion: @escaping (Result<[Vehicle], Error>) -> Void) {
        guard let getVehicleURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.getVehicle)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: getVehicleURL)
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
                let vehicles = try JSONDecoder().decode([Vehicle].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(vehicles))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func updateVehicle(manufacturer: String, model: String, plateNumber: String, vehicleId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let updateVehicleURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.updateVehicle)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: updateVehicleURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "Manufacturer": manufacturer,
            "Model": model,
            "PlateNumber": plateNumber,
            "VehicleId": vehicleId
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
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        completion(.success(true))
                    }
                    print("\(vehicleId)")
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
    
    func addVehicle(manufacturer: String, model: String, plateNumber: String, vehicleId: Int,  completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let addVehicleURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.addVehicle)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: addVehicleURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "Manufacturer": manufacturer,
            "Model": model,
            "PlateNumber": plateNumber,
            "VehicleId": vehicleId
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
    
    func deleteVehicle(vehicleId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        guard let deleteVehicleURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.deleteVehicle)?VehicleId=\(vehicleId)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: deleteVehicleURL)
        
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
