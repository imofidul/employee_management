import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class AppDatabase  {

  static final AppDatabase _dbProvider = AppDatabase._internal();
  AppDatabase._internal();
  static AppDatabase get instance => _dbProvider;
  static Database? _databaseInstance;

  Future<Database?> get database async {
    if(_databaseInstance != null) {
      return _databaseInstance;
    }
    _databaseInstance = await _init();
    return _databaseInstance;

  }

  Future<Database> _init() async{
    return await openDatabase(
      join(await getDatabasesPath(), 'realtime.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $tableEmployee (id INTEGER PRIMARY KEY, name Text, role TEXT, dateFrom INTEGER,  dateTo INTEGER);",
        );
      },
      version: 1,
    );
  }
  static String tableEmployee="employee";
}