import 'dart:async';
import 'package:floor/floor.dart';
import 'package:maroid/entity/program.dart';
import 'package:maroid/entity/program_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Program])
abstract class AppDatabase extends FloorDatabase {
  ProgramDao get programDao;
}