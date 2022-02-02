//
//  Encodable.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//

import Foundation


extension Encodable {

    public func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return jsonObject.flatMap { $0 as? [String: Any] } ?? [:]

    }

    public func toData() -> Data? {
        try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted)
    }
}
