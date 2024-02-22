//
//  GetRouteService.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/21/24.
//

import Foundation
import Combine

class GetRouteService {
    func getRoute(completion: @escaping (Result<[RouteDetailResponse], Error>) -> Void) {
        guard let url = URL(string: "https://pclwebapi.azurewebsites.net/api/Route/GetRoute") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
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
                let routeDetails = try JSONDecoder().decode([RouteDetailResponse].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(routeDetails))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func updateRoute(customerIDs: String, driverId: Int, routeName: String, vehicleNo: String, routeNo: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "https://pclwebapi.azurewebsites.net/api/Route/EditRoute") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "CustomerID": customerIDs,
            "DriverId": driverId,
            "RouteName": routeName,
            "VehicleNo": vehicleNo,
            "RouteNo": routeNo
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
            }
        }.resume()
    }
    
    func addRoute(customerIDs: String, driverId: Int, routeName: String, vehicleNo: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://pclwebapi.azurewebsites.net/api/Route/AddRoute") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "CustomerID": customerIDs,
            "DriverId": driverId,
            "RouteName": routeName,
            "VehicleNo": vehicleNo
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                  let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
                return
            }
            
            do {
                if let resultDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
                   let result = resultDict["Result"] {
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } else {
                    throw URLError(.cannotParseResponse)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func deleteRoute(routeNo: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "https://pclwebapi.azurewebsites.net/api/Route/DeleteRoute/?RouteNumber=\(routeNo)") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
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
