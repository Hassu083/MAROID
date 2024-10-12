import 'package:floor/floor.dart';

@entity
class Program {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String fileName;
  final String instructions;

  Program(this.id, this.fileName,this.instructions);
}