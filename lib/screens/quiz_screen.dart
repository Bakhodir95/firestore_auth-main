import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_auth/controllers/quiz_controller.dart';
import 'package:firestore_auth/models/quiz.dart';
import 'package:firestore_auth/screens/login_screen.dart';
import 'package:firestore_auth/utils/app_const.dart';
import 'package:firestore_auth/widgets/first_page_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Widget> pages = [];
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final quizController = context.read<QuizController>();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {},
              contentPadding: EdgeInsets.all(10),
              tileColor: Colors.amber,
              title: const Text("Add Question"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            const Gap(10),
            const ListTile(
              contentPadding: EdgeInsets.all(10),
              tileColor: Colors.amber,
              title: Text("Edit Question"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const Gap(10),
            const ListTile(
              contentPadding: EdgeInsets.all(10),
              tileColor: Colors.amber,
              title: Text("Delete Question"),
              trailing: Icon(Icons.keyboard_arrow_right),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text("HomeScreen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                setState(() {});
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 205, 22, 237),
      body: StreamBuilder(
          stream: quizController.list,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text(" No questions yet!"),
              );
            }
            final questions = snapshot.data!.docs;
            return questions.isEmpty
                ? const Center(
                    child: Text(" No questions yet!"),
                  )
                : Center(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: questions.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == questions.length) {
                          int c = 0;
                          /* 
                         {
                         'eng eywgdygswr':true ~~ false
                         }
                         
                         */
                          AppConst.answers.forEach(
                            (key, value) {
                              if (value) c++;
                            },
                          );
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Your correct answer is $c',
                                  style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              FilledButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: const Text("Restart"))
                            ],
                          );
                        } else {
                          final question = Quiz.fromJson(questions[index]);
                          return AlternativesWidget(
                            question: question,
                          );
                        }
                      },
                    ),
                  );
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _pageController.nextPage(
                duration: const Duration(seconds: 1), curve: Curves.linear);
          },
          label: const Text('Next')),
    );
  }
}
