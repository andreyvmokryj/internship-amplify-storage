import 'package:flutter/material.dart';

class DesignScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? header;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const DesignScaffold({Key? key, this.appBar, this.header, this.body, this.floatingActionButton, this.bottomNavigationBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).primaryColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(child: header ?? Container()),
            SliverToBoxAdapter(child: SizedBox(height: 20,),),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Colors.white,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            child: body ?? Container()
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar ?? Container(
        height: 0,
      ),
      floatingActionButton: floatingActionButton ?? Container(),
    );
  }
}