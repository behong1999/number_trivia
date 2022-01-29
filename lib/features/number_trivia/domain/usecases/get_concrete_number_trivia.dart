import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/core/usecases/usecase.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/num_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/num_trivia_repository.dart';

class GetConcreteNumberTrivia implements Usecase<NumTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

@immutable
class Params extends Equatable {
  final int number;

  Params(this.number);

  @override
  // TODO: implement props
  List<Object> get props => [number];
}
