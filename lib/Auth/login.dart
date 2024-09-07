import 'package:app1/Auth/menuA.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:app1/Auth/login.dart';
import 'package:app1/Auth/menuS.dart';
import 'package:app1/Auth/type_actor.dart';
import 'package:app1/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController pwd = TextEditingController();
    Future<bool> getadminaccount() async {
      try {
        // Add email as a query parameter
        String uri =
            "http://10.0.2.2/flutterapp1/admin.php?email=${email.text}&pwd=${pwd.text}";
        var res = await http.get(Uri.parse(uri));
        var response = jsonDecode(res.body);

        if (response["exists"] == true) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print(e);
        return false;
      }
    }

    Future<bool> getstudentaccount() async {
      try {
        // Add email as a query parameter
        String uri =
            "http://10.0.2.2/flutterapp1/student.php?email=${email.text}&pwd=${pwd.text}";
        var res = await http.get(Uri.parse(uri));
        var response = jsonDecode(res.body);

        if (response["exists"] == true) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print(e);
        return false;
      }
    }

    return WillPopScope(
      onWillPop: () async =>
          false, // This will prevent the back button from working
      child: Scaffold(
        // Scaffold wraps your entire login screen
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.jpg'), // Path to your image
              fit: BoxFit.cover, // Cover the whole screen
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'images/R23.png', // Path to your image
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        hintText: 'Enter Email here',
                        hintStyle: TextStyle(
                          color: Colors.white, // Change hint text color
                          fontSize: 16.0, // Change font size
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: pwd,
                      decoration: const InputDecoration(
                        hintText: 'Enter Password here',
                        hintStyle: TextStyle(
                          color: Colors.white, // Change hint text color
                          fontSize: 16.0, // Change font size
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: 400,
                    height: 80,
                    child: TextButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          BorderSide(color: Colors.white, width: 2),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        // Add login functionality here
                        bool adminaccountExists = await getadminaccount();
                        bool studentaccountExists = await getstudentaccount();

                        if (adminaccountExists) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Menua()),
                          );
                        } else if (studentaccountExists) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Menus()),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg:
                                "Make sure you enter a valid account email and password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                    indent: 16,
                    endIndent: 16,
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 400,
                    height: 80,
                    child: TextButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          BorderSide(color: Colors.white, width: 2),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                      ),
                      onPressed: () {
                        // Navigate to TypeActor screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TypeActor(),
                          ),
                        );
                      },
                      child: const Text(
                        'Create a new account',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
