
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
    contractor Text,
    drNumber Text,
    wellName Text,
    failureStatus Text,
    operations Text,
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
    originalInstallationDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cycleCountsUponFailure TEXT,
    failureMode TEXT,
    failureCause TEXT,
    failureMechanism TEXT,
    vendorOEM TEXT,
    repairLocation TEXT,
    discoveryMethod TEXT,
    failureProgressStatus TEXT,
    dateOfRepair TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    newItemPartNo  TEXT,
    newItemSerialNo  TEXT,
    RepairKitPartNo  TEXT,
    correctiveActionsSummary TEXT,
    attachments TEXT,
    draft Text)
      
      """);
  }


  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dba.db',
      version: 2,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }


  static Future<int> createRig(String? failureTitle  ,String? rigName , String? preparedBy ,String? equipment ,  String? failureType ,  String? operator ,  String ? failureDate ,String ? contractor,
  drNumber, String? wellName, String? failureStatus, String? operations,  String? bopSurface ,  String?  eventName ,  String? pod ,  String? partDescription ,  String?  eventDescription ,  String?
  indicationSymptoms ,  String? impactedFunctions ,  String? failureSeverity ,  String? failedItemPartNo ,    String? failedItemSerialNo ,
  String? originalInstallationDate , String?  cycleCountsUponFailure ,  String?  failureMode ,  String?  failureCause ,  String? failureMechanism ,
      String? vendorOEM ,  String? repairLocation ,  String? discoveryMethod ,  String?  failureProgressStatus ,String?  dateOfRepair,   String? newItemPartNo ,
       String? newItemSerialNo ,   String?  repairKitPartNo ,  String? correctiveActionsSummary ,String? draft) async {
    final db = await DatabaseHelper.db();

    final data = {'failureTitle': failureTitle,'rigName': rigName, 'preparedBy': preparedBy,
      'equipment': equipment, 'failureType': failureType, 'operator': operator,
      'failureDate': failureDate,'contractor':contractor, 'drNumber':drNumber,'wellName':wellName,
      'failureStatus':failureStatus,'operations':operations, 'bopSurface': bopSurface,'eventName': eventName,
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
    'failureProgressStatus': failureProgressStatus,
    'dateOfRepair': dateOfRepair,
    'newItemPartNo': newItemPartNo,
    'newItemSerialNo': newItemSerialNo,
    'repairKitPartNo': repairKitPartNo,
    'correctiveActionsSummary': correctiveActionsSummary,
      'draft':draft
      // 'attachments': attachments
    };
    final id = await db.insert('failures', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
print(data);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getRigs() async {
    final db = await DatabaseHelper.db();
    return db.query('failures', orderBy: "draft");
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