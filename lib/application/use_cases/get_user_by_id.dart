import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class GetUserById {
  final UserRepository repository;
  GetUserById(this.repository);
  Future<User> call(int id) {
    return repository.getUserById(id);
  }
} 