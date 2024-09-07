import 'dart:convert';
import 'dart:typed_data';
import 'package:app1/Auth/login.dart';
import 'package:app1/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';

class Menua extends StatefulWidget {
  Menua({Key? key}) : super(key: key);

  @override
  _MenuaState createState() => _MenuaState();
}

class _MenuaState extends State<Menua> {
  @override
  //add no back button
  // Disable back button
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevents back navigation
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/menubg1.png'), // Background image path
              fit: BoxFit.cover, // Ensures the image covers the whole screen
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                  height: 80), // Add space at the top to move the grid down
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: GridView.count(
                    crossAxisCount: 2, // Adjust the number of columns
                    children: <Widget>[
                      Card(
                        margin: EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.red[100],
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/université.png', // Path to your image
                                  width: 100.0,
                                  height: 100.0,
                                ),
                                Text(
                                  "Institutions",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // More cards with images
                      Card(
                        margin: EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.red,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/professeur1.png', // Path to your image
                                  width: 100.0,
                                  height: 100.0,
                                ),
                                Text(
                                  "Professors",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.red,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/classe1.png', // Path to your image
                                  width: 100.0,
                                  height: 100.0,
                                ),
                                Text(
                                  "Class",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.red,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/matieres.png', // Path to your image
                                  width: 100.0,
                                  height: 100.0,
                                ),
                                Text(
                                  "Subjects",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Card(
                        margin: EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.red,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/note.png', // Path to your image
                                  width: 100.0,
                                  height: 100.0,
                                ),
                                Text(
                                  "Grades",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.red,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/trimeste.png', // Path to your image
                                  width: 100.0,
                                  height: 100.0,
                                ),
                                Text(
                                  "Trimester",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.red,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/setting.png', // Path to your image
                                  width: 100.0,
                                  height: 100.0,
                                ),
                                Text(
                                  "Settings",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.red,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'images/annonce.png', // Path to your image
                                  width: 100.0,
                                  height: 100.0,
                                ),
                                Text(
                                  "Announcements",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
