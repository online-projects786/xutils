import 'dart:typed_data';
import 'package:driveup/global_constants.dart';
import 'package:flutter/material.dart';
import '../../xutils/xprogressbarbutton.dart';
import '../../xutils/xtextfield.dart';
import '../route_generator.dart';
import 'package:file_picker/file_picker.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isPasswordShown = false;
  bool isLoading = false;
  double spaceBetweenFields = 15;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  Map<String, Object?> profileImage = {
    "image": null,
    "width": 120.0,
    "height": 120.0,
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; //360.0
    double textFieldWidth = screenWidth / 1.25;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  RouteGenerator.generateRoute(
                      const RouteSettings(name: "/login")),
                  (route) => false);
            },
            icon: const Icon(
              Icons.login,
              color: Colors.white,
            ),
            label: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Picture
              SizedBox(
                width: profileImage["width"] as double,
                height: profileImage["height"] as double,
                // color: Colors.grey,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: double.infinity,
                      child: ClipOval(
                        child: profileImage["image"] == null
                            ? Image.asset(
                                GlobalConstants().placeholderImage,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Image.memory(
                                profileImage["image"] as Uint8List,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 25),
                        child: InkWell(
                          onTap: () async {
                            FilePicker pic = FilePicker.platform;
                            FilePickerResult? file = await pic.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'jpeg', 'png'],
                            );
                            if (file != null) {
                              setState(() {
                                profileImage["image"] = file.files.first.bytes;
                              });
                            }
                          },
                          child: const Icon(Icons.camera_alt_outlined,
                              color: Colors.blue, size: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  //First Name Text Field.
                  SizedBox(
                    width: textFieldWidth,
                    child: XTextField(
                      controller: firstNameController,
                      prefixIcon: const Icon(Icons.add_circle),
                      hint: "First Name",
                    ),
                  ),
                  SizedBox(height: spaceBetweenFields),

                  //Last Name Entrance Field.
                  SizedBox(
                    width: textFieldWidth,
                    child: XTextField(
                      controller: lastNameController,
                      prefixIcon: const Icon(Icons.add_circle),
                      hint: "Last Name",
                    ),
                  ),
                  SizedBox(height: spaceBetweenFields),

                  DropdownMenu(
                    hintText: "Gender",
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "Male", label: "Male"),
                      DropdownMenuEntry(value: "Female", label: "Female"),
                    ],
                    controller: genderController,
                  ),

                  SizedBox(height: spaceBetweenFields),
                  //Phone TextField
                  SizedBox(
                    width: textFieldWidth,
                    child: XTextField(
                      controller: phoneController,
                      prefixIcon: const Icon(Icons.phone),
                      hint: "Phone",
                    ),
                  ),
                  SizedBox(height: spaceBetweenFields),

                  //Email Text Field.
                  SizedBox(
                    width: textFieldWidth,
                    child: XTextField(
                      controller: emailController,
                      prefixIcon: const Icon(Icons.email),
                      hint: "Email (Optional)",
                    ),
                  ),
                  SizedBox(height: spaceBetweenFields),

                  //Password Text Field.
                  SizedBox(
                    width: textFieldWidth,
                    child: XTextField(
                      controller: passwordController,
                      hint: "Enter Password",
                      obscureText: !isPasswordShown,
                      autocorrect: false,
                      enableSuggestions: false,
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: Checkbox(
                        value: isPasswordShown,
                        onChanged: (change) {
                          setState(() {
                            isPasswordShown = change!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: spaceBetweenFields),

                  //Conform Password Field
                  SizedBox(
                    width: textFieldWidth,
                    child: XTextField(
                      controller: conformPasswordController,
                      hint: "Enter Password",
                      obscureText: !isPasswordShown,
                      autocorrect: false,
                      enableSuggestions: false,
                      prefixIcon: const Icon(Icons.password),
                    ),
                  ),

                  // Register Button
                  const SizedBox(height: 15),
                ],
              ),
              //Check Box for Showing or Hiding Password.
              // Padding(
              //   padding: EdgeInsets.only(left: margin),
              //   child: XCheckBox(
              //     value: isPasswordShown,
              //     onChanged: () {
              //       setState(() {
              //         isPasswordShown = !isPasswordShown;
              //       });
              //     },
              //     s: "Show Password",
              //   ),
              // ),

              // SizedBox(width: spaceBetweenFields),
              XProgressBarButton(
                loadingValue: isLoading,
                buttonText: "Register",
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  print(genderController.text);
                  try {
                    if (firstNameController.text == "") {
                      throw Exception("First Name Field is Required");
                    }
                    if (lastNameController.text == "") {
                      throw Exception("Last Name Field is Required");
                    }
                    if (emailController.text == "") {
                      throw Exception("Email Field is Required");
                    }
                    if (passwordController.text == "") {
                      throw Exception("Password Field is Required");
                    }
                    if (conformPasswordController.text == "") {
                      throw Exception("Please Confirm Password");
                    }
                    if (passwordController.text !=
                        conformPasswordController.text) {
                      throw Exception("Passwords Doesn't Match");
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                    print("Flutter Error: $e");
                  }
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
