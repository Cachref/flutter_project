import 'dart:typed_data';
import 'package:app1/Auth/login.dart';
import 'package:app1/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class Signupa extends StatefulWidget {
  Signupa({Key? key}) : super(key: key);

  @override
  _SignupaState createState() => _SignupaState();
}

class _SignupaState extends State<Signupa> {
  Uint8List? _image;

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
  Future<void> postaccount() async {
    if(fname.text == "" || lname.text == "" || email.text == "" || pwd.text == ""){
      try{
        String uri = "http://localhost/flutterapp1/adminacc.php";
        var res= await http.post(Uri.parse(uri), body: {});
      }
      catch(e){}
    }else{
      print("Please fill all fields");
    }
    //return this.http.post<any>("http://localhost/flutterapp1/adminacc/", data);
    
    },
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.jpg'), // Path to your background image
            fit: BoxFit.cover, // Cover the whole screen
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    _image != null
                        ? ClipOval(
                            child: Image.memory(
                              _image!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipOval(
                            child: Image.asset(
                              'images/user.png', // Path to your placeholder image
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                    Positioned(
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                      bottom: -10,
                      left: 80,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: lname,
                    decoration: const InputDecoration(
                      hintText: 'Enter Last Name here',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      labelText: 'Last Name',
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
                    controller: fname,
                    decoration: const InputDecoration(
                      hintText: 'Enter First Name here',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      labelText: 'First Name',
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
                    controller: email,
                    decoration: const InputDecoration(
                      hintText: 'Enter Email here',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
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
                        color: Colors.white,
                        fontSize: 16.0,
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
                      postaccount();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration
                            .underline, // Optional: Underline the text
                      ),
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
