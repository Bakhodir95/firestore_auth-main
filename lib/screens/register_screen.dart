import 'dart:io';

import 'package:firestore_auth/controllers/register_controller.dart';
import 'package:firestore_auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();
  final registerController = RegisterController();
  File? imageFile;

  void openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        requestFullMetadata: false);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        requestFullMetadata: false);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  String? email;
  String? password;
  String? name;
  submit() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      try {
        await registerController.register(
          name!,
          email!,
          password!,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Registration",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                Stack(children: [
                  InkWell(
                    onTap: openGallery,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: imageFile != null
                          ? Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 20,
                    child: Icon(
                      Icons.add_circle_outline_sharp,
                      size: 40,
                    ),
                  ),
                ]),
                const Gap(20),
                TextFormField(
                  onSaved: (newValue) {
                    email = newValue;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("Enter Login")),
                ),
                const Gap(10),
                TextFormField(
                  onSaved: (newValue) {
                    password = newValue;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter Password")),
                ),
                const Gap(10),
                TextFormField(
                  onSaved: (newValue) {
                    name = newValue;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("Enter name")),
                ),
                const Gap(20),
                FilledButton(
                    onPressed: submit,
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("Submit"),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const LoginScreen()));
                    },
                    child: const Text("LogIn"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
