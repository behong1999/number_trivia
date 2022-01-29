import 'package:dartz/dartz.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';

// Used for converting String inputted in the textfield into int
class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
