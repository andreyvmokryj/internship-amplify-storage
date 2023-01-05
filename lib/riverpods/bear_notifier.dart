import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radency_internship_project_2/riverpods/bear_state.dart';

class BearNotifier extends StateNotifier<BearState> {
  BearNotifier() : super(BearStateInitial());

  void toggleSuccess() async {
    state = BearStateSuccess();
    await Future.delayed(Duration(seconds: 3));
    state = BearStateInitial();
  }

  void toggleFail() async {
    state = BearStateFail();
    await Future.delayed(Duration(seconds: 3));
    state = BearStateInitial();
  }

  void toggleHandsUp() {
    state = BearStateHandsUp();
  }

  void toggleHandsDown() async {
    state = BearStateHandsDown();
  }

  void toggleInitial() async {
    state = BearStateInitial();
  }
}

final bearProvider = StateNotifierProvider<BearNotifier, BearState>((ref) {
  return BearNotifier();
});