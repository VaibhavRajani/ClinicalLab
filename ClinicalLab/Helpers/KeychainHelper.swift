//
//  KeychainHelper.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 5/17/24.
//

import Foundation
import Security
import CryptoKit

class KeychainHelper {
    static let shared = KeychainHelper()
    
    private init() {}
    
    private let key = SymmetricKey(size: .bits256)
    
    func savePassword(_ password: String, for username: String) {
        do {
            let passwordData = password.data(using: .utf8)!
            let sealedBox = try AES.GCM.seal(passwordData, using: key)
            let encryptedData = sealedBox.combined!
            
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: username,
                kSecValueData: encryptedData
            ] as CFDictionary
            
            SecItemDelete(query)
            let status = SecItemAdd(query, nil)
            print("Password saved to keychain")
            
            if status != errSecSuccess {
                print("Error saving password: \(status)")
            }
        } catch {
            print("Error encrypting password: \(error)")
        }
    }
    
    func getPassword(for username: String) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: username,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query, &item)
        
        if status == errSecSuccess {
            if let data = item as? Data {
                do {
                    let sealedBox = try AES.GCM.SealedBox(combined: data)
                    let decryptedData = try AES.GCM.open(sealedBox, using: key)
                    let password = String(data: decryptedData, encoding: .utf8)
                    print("Password fetched from Keychain: ", decryptedData )
                    return password
                } catch {
                    print("Error decrypting password: \(error)")
                }
            }
        } else {
            print("Error retrieving password: \(status)")
        }
        return nil
    }
    
    func deletePassword(for username: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: username
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}
