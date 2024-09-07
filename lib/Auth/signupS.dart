import 'dart:convert';
import 'dart:typed_data';
import 'package:app1/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signups extends StatefulWidget {
  Signups({Key? key}) : super(key: key);

  @override
  _SignupsState createState() => _SignupsState();
}

class _SignupsState extends State<Signups> {
  Uint8List? _image;
  TextEditingController adminEmailController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Future<Uint8List> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      throw "No Image Selected";
    }
  }

  Future<int?> getAdminId(String email) async {
    try {
      String uri = "http://10.0.2.2/flutterapp1/student.php?email=$email";
      var res = await http.get(Uri.parse(uri));

      // Print headers and body for debugging
      print("Response headers: ${res.headers}");
      print("Response body: ${res.body}");

      if (res.statusCode == 200) {
        try {
          // Try to parse the response as JSON
          var response = jsonDecode(res.body);

          // Check if admin_id exists and is not null
          if (response["admin_id"] != null) {
            // Convert admin_id to integer
            int? adminId = int.tryParse(response["admin_id"].toString());

            // Check if conversion was successful
            if (adminId != null) {
              return adminId;
            } else {
              Fluttertoast.showToast(
                  msg: "Error: admin_id is not a valid integer");
              return null;
            }
          } else {
            Fluttertoast.showToast(
                msg: response["error"] ?? "Error retrieving admin ID");
            return null;
          }
        } catch (e) {
          // If JSON parsing fails, handle it
          Fluttertoast.showToast(
              msg: "Failed to parse response as JSON: ${res.body}");
          return null;
        }
      } else {
        Fluttertoast.showToast(
            msg: "Server responded with status code: ${res.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "Error: $e");
      return null;
    }
  }

  /*Future<int?> getAdminId(String email) async {
    try {
      String uri = "http://10.0.2.2/flutterapp1/student.php?email=$email";
      var res = await http.get(Uri.parse(uri));

      // Print headers and body for debugging
      print("Response headers: ${res.headers}");
      print("Response body: ${res.body}");

      try {
        // Try to parse the response as JSON
        var response = jsonDecode(res.body);

        if (response["admin_id"] != null) {
          return int.tryParse(response["admin_id"].toString());
        } else {
          Fluttertoast.showToast(
              msg: response["error"] ?? "Error retrieving admin ID");
          return null;
        }
      } catch (e) {
        // If JSON parsing fails, handle it
        Fluttertoast.showToast(
            msg: "Failed to parse response as JSON: ${res.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "Error: $e");
      return null;
    }
  }*/

  Future<void> postAccount() async {
    if (fnameController.text.isNotEmpty &&
        lnameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        pwdController.text.isNotEmpty) {
      try {
        int? adminId = await getAdminId(adminEmailController.text);
        if (adminId == null) {
          print("Admin ID not found");
          return;
        }

        String uri = "http://10.0.2.2/flutterapp1/student.php";
        var request = http.MultipartRequest('POST', Uri.parse(uri));

        // Add text fields
        request.fields['fname'] = fnameController.text;
        request.fields['lname'] = lnameController.text;
        request.fields['email'] = emailController.text;
        request.fields['pwd'] = pwdController.text;
        request.fields['admin_id'] = adminId.toString();

        // If image is selected, send it; otherwise, send a default user.png
        if (_image != null) {
          request.files.add(http.MultipartFile.fromBytes(
            'image',
            _image!,
            filename: 'profile_image.png',
            contentType: MediaType('image', 'png'),
          ));
        } else {
          ByteData data = await rootBundle.load('images/user.png');
          List<int> bytes = data.buffer.asUint8List();
          request.files.add(http.MultipartFile.fromBytes(
            'image',
            bytes,
            filename: 'user.png',
            contentType: MediaType('image', 'png'),
          ));
        }

        // Send the request
        var res = await request.send();
        var response = await http.Response.fromStream(res);
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse["success"] == true) {
          Fluttertoast.showToast(msg: "Student added successfully!");
        } else {
          Fluttertoast.showToast(
              msg: jsonResponse["error"] ?? "Some issues occurred");
        }
      } catch (e) {
        print(e);
        Fluttertoast.showToast(msg: "Error: $e");
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.jpg'), // Background image path
            fit: BoxFit.cover,
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
                              'images/user.png', // Placeholder image path
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
                buildTextField(adminEmailController,
                    "Enter your Admin Email here", "Admin Email"),
                buildTextField(
                    lnameController, "Enter Last Name here", "Last Name"),
                buildTextField(
                    fnameController, "Enter First Name here", "First Name"),
                buildTextField(emailController, "Enter Email here", "Email"),
                buildTextField(pwdController, "Enter Password here", "Password",
                    obscureText: true),
                SizedBox(height: 16),
                Container(
                  width: 400,
                  height: 80,
                  child: TextButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          BorderSide(color: Colors.white, width: 2)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () async {
                      await postAccount();
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

  Widget buildTextField(
      TextEditingController controller, String hintText, String labelText,
      {bool obscureText = false}) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
