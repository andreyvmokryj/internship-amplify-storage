import 'package:flutter/widgets.dart';
import 'package:rive/src/controllers/simple_controller.dart';

/// Controller tailered for managing one-shot animations
class CustomOneShotAnimation extends SimpleAnimation {
  /// Fires when the animation stops being active
  final VoidCallback? onStop;

  /// Fires when the animation starts being active
  final VoidCallback? onStart;

  CustomOneShotAnimation(
      String animationName, {
        double mix = 1,
        bool autoplay = true,
        this.onStop,
        this.onStart,
      }) : super(animationName, mix: mix, autoplay: autoplay) {
    isActiveChanged.addListener(onActiveChanged);
  }

  /// Dispose of any callback listeners
  @override
  void dispose() {
    super.dispose();
    isActiveChanged.removeListener(onActiveChanged);
  }

  /// Perform tasks when the animation's active state changes
  void onActiveChanged() {
    // Fire any callbacks
    isActive
        ? onStart?.call()
    // onStop can fire while widgets are still drawing
        : WidgetsBinding.instance.addPostFrameCallback((_) => onStop?.call());
  }
}