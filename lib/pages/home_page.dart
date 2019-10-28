import 'package:flutter/material.dart';
import 'package:flutter_crud/pages/user_list_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_crud/common/app_constants.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Widget content = UserListPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          title: Text(
            AppConstants.appBarTitle,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(FontAwesomeIcons.userCog, size: 25),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(FontAwesomeIcons.solidBell,
                    size: 25, color: Colors.white),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: content
    );
  }
}
