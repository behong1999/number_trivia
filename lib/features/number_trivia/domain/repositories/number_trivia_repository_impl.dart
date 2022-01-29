import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/core/network/network_info.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/num_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/num_trivia_repository.dart';

typedef _ConcreteOrRandomOption = Future<NumTrivia> Function();

/// Implement and fufill the contracts
class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDataSource localDataSource;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {@required this.localDataSource,
      @required this.remoteDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, NumTrivia>> getConcreteNumberTrivia(int number) async {
    return await _getTrivia(
        () => remoteDataSource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() => remoteDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumTrivia>> _getTrivia(
      _ConcreteOrRandomOption _getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await _getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
