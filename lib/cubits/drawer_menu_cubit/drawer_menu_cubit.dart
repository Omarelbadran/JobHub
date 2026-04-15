import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'drawer_menu_state.dart';

class DrawerMenuCubit extends Cubit<DrawerMenuState> {
  DrawerMenuCubit() : super(DrawerMenuClosed(0));
  void toggleDrawer() {
    if (state is DrawerMenuClosed) {
      emit(DrawerMenuOpen(state.selectedIndex));
    } else {
      emit(DrawerMenuClosed(state.selectedIndex));
    }
  }

  void changePage(int index) {
    emit(DrawerMenuOpen(index));
  }
}
