import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_errors.dart';
import '../../models/get_all_users/get_all_users.response.dart';
import '../../models/login/login_response.dart';
import '../../repos/auth_repo.dart';

part 'get_all_users_state.dart';

class GetAllUsersCubit extends Cubit<GetAllUsersState> {
  GetAllUsersCubit() : super(GetAllUsersInitial());
  List<UserData> users = [];

  Future<void> getAllUsers() async {
    emit(GetAllUsersLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await AuthRepo.getAllUsers(token);

      users = response.users ?? [];

      emit(GetAllUsersSuccess(response));
    } on Exception catch (e) {
      String errorMessage = APIError.getErrorMessage(e);
      emit(GetAllUsersFailure(errorMessage));
    }
  }
}
