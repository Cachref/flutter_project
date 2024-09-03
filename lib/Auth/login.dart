import 'package:flutter/material.dart';
import 'package:app1/Auth/type_actor.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {
                        // Add login functionality here
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
