part of 'navigation_bloc.dart';

abstract class NavigationState {
  NavigationState(this.selectedPageIndex);

  final int selectedPageIndex;
}

class SelectedPageState extends NavigationState {
  SelectedPageState(this.selectedPageIndex):super(0);

  final int selectedPageIndex;
}
