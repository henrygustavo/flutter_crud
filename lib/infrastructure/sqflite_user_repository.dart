import 'package:flutter_crud/assemblers/user_assembler.dart';
import 'package:flutter_crud/infrastructure/user_repository.dart';
import 'package:flutter_crud/infrastructure/database_migration.dart';
import 'package:flutter_crud/model/user.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteUserRepository implements UserRepository {
  final assembler = UserAssembler();

  @override
  DatabaseMigration databaseMigration;

  SqfliteUserRepository(this.databaseMigration);

  @override
  Future<int> insert(User user) async {
    final db = await databaseMigration.db();
    var id = await db.insert(assembler.tableName, assembler.toMap(user));
    return id;
  }

  @override
  Future<int> delete(User user) async {
    final db = await databaseMigration.db();
    int result = await db.delete(assembler.tableName,
        where: assembler.columnId + " = ?", whereArgs: [user.id]);
    return result;
  }

  @override
  Future<int> update(User user) async {
    final db = await databaseMigration.db();
    int result = await db.update(assembler.tableName, assembler.toMap(user),
        where: assembler.columnId + " = ?", whereArgs: [user.id]);
    return result;
  }

  @override
  Future<List<User>> getList() async {
    final db = await databaseMigration.db();
    print('Secondary Thread Future getList 1');
    var result = await db.rawQuery("SELECT * FROM users order by name ASC");
    print('Secondary Thread Future getList 2');
    print(result);
    List<User> users = assembler.fromList(result);
    print('Secondary Thread Future getList 3');
    return users;
  }

  Future<int> getCount() async {
    final db = await databaseMigration.db();
    var result = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM users')
    );
    return result;
  }
}