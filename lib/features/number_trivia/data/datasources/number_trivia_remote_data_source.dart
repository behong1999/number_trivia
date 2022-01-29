import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';

//NOTE: Method return types of data sources will be similar to the ones in the repository
// But Models are not going to return errors by throwing Exceptions instead of using Failures.
abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getTriviaFromUrl('http://numbersapi.com/$number');
  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getTriviaFromUrl('http://numbersapi.com/random');

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200)
      return NumberTriviaModel.fromJson(json.decode(response.body));
    else
      throw ServerException();
  }
}
