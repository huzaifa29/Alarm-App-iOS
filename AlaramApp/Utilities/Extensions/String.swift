//
//  String.swift
//  AlaramApp
//
//  Created by Hafiz Muhammad Junaid on 18/07/2025.
//

import Foundation

extension String {
    func isValid(for type: ValidatorType) -> String? {
        let validator = ValidatorFactory.validatorFor(type: type)
        do {
            _ = try validator.validated(self)
            return nil
        } catch(let error) {
            return (error as? ValidationError)?.message
        }
    }
}
