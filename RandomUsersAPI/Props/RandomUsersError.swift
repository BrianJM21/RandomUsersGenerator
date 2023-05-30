//
//  Error.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 29/03/23.
//

import Foundation

enum RandomUsersError: Error {
    
    case apiCallError
    case dataNilError
    case dataDecodeError
}

extension RandomUsersError: LocalizedError {
    
    public var errorDescription: String? {
        
        switch self {
            
        case .apiCallError: return NSLocalizedString("Error al llamar al API", comment: "")
            
        case .dataNilError: return NSLocalizedString("Error, datos vacios", comment: "")
            
        case .dataDecodeError: return NSLocalizedString("Error, no se pudo decodificar respuesta de la API", comment: "")
        }
    }
}
