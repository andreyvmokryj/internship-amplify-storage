/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName)
      : _assetName = assetName,
        super(assetName);
  final String _assetName;

  Image image({
    ImageFrameBuilder frameBuilder,
    ImageLoadingBuilder loadingBuilder,
    ImageErrorWidgetBuilder errorBuilder,
    String semanticLabel,
    bool excludeFromSemantics = false,
    double width,
    double height,
    Color color,
    BlendMode colorBlendMode,
    BoxFit fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(image: this, frameBuilder: frameBuilder);
  }

  String get path => _assetName;
}

class Asset {
  Asset._();
  static AssetGenImage wallet = 
      const AssetGenImage('assets/images/Wallet.png');
  static AssetGenImage coolKidsStudy = 
      const AssetGenImage('assets/images/cool_kids_study.png');
  static AssetGenImage coolKidsLongDistanceRelationship = 
      const AssetGenImage('assets/images/cool_kids_long_distance_relationship.png');
  static AssetGenImage coolKidsHighTech = 
      const AssetGenImage('assets/images/cool_kids_high_tech.png');
}