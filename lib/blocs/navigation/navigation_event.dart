part of 'navigation_bloc.dart';

abstract class NavigationEvent {
  const NavigationEvent();

}

class SelectPage implements NavigationEvent {
  const SelectPage(this.selectedPageIndex);

  final int selectedPageIndex;
}
