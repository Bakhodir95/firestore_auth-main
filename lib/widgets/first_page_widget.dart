import 'package:firestore_auth/models/quiz.dart';
import 'package:firestore_auth/utils/app_const.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AlternativesWidget extends StatefulWidget {
  Quiz question;
  AlternativesWidget({super.key, required this.question});

  @override
  State<AlternativesWidget> createState() => _AlternativesWidgetState();
}

class _AlternativesWidgetState extends State<AlternativesWidget> {
  // List<bool> useranswer = [false, false, false, false];
  int _chosenaAnswer = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            widget.question.question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              wordSpacing: 2,
              letterSpacing: 2,
            ),
          ),
          for (int i = 0; i < widget.question.variant.length; i++)
            Column(
              children: [
                CheckboxListTile(
                  value: _chosenaAnswer == i,
                  onChanged: (value) {
                    _chosenaAnswer = i;
                    AppConst.answers[widget.question.question] =
                        i == widget.question.answer;
                    setState(() {});
                  },
                  title: Text(widget.question.variant[i]),
                ),
                const Gap(10),
              ],
            ),
        ],
      ),
    );
  }
}
