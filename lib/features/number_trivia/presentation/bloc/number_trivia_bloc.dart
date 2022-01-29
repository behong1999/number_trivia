import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/core/usecases/usecase.dart';
import 'package:number_trivia_clean_architecture/core/util/input_converter.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/num_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    //* Change the constructor parametr's name
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required InputConverter converter,
  })  
  //* Make sure the pass of arguments is not null
  : assert(concrete != null),
        assert(random != null),
        assert(converter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        inputConverter = converter,
        super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      emit(Loading());
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      print(inputEither);
      await inputEither.fold(
        (failure) {
          emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
        },
        (integer) async {
          //NOTE: Error starts from here
          //* Turns Future<Either<Failure, NumTrivia>> into Either<Failure, NumTrivia>
          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(integer));

          failureOrTrivia.fold(
            (failure) => emit(Error(
                // message: failure is ServerFailure
                //     ? SERVER_FAILURE_MESSAGE
                //     : CACHE_FAILURE_MESSAGE,
                message: _fromFailureToMessage(failure))),
            (trivia) => emit(Loaded(trivia: trivia)),
          );
        },
      );
    });
    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getRandomNumberTrivia(
        NoParams(),
      );
      failureOrTrivia.fold(
        (failure) => emit(Error(message: _fromFailureToMessage(failure))),
        (trivia) => emit(Loaded(trivia: trivia)),
      );
    });
  }
}

//* Easy to return failure message and can be add more types of failure in the future
String _fromFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected Error';
  }
}
