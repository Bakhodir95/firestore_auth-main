import 'package:firestore_auth/controllers/register_controller.dart';
import 'package:firestore_auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final RegisterController registerController = RegisterController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? email;

  void resetPassword() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      print("-----------------------");

      await registerController.resetPassword(email!);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                TextFormField(
                  onSaved: (newValue) {
                    email = newValue;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Reset Password",
                  ),
                ),
                const Gap(20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue.shade900),
                  ),
                  onPressed: resetPassword,
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
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
