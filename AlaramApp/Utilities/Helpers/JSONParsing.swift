//
//  JSONParsing.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 16/07/2025.
//

import Foundation

func decode<T: Decodable>(_ data: Data) -> (decodedType: T?, error: Error?) {
    do {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(T.self, from: data)
        return (decoded, nil)
    } catch {
        debugPrint(error)
        return (nil, error)
    }
}

func encode<T: Encodable>(_ value: T) -> (data: Data?, error: Error?) {
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(value)
        return (data, nil)
    } catch {
        debugPrint(error)
        return (nil, error)
    }
}

func getData<T: Decodable>(from file: String) -> T? {
    guard let fileURL = Bundle.main.url(forResource: file, withExtension: "json") else {
        fatalError("\(file).json not found!")
    }
    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(T.self, from: data)
        print("\(file).json data: \n\(decoded)")
        return decoded
    } catch {
        debugPrint(error)
        return nil
    }
}
