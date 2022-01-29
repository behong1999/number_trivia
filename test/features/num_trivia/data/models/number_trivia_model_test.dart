import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/num_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test(
    'should be a subclass of NumTrivia entity',
    () async {
      //* isA expects the object to match with the corresponding type
      expect(tNumberTriviaModel, isA<NumTrivia>());
    },
  );

  group('From JSON,', () {
    test('should return a valid model when the JSON number is an interger', () {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
          fixture('trivia.json')); //* Decode String into Map<String, dynamic>
      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      // assert
      expect(result, tNumberTriviaModel);
    });
    test(
      'should return a valid model when the JSON number is considered as a double',
      () {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, tNumberTriviaModel);
      },
    );
  });

  group('To Json', () {
    test('should return a JSON map containing the proper data', () {
      // arrange
      final result = tNumberTriviaModel.toJson();

      final expectedJsonMap = {
        "text": "Test Text",
        "number": 1,
      };
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
