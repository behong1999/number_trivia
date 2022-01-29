import 'package:dartz/dartz.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/core/usecases/usecase.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/num_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/num_trivia_repository.dart';

class GetRandomNumberTrivia implements Usecase<NumTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
