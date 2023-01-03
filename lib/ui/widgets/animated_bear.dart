import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:radency_internship_project_2/riverpods/bear_notifier.dart';
import 'package:radency_internship_project_2/riverpods/bear_state.dart';
import 'package:rive/rive.dart';

class AnimatedBearWidget extends ConsumerStatefulWidget{
  @override
  ConsumerState<AnimatedBearWidget> createState() => _AnimatedBearWidgetState();
}

class _AnimatedBearWidgetState extends ConsumerState<AnimatedBearWidget> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    _controller = OneShotAnimation(
      'success',
      autoplay: false,
      onStop: () => setState((){}),
      onStart: () => setState((){}),
    );
    super.initState();
  }

  void _toggleSuccess(){
    print("Toggle Success!");
    _controller.isActive = true;
  }

  void _toggleFail(){

  }

  @override
  Widget build(BuildContext context) {
    BearState bearState  = ref.watch(bearProvider);
    if (bearState is BearStateSuccess) {
      _toggleSuccess();
    }
    if (bearState is BearStateFail) {
      _toggleFail();
    }

    return Container(
      width: 56,
      child: RiveAnimation.asset(
        "assets/animations/headless_bear.riv",
        controllers: [_controller],
      ),
    );
  }
}