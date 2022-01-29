import 'package:dartz/dartz.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/num_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumTrivia>> getRandomNumberTrivia();
}
