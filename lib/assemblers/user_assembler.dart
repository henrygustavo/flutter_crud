
import 'package:flutter_crud/assemblers/assembler.dart';
import 'package:flutter_crud/model/user.dart';

class UserAssembler implements Assembler<User> {
  final tableName = 'Users';
  final columnId = 'id';
  final columnName = 'name';
  final columnEmail = 'email';

  @override
  User fromMap(Map<String, dynamic> query) {
    User user = User(query[columnName], query[columnEmail]);
    return user;
  }

  @override
  Map<String, dynamic> toMap(User user) {
    return <String, dynamic>{
      columnName: user.name,
      columnEmail: user.email
    };
  }

  User fromDbRow(dynamic row) {
    return User.withId(row[columnId], row[columnName], row[columnEmail]);
  }

  @override
  List<User> fromList(result) {
    List<User> users = List<User>();
    var count = result.length;
    for (int i = 0; i < count; i++) {
      users.add(fromDbRow(result[i]));
    }
    return users;
  }
}