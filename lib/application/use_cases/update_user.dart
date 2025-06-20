import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UpdateUser {
  final UserRepository repository;
  UpdateUser(this.repository);
  Future<User> call(User user) {
    return repository.updateUser(user);
  }
} 