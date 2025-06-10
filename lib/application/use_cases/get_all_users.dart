import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class GetAllUsers {
  final UserRepository repository;
  GetAllUsers(this.repository);
  Future<List<User>> call() {
    return repository.getAllUsers();
  }
} 