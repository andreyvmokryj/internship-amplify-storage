import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:radency_internship_project_2/custom_animations/custom_oneshot_animation.dart';
import 'package:radency_internship_project_2/riverpods/bear_notifier.dart';
import 'package:radency_internship_project_2/riverpods/bear_state.dart';
import 'package:rive/rive.dart';

class AnimatedBearWidget extends ConsumerStatefulWidget{
  @override
  ConsumerState<AnimatedBearWidget> createState() => _AnimatedBearWidgetState();
}

class _AnimatedBearWidgetState extends ConsumerState<AnimatedBearWidget> {
  late RiveAnimationController _successController;
  late RiveAnimationController _idleController;
  late SimpleAnimation _upController;
  late SimpleAnimation _downController;

  bool isMoving() => _upController.isActive || _downController.isActive;
  bool movedUp = false;
  bool movedDown = false;

  @override
  void initState() {
    _successController = OneShotAnimation(
      'success',
      autoplay: false,
      onStop: () => setState((){
        _idleController.isActive = true;
      }),
      onStart: () => setState((){}),
    );
    _idleController = SimpleAnimation(
      'idle',
      autoplay: true,
    );
    _upController = CustomOneShotAnimation(
      'Hands_up',
      autoplay: false,
      onStop: () => setState((){}),
      onStart: () => setState((){
        movedUp = true;
      }),
    );
    _downController = CustomOneShotAnimation(
      'hands_down',
      autoplay: false,
      onStop: () async {
        _toggleInitial();
        await Future.delayed(Duration(milliseconds: 100));
        ref.read(bearProvider.notifier).toggleInitial();
        await Future.delayed(Duration(milliseconds: 100));
        setState(() {

        });
      },
      onStart: () => setState((){
        movedDown = true;
      }),
    );
    super.initState();
  }

  void _toggleSuccess(){
    print("Toggle Success!");
    _idleController.isActive = false;
    _successController.isActive = true;
  }

  void _toggleHandsUp() async {
    if (!isMoving() && !movedUp) {
      print("Toggle Up");
      _idleController.isActive = false;
      _downController.reset();
      _upController.reset();
      _upController.isActive = false;
      _downController.isActive = false;
      await Future.delayed(Duration(milliseconds: 100));
      _upController.isActive = true;
      setState(() {

      });
    }
  }

  void _toggleDown() async{
    if (!isMoving() && !movedDown) {
      print("Toggle Down");
      _idleController.isActive = false;
      // _upController.reset();
      _upController.isActive = false;
      _downController.isActive = false;
      // await Future.delayed(Duration(milliseconds: 100));
      _downController.reset();
      await Future.delayed(Duration(milliseconds: 100));
      _downController.isActive = true;

      setState(() {

      });
    }
  }

  void _toggleInitial() async {
    print("Toggle Initial");
    _downController.reset();
    _upController.reset();
    _upController.isActive = false;
    _downController.isActive = false;
    _idleController.isActive = true;
    movedUp = false;
    movedDown = false;
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {});
  }

  void _toggleFail(){

  }

  @override
  Widget build(BuildContext context) {
    BearState bearState  = ref.watch(bearProvider);
    switch (bearState.runtimeType) {
      case BearStateSuccess:
        _toggleSuccess();
        break;
      case BearStateFail:
        _toggleFail();
        break;
      case BearStateHandsUp:
        _toggleHandsUp();
        break;
      case BearStateHandsDown:
        _toggleDown();
        break;
      case BearStateInitial:
        // _toggleInitial();
        break;
    }

    return Container(
      width: 56,
      child: RiveAnimation.asset(
        "assets/animations/headless_bear.riv",
        controllers: [
          _successController,
          _idleController,
          _upController,
          _downController,
        ],
        onInit: (_) => setState((){}),
      ),
    );
  }
}