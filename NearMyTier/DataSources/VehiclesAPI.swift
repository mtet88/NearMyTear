//
//  VehiclesAPI.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 22.05.21.
//

import Foundation

struct VehiclesAPI {
    
    func fetchVehicles(completion: @escaping ([Vehicle]) -> Void) {

        guard let url = URL(string: Constants.vehiclesURL) else {
            print("URL NOT VALID")

            DispatchQueue.main.async {
                completion([])
            }

            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.secret, forHTTPHeaderField: Constants.secretKey)
        request.setValue(Constants.content, forHTTPHeaderField: Constants.contentKey)

        let dataTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in

            guard let _data = data else {
                print("RESPONSE DATA NIL")

                DispatchQueue.main.async {
                    completion([])
                }

                return
            }

            do {
                let decoded = try JSONDecoder().decode(APIResponse.self, from: _data)
                let vehicles = decoded.data.current.compactMap { Vehicle(with: $0) }

                DispatchQueue.main.async {
                    completion(vehicles)
                }

            } catch (let error) {
                print(error)
            }
        }

        dataTask.resume()
    }
}

