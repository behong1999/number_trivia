import 'package:flutter/foundation.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/num_trivia.dart';

class NumberTriviaModel extends NumTrivia {
  NumberTriviaModel({
    @required String text,
    @required int number,
  }) : super(
          text: text,
          number: number,
        ); //* Calling super class constructor

  //* JSON conversion logic
  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      NumberTriviaModel(
        text: json['text'],
        number: (json['number'] as num).toInt(),
      );

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
    };
  }
}
