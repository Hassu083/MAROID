import 'package:maroid/entity/app_database.dart';
import 'package:maroid/entity/program.dart';
import 'package:maroid/entity/program_dao.dart';

abstract class LocalDbService{
  static Future<AppDatabase> get _db async => await $FloorAppDatabase.databaseBuilder('program_db').build();

  static Future<ProgramDao> get programDao async => (await _db).programDao;
}