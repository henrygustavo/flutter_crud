import 'package:flutter_crud/infrastructure/database_migration.dart';
import 'package:flutter_crud/model/user.dart';

abstract class UserRepository {
  DatabaseMigration databaseMigration;
  Future<int> insert(User user);
  Future<int> update(User user);
  Future<int> delete(User user);
  Future<List<User>> getList();
}