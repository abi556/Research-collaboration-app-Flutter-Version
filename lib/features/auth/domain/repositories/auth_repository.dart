import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password, [String? name]);
  Future<Either<Failure, User>> signup(String email, String password, String role, String name);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> forgotPassword(String email);
  Future<Either<Failure, User?>> getCurrentUser();
} 