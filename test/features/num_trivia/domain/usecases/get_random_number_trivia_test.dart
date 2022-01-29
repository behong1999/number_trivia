import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture/core/usecases/usecase.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/num_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/num_trivia_repository.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  //* Runs before every individual test
  setUp(() {
    //* Instanstiation
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumberTrivia = NumTrivia(number: 1, text: 'test');

  test('should get trivia from the repository', () async {
    //? arrange phase
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumberTrivia));

    //? act
    //* Random number does not require any parameters
    //* because the API creates a random number
    final result = await usecase(NoParams());

    //? assert
    expect(result, Right(tNumberTrivia));

    // Verify that the method has been called on the Repository
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());

    // Only the above method should be called and nothing more
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
