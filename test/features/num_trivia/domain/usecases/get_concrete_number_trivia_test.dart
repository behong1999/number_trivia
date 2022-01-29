import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/num_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/num_trivia_repository.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  //* Runs before every individual test
  setUp(() {
    //* Instanstiation
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumber = 1;
  final tNumberTrivia = NumTrivia(number: 1, text: 'test');

  test('should get trivia for the number from the repository', () async {
    //? arrange phase
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber))
        .thenAnswer((_) async => Right(tNumberTrivia));

    //? act
    final result = await usecase(Params(tNumber));

    //? assert
    expect(result, Right(tNumberTrivia));

    // Verify that the method has been called on the Repository
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));

    // Only the above method should be called and nothing more
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
