part of 'drawer_menu_cubit.dart';

@immutable
sealed class DrawerMenuState {
  final int selectedIndex;
 const DrawerMenuState(this.selectedIndex);
}

final class DrawerMenuClosed extends DrawerMenuState {
 const DrawerMenuClosed(super.selectedIndex);
}

final class DrawerMenuOpen extends DrawerMenuState {
 const DrawerMenuOpen(super.selectedIndex);
}
