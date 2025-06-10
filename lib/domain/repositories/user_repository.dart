import '../entities/user.dart';

abstract class UserRepository {
  Future<User> getUserById(int id);
  Future<List<User>> getAllUsers();
  Future<User> updateUser(User user);
  Future<void> deleteUser(int id);
} 