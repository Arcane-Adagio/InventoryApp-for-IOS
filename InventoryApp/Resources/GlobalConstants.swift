//
//  GlobalConstants.swift
//  InventoryApp
//
//  Created by Patrick Coleman on 2/9/23.
//

import Foundation

/* This file is the main file for persistent variables that need to be accessed app-wide
* this is to maintain consistency and minimize potential for typo errors.
 */

public class GlobalConstants {
    public static let dbEmptyValues = ["None", "null", "", "[]"]
    public static let dbLoginSuccessful = "Login Successful"
    public static let dbMaxGroupnameLength = 15
    public static let sampleINVENTORYNAME = "Inventory"
    public static let dbMaxCodeLength = 15
    public static var online = true
    public static let exportAction = "com.example.inventoryapp.share"
    public static let dbMaxPasswordLength = 15
    public static let fragementArgInventoryNAME = "inventoryName"
    public static let SharedPrefFILENAME = "com.example.inventoryapp.LOCALINVENTORY"
    public static let outOfBounds = -1
    public static let onlineKeyGROUPID = "groupID"
    public static let onlineKeyGROUPNAME = "groupName"
    public static let onlineKeyINVENTORYNAME = "inventoryName"
    public static let onlineKeyINVENTORYID = "inventoryID"
    public static let keySHAREDINVENTORY = "SharedInventory"
    public static let firebaseKeyGROUPS = "Groups"
    public static let firebaseKeyINVENTORIES = "Inventories"
    public static let firebaseKeyINVENTORYITEMS = "Items"
    public static let firebaseKeyMEMBERS = "Members"
    public static let firebaseSubkeyGROUPOWNER = "groupOwner"
    public static let firebaseSubkeyINVENTORYNAME = "inventoryName"
    public static let firebaseSubkeyGROUPCODE = "groupCode"
    public static let firebaseSubkeyMEMBERS = "Members"
    public static let firebaseSubkeyGROUPNAME = "groupName"
    public static let firebaseSubkeyITEMDATE = "itemDate"
    public static let firebaseSubkeyITEMNEEDFUL = "itemNeedful"
    public static let firebaseSubkeyITEMQUANTITY = "itemQuantity"
    public static let firebaseSubkeyITEMNAME = "itemName"
    public static let firebaseSubkeyHASHEDPASSWORD = "groupPasswordHashed"
    public static let defaultItemName = ""
}
