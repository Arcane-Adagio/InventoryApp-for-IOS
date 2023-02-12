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
    public static let db_emptyValues = ["None", "null", "", "[]"]
    public static let db_loginSuccessful = "Login Successful";
    public static let db_max_groupname_length = 15;
    public static let SAMPLE_INVENTORYNAME = "Inventory";
    public static let db_max_code_length = 15;
    public static var online = true;
    public static let EXPORT_ACTION = "com.example.inventoryapp.share"
    public static let db_max_password_length = 15
    public static let FRAGMENT_ARG_INVENTORY_NAME = "inventoryName"
    public static let SHARED_PREF_FILENAME = "com.example.inventoryapp.LOCALINVENTORY"
    public static let OUT_OF_BOUNDS = -1
    public static let ONLINE_KEY_GROUPID = "groupID"
    public static let ONLINE_KEY_GROUPNAME = "groupName"
    public static let ONLINE_KEY_INVENTORYNAME = "inventoryName"
    public static let ONLINE_KEY_INVENTORYID = "inventoryID"
    public static let KEY_SHAREDINVENTORY = "SharedInventory"
    public static let FIREBASE_KEY_GROUPS = "Groups"
    public static let FIREBASE_KEY_INVENTORIES = "Inventories"
    public static let FIREBASE_KEY_INVENTORYITEMS = "Items"
    public static let FIREBASE_KEY_MEMBERS = "Members"
    public static let FIREBASE_SUBKEY_GROUPOWNER = "groupOwner"
    public static let FIREBASE_SUBKEY_INVENTORYNAME = "inventoryName"
    public static let FIREBASE_SUBKEY_GROUPCODE = "groupCode"
    public static let FIREBASE_SUBKEY_MEMBERS = "Members"
    public static let FIREBASE_SUBKEY_GROUPNAME = "groupName"
    public static let FIREBASE_SUBKEY_ITEMDATE = "itemDate"
    public static let FIREBASE_SUBKEY_ITEMNEEDFUL = "itemNeedful"
    public static let FIREBASE_SUBKEY_ITEMQUANTITY = "itemQuantity"
    public static let FIREBASE_SUBKEY_ITEMNAME = "itemName"
    public static let FIREBASE_SUBKEY_HASHEDPASSWORD = "groupPasswordHashed"
    public static let DEFAULT_ITEM_NAME = ""
}
