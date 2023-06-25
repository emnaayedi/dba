
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE failures(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
         failureTitle TEXT ,
    rigName TEXT,
    preparedBy TEXT,
    equipment TEXT,
    failureType TEXT,
    operator TEXT,
    failureDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    bopSurface TEXT,
    eventName TEXT,
    pod TEXT,
    partDescription TEXT,
    eventDescription TEXT,
    indicationSymptoms TEXT,
    impactedFunctions TEXT,
    failureSeverity TEXT,
    failedItemPartNo TEXT,
    failedItemSerialNo TEXT,
    originalInstallationDate TEXT,
    cycleCountsUponFailure TEXT,
    failureMode TEXT,
    failureCause TEXT,
    failureMechanism TEXT,
    vendorOEM TEXT,
    repairLocation TEXT,
    discoveryMethod TEXT,
    failureStatus TEXT,
    dateOfRepair,
    newItemPartNo INTEGER,
    newItemSerialNo INTEGER,
    RepairKitPartNo INTEGER,
    correctiveActionsSummary TEXT,
    attachments TEXT)
      
      """);
  }


  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dba.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }


  static Future<int> createRig(String? failureTitle  ,String? rigName , String? preparedBy ,String? equipment ,  String? failureType ,  String? operator ,  String ? failureDate ,  String?
  bopSurface ,  String?  eventName ,  String? pod ,  String? partDescription ,  String?  eventDescription ,  String?
  indicationSymptoms ,  String? impactedFunctions ,  String? failureSeverity , int? failedItemPartNo ,   int? failedItemSerialNo ,
  String? originalInstallationDate , String?  cycleCountsUponFailure ,  String?  failureMode ,  String?  failureCause ,  String? failureMechanism ,
      String? vendorOEM ,  String? repairLocation ,  String? discoveryMethod ,  String?  failureStatus ,String?  dateOfRepair,  int? newItemPartNo ,
      int? newItemSerialNo ,  int?  repairKitPartNo ,  String? correctiveActionsSummary ,  String?  attachments ) async {
    final db = await DatabaseHelper.db();

    final data = {'failureTitle': failureTitle,'rigName': rigName, 'preparedBy': preparedBy,
      'equipment': equipment, 'failureType': failureType, 'operator': operator,
      'failureDate': failureDate, 'bopSurface': bopSurface,'eventName': eventName,
      'pod': pod, 'partDescription': partDescription, 'eventDescription': eventDescription,
    'indicationSymptoms': indicationSymptoms, 'impactedFunctions': impactedFunctions,
    'failureSeverity': failureSeverity,
    'failedItemPartNo': failedItemPartNo,
    'failedItemSerialNo': failedItemSerialNo,
    'originalInstallationDate':originalInstallationDate,
    'cycleCountsUponFailure': cycleCountsUponFailure,
    'failureMode': failureMode,
    'failureCause': failureCause,
    'failureMechanism': failureMechanism,
    'vendorOEM': vendorOEM,
    'repairLocation': repairLocation,
    'discoveryMethod': discoveryMethod,
    'failureStatus': failureStatus,
    'dateOfRepair': dateOfRepair,
    'newItemPartNo': newItemPartNo,
    'newItemSerialNo': newItemSerialNo,
    'repairKitPartNo': repairKitPartNo,
    'correctiveActionsSummary': correctiveActionsSummary,
      'attachments': attachments };
    final id = await db.insert('failures', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getRigs() async {
    final db = await DatabaseHelper.db();
    return db.query('failures', orderBy: "id");
  }

  // Get a single item by id
  //We dont use this method, it is for you if you want it.
  static Future<List<Map<String, dynamic>>> getRig(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('failures', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateRig(
      int id, String rigName, String? descrption) async {
    final db = await DatabaseHelper.db();

    final data = {
      'name': rigName,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('failures', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteRig(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("failures", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}