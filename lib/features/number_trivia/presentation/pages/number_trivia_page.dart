// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:number_trivia_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:number_trivia_clean_architecture/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia Generator'),
        ),
        body: SingleChildScrollView(
          child: BlocProvider(
            create: (_) => sLocator<NumberTriviaBloc>(),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Column(
                  children: [
                    BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                        // ignore: missing_return
                        builder: (context, state) {
                      if (state is Empty) {
                        return const Message(
                          message: 'Start Searching!',
                        );
                      } else if (state is Loading) {
                        return LoadingWidget();
                      } else if (state is Loaded) {
                        return Trivia(trivia: state.trivia);
                      } else if (state is Error) {
                        return Message(message: state.message);
                      }
                    }),
                    NumberInput(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
