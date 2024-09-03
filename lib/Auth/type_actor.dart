import 'package:app1/Auth/signupA.dart';
import 'package:app1/Auth/signupS.dart';
import 'package:flutter/material.dart';

class TypeActor extends StatelessWidget {
  const TypeActor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Im a ?',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 400,
                  height: 100,
                  child: TextButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        BorderSide(color: Colors.white, width: 2),
                      ), // White border
                      backgroundColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ), // Transparent background
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ), // Text color
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Sharp corners
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Signups(),
                        ),
                      );
                    },
                    child: const Text(
                      'A Student',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 400,
                  height: 100,
                  child: TextButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        BorderSide(color: Colors.white, width: 2),
                      ), // White border
                      backgroundColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ), // Transparent background
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ), // Text color
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Sharp corners
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Signupa(),
                        ),
                      );
                    },
                    child: const Text(
                      'An Admin',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
