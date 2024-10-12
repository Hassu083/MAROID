import 'package:floor/floor.dart';
import 'package:maroid/entity/program.dart';

@dao
abstract class ProgramDao {

  @Query('SELECT * FROM Program')
  Future<List<Program>> findAllPrograms();

  @Query('SELECT * FROM Program WHERE id = :id')
  Future<Program?> findProgramById(int id);

  @insert
  Future<void> insertProgram(Program program);

  @update
  Future<void> updateProgram(Program program);

  @delete
  Future<void> deleteProgram(Program program);

}