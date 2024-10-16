// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProgramDao? _programDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Program` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `fileName` TEXT NOT NULL, `instructions` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProgramDao get programDao {
    return _programDaoInstance ??= _$ProgramDao(database, changeListener);
  }
}

class _$ProgramDao extends ProgramDao {
  _$ProgramDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _programInsertionAdapter = InsertionAdapter(
            database,
            'Program',
            (Program item) => <String, Object?>{
                  'id': item.id,
                  'fileName': item.fileName,
                  'instructions': item.instructions
                }),
        _programUpdateAdapter = UpdateAdapter(
            database,
            'Program',
            ['id'],
            (Program item) => <String, Object?>{
                  'id': item.id,
                  'fileName': item.fileName,
                  'instructions': item.instructions
                }),
        _programDeletionAdapter = DeletionAdapter(
            database,
            'Program',
            ['id'],
            (Program item) => <String, Object?>{
                  'id': item.id,
                  'fileName': item.fileName,
                  'instructions': item.instructions
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Program> _programInsertionAdapter;

  final UpdateAdapter<Program> _programUpdateAdapter;

  final DeletionAdapter<Program> _programDeletionAdapter;

  @override
  Future<List<Program>> findAllPrograms() async {
    return _queryAdapter.queryList('SELECT * FROM Program',
        mapper: (Map<String, Object?> row) => Program(row['id'] as int,
            row['fileName'] as String, row['instructions'] as String));
  }

  @override
  Future<Program?> findProgramById(int id) async {
    return _queryAdapter.query('SELECT * FROM Program WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Program(row['id'] as int,
            row['fileName'] as String, row['instructions'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertProgram(Program program) async {
    await _programInsertionAdapter.insert(program, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateProgram(Program program) async {
    await _programUpdateAdapter.update(program, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteProgram(Program program) async {
    await _programDeletionAdapter.delete(program);
  }
}
