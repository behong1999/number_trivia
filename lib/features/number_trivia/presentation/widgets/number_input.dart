import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class NumberInput extends StatefulWidget {
  @override
  State<NumberInput> createState() => NumberInputState();
}

class NumberInputState extends State<NumberInput> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type a number',
          ),
          onChanged: (value) => inputStr = value,
          onSubmitted: (_) {
            if (inputStr == null) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(content: Text('Empty !')));
            } else {
              callConcrete();
            }
          },
        ),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
              child: RaisedButton(
            textColor: Colors.white,
            child: const Text('Search'),
            color: Theme.of(context).accentColor,
            onPressed: () {
              if (inputStr == null) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(content: Text('Empty !')));
              } else {
                callConcrete();
              }
            },
          )),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: RaisedButton(
            textColor: Colors.white,
            child: const Text('Random Trivia'),
            onPressed: callRandom,
            color: Theme.of(context).accentColor,
          ))
        ])
      ],
    );
  }

  void callConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(inputStr));
  }

  void callRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
