import 'dart:async';
import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  const TypewriterText({super.key});

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  List<String> phrases = ["Where Innovation Begins","Code. Create. Collaborate", "We Build. We Break. We Learn", "Enjoy Coding!"];
  int phraseIndex = 0;
  String displayedText = "";
  bool isErasing = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTyping();
  }

  void startTyping() {
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      final fullText = phrases[phraseIndex];

      setState(() {
        if (!isErasing) {
          if (displayedText.length < fullText.length) {
            displayedText = fullText.substring(0, displayedText.length + 1);
          } else {
            Future.delayed(Duration(seconds: 1), () {
              isErasing = true;
            });
          }
        } else {
          if (displayedText.isNotEmpty) {
            displayedText = displayedText.substring(0, displayedText.length - 1);
          } else {
            phraseIndex = (phraseIndex + 1) % phrases.length;
            isErasing = false;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      padding: EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Text(
        displayedText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white60),
      ),
    );
  }
}
