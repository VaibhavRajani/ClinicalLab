//
//  RouteDetailService.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/12/24.
//

import Combine
import Foundation

class RouteDetailService {
    func getRouteDetail(routeNumber: Int, completion: @escaping (Result<[RouteDetailResponse], Error>) -> Void) {
        
        guard let routeDetailURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.getRouteDetail)/?RouteNumber=\(routeNumber)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: routeDetailURL)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Int] = ["RouteNumber": routeNumber]
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            let jsonString = String(data: data, encoding: .utf8)
            print("\(String(describing: jsonString))")
            
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
    
    func getDriverLocation(driverId: Int, completion: @escaping (Result<DriverLocation, Error>) -> Void) {
        
        guard let routeDetailURL = URL(string: "\(Configuration.baseURL)\(Configuration.Endpoint.getDriverLocation)?DriverId=\(driverId)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: routeDetailURL)
        
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
                let locations = try JSONDecoder().decode([DriverLocation].self, from: data)
                print("\(String(describing: locations))")
                if let location = locations.first {
                    DispatchQueue.main.async {
                        completion(.success(location))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(URLError(.cannotParseResponse)))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

