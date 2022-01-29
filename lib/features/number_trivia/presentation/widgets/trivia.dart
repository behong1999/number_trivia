import 'package:flutter/material.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/num_trivia.dart';

class Trivia extends StatelessWidget {
  final NumTrivia trivia;
  const Trivia({
    Key key,
    @required this.trivia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Column(children: [
          const SizedBox(height: 10),
          Text(
            trivia.number.toString(),
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  trivia.text,
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ]));
  }
}
