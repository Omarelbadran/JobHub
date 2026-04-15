import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/get_user/get_user_response.dart';
import '../../repos/auth_repo.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());
  UserData? user;
  Future<void> getUserData() async {
    emit(GetUserLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) throw Exception("No token");

      final response = await AuthRepo.getUser(token);

      user = response.userData;

      emit(GetUserSuccess(response));
    } catch (e) {
      emit(GetUserFailure("Error"));
    }
  }
}
