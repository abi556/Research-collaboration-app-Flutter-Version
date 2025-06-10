import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../infrastructure/repositories/user_repository_impl.dart';
import '../use_cases/get_user_by_id.dart';
import '../use_cases/get_all_users.dart';
import '../use_cases/update_user.dart';
import '../use_cases/delete_user.dart';

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  return UserRepositoryImpl();
});

final getUserByIdProvider = Provider<GetUserById>((ref) {
  return GetUserById(ref.watch(userRepositoryProvider));
});

final getAllUsersProvider = Provider<GetAllUsers>((ref) {
  return GetAllUsers(ref.watch(userRepositoryProvider));
});

final updateUserProvider = Provider<UpdateUser>((ref) {
  return UpdateUser(ref.watch(userRepositoryProvider));
});

final deleteUserProvider = Provider<DeleteUser>((ref) {
  return DeleteUser(ref.watch(userRepositoryProvider));
});

final allUsersStateProvider = FutureProvider<List<User>>((ref) async {
  final getAllUsers = ref.watch(getAllUsersProvider);
  return await getAllUsers();
}); 