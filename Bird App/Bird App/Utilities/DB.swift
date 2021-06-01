import Foundation
import UIKit
import SQLite3

class DB {
    init(database: String) {
       db = openDatabase(databaseName: database)
    }
    var db:OpaquePointer?
    
    private func openDatabase(databaseName: String) -> OpaquePointer?
    {
        var fileURL : URL?
        fileURL = databaseURL(databaseName: databaseName)
        var db: OpaquePointer? = nil
        if sqlite3_open_v2(fileURL!.path, &db, SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE | SQLITE_OPEN_FULLMUTEX, nil) == SQLITE_OK {
            print("Successfully opened connection to database at \(databaseName)")
            return db
        }
        else {
            print("error opening database")
            return nil
        }
    }
    func databaseURL(databaseName: String) -> URL? {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last! as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("\(databaseName).db") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                print(pathComponent)
                return pathComponent
            } else {
                return self.copy_database(databaseName: databaseName, pathComponent: pathComponent)
            }
        } else {
            print("FILE PATH NOT AVAILABLE")
        }
        return nil
    }
    
    private func copy_database(databaseName: String, pathComponent: URL) -> URL? {
        if let bundleURL = Bundle.main.url(forResource: databaseName, withExtension: "db") {
            do {
                let fileManager = FileManager.default
                try fileManager.copyItem(at: bundleURL, to: pathComponent)
                return pathComponent
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func read_tbl_species(query: String) -> [TBL_SPECIES] {
        let queryStatementString = query
        var queryStatement: OpaquePointer? = nil
        var species: [TBL_SPECIES] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                var incubatingDays = "0"
                var bandingDays = "0"
                if let i = sqlite3_column_text(queryStatement, 2) {
                    incubatingDays = String(describing: String(cString: i))
                }
                if let d = sqlite3_column_text(queryStatement, 3) {
                    bandingDays = String(describing: String(cString: d))
                }
                species.append(TBL_SPECIES(id: id, name: name, incubatingDays: incubatingDays, bandingDays: bandingDays))
            }
        } else {
            print("SELECT statement (tbl_UserModule) could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return species
    }
    func insert_tbl_species(name: String, incubatingDays: String, bandingDays: String, _ handler: @escaping(_ success:Bool)->Void) {
        let insertStatementString = "INSERT INTO TBL_SPECIES(name, incubationDays, bandingDays) VALUES (?, ?, ?);"
        
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(self.db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (incubatingDays as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (bandingDays as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                //print("USER_MODULE: Successfully inserted row.")
                handler(true)
            } else {
                print("Could not insert row.")
                handler(false)
            }
        } else {
            handler(false)
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    func read_tbl_varieties(query: String) -> [TBL_VARIETIES] {
        let queryStatementString = query
        var queryStatement: OpaquePointer? = nil
        var varieties: [TBL_VARIETIES] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let speciesId = Int(sqlite3_column_int(queryStatement, 2))
                varieties.append(TBL_VARIETIES(id: id, name: name, speciesId: speciesId))
            }
        } else {
            print("SELECT statement (tbl_UserModule) could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return varieties
    }
    func insert_tbl_varieties(name: String, speciesId: Int, _ handler: @escaping(_ success:Bool)->Void)  {
        let insertStatementString = "INSERT INTO tbl_varieties(name, speciesId) VALUES (?, ?);"
        
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(self.db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, Int32(speciesId))
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                //print("USER_MODULE: Successfully inserted row.")
                handler(true)
            } else {
                handler(false)
                print("Could not insert row.")
            }
        } else {
            handler(false)
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
}


struct TBL_SPECIES {
    var id: Int?
    var name: String?
    var incubatingDays: String?
    var bandingDays: String?
}

struct TBL_VARIETIES {
    var id: Int?
    var name: String?
    var speciesId: Int?
}

struct TBL_MUTATION {
    var id: Int?
    var name: String?
    var symbol: String?
    var mutation: String?
    var mutationType: String?
    var mutationAlelles: String?
    var alellesType: String?
    var desc: String?
    var varietiesId: Int?
}
