import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixpanelService {
  static Mixpanel? _instance;
  static Mixpanel get instance => _instance!;

  static Future<void> init() async {
    _instance = await Mixpanel.init("0171734cddc4bdc308a48cdaaa90cc55", trackAutomaticEvents: true);
  }
}