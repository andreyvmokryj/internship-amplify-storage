import 'dart:math';
import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/utils/routes.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {

  final controller = PageController();
  static const duration = const Duration(milliseconds: 300);
  static const curve = Curves.ease;

  singleScreen({imagePath, titleText, mainText}) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(children: [
          Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
              child: Image.asset(imagePath, width: double.infinity,),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Text(
                  titleText, 
                  style: textStyleHeader(color: Theme.of(context).colorScheme.secondary)),
                margin: EdgeInsets.only(bottom: 24),
              ),
              Container(
                child: Text(
                  mainText,
                  textAlign: TextAlign.center, 
                  style: textStyleOnboardingScreensMainText(context)),
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
              )
            ]
          ))
      ]),
    );
  }
  selectPage(pagesCount) => (page) {
    if(page > pagesCount) {
      controller.animateToPage(
        0, 
        duration: duration,
        curve: curve);
      Navigator.pushNamedAndRemoveUntil(context, Routes.loginPage, (route) => false);

    } else {
      controller.animateToPage(
        page, 
        duration: duration,
        curve: curve);
    }
  };
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      singleScreen(
        imagePath: "assets/images/cool_kids_high_tech.png", 
        titleText: 'Your personal money manager',
        mainText: 'The best financial assistant for\nyour expenses'),
      singleScreen(
        imagePath: "assets/images/cool_kids_long_distance_relationship.png", 
        titleText: 'Planning from every corner',
        mainText: 'Plan and track your finances without\nleaving your home.'),
      singleScreen(
        imagePath: "assets/images/cool_kids_study.png", 
        titleText: 'All features on one device',
        mainText: 'Enjoy unlimited functions with no ads\nand other distracting things.'),
    ];
    return Scaffold(
      body: Stack(
          children: <Widget>[
            PageView.builder(
              onPageChanged: selectPage(pages.length - 1),
              physics: BouncingScrollPhysics(),
              controller: controller,
              itemBuilder: (BuildContext context, int index) {
                return pages[index % pages.length];
              },
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: DotsIndicator(
                  controller: controller,
                  itemCount: pages.length,
                  color: Theme.of(context).colorScheme.secondary,
                  onPageSelected: selectPage(pages.length - 1),
                ),
              ),
            ),
          ],
        ),
      
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
    this.color,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color? color;

  static const double dotSize = 8.0;
  static const double dotSizeIndex = 2.5;
  
  Widget Function(int) buildDot(context) {
    return (int index) {
      double selectedness = Curves.easeOut.transform(
        max(
          0.0,
          1.0 - ((controller.page ?? controller.initialPage)  - index).abs(),
        ),
      );
      double zoom = 1.0 + dotSizeIndex * selectedness;
      return Container(
        margin: EdgeInsets.all(3),
        child: Center(
          child: Container(
            width: dotSize * zoom,
            height: dotSize,
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Theme.of(context).colorScheme.secondary,),
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      );
    };
  }

  Widget build(BuildContext context) {
    return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(),
        Flexible(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List<Widget>.generate(itemCount, buildDot(context)),)), 
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () => onPageSelected((controller.page ?? 0).round() + 1),
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Icon(Icons.arrow_forward_ios_sharp, color: Colors.white, size: 12))
          ))
      ]
    ));
  }
}
