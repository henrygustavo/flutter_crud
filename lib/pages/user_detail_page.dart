import 'package:flutter/material.dart';
import 'package:flutter_crud/infrastructure/sqflite_user_repository.dart';
import 'package:flutter_crud/infrastructure/database_migration.dart';
import 'package:flutter_crud/model/user.dart';

SqfliteUserRepository userRepository = SqfliteUserRepository(DatabaseMigration.get);
final List<String> choices = const <String> [
  'Save User & Back',
  'Delete User',
  'Back to List'
];

const mnuSave = 'Save User & Back';
const mnuDelete = 'Delete User';
const mnuBack = 'Back to List';

class UserDetailPage extends StatefulWidget {
  final User user;
  UserDetailPage(this.user);

  @override
  State<StatefulWidget> createState() => UserDetailPageState(user);
}

class UserDetailPageState extends State<UserDetailPage> {
  User user;
  UserDetailPageState(this.user);
  final semesterList = [1, 2, 3, 4];
  final creditList = [3, 4, 6, 8, 10];
  int semester = 1;
  int credits = 4;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = this.user.name;
    emailController.text = user.email;
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(user.name),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: select,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding( 
        padding: EdgeInsets.only(top:35.0, left: 10.0, right: 10.0),
        child: ListView(children: <Widget>[Column(
        children: <Widget>[
          TextField(
            controller: nameController,
            style: textStyle,
            onChanged: (value) => this.updateName(),
            decoration: InputDecoration(
              labelText: "Name",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:15.0, bottom: 15.0),
            child: TextField(
            controller: emailController,
            style: textStyle,
            onChanged: (value) => this.updateEmail(),
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ))
        ],
      )],)
      )
    );
  }

  void select (String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        Navigator.pop(context, true);
        if (user.id == null) {
          return;
        }
        result = await userRepository.delete(user);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Delete User"),
            content: Text("The User has been deleted"),
          );
          showDialog(
            context: context,
            builder: (_) => alertDialog);
          
        }
        break;
        case mnuBack:
          Navigator.pop(context, true);
          break;
      default:
    }
  }

  void save() {
    if (user.id != null) {
      debugPrint('update');
      userRepository.update(user);
    }
    else {
      debugPrint('insert');
      userRepository.insert(user);
    }
    Navigator.pop(context, true);
  }

  void updateName(){
    user.name = nameController.text;
  }

  void updateEmail() {
    user.email = emailController.text;
  }
}