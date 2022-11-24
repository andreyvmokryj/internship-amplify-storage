import 'package:flutter/material.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/ui/widgets/transactions_view/widgets/transactions_slider.dart';
import 'package:radency_internship_project_2/utils/styles.dart';

class DesignTransactionHeader extends StatefulWidget{
  final tabBarController;

  const DesignTransactionHeader({Key? key, this.tabBarController}) : super(key: key);

  @override
  _DesignTransactionHeaderState createState() => _DesignTransactionHeaderState();
}

class _DesignTransactionHeaderState extends State<DesignTransactionHeader> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.tabBarController.index;
    widget.tabBarController.addListener((){
      setState(() {
        selectedIndex = widget.tabBarController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionsTabSlider(),
        transactionsTabBar(context, widget.tabBarController),
      ],
    );
  }

  Widget transactionsTabBar(BuildContext context, TabController controller) {
    List buttonLabels = [
      S.current.transactionsTabTitleDaily,
      S.current.transactionsTabTitleCalendar,
      S.current.transactionsTabTitleWeekly,
      S.current.transactionsTabTitleMonthly,
      S.current.transactionsTabTitleSummary,
    ];
    
    return Container(
      child: TabBar(
        labelPadding: EdgeInsets.zero,
        controller: controller,
        isScrollable: true,
        tabs: buttonLabels.map((element) {
          bool selected = selectedIndex == buttonLabels.indexOf(element);

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: selected ? Colors.black12 : null,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Tab(
              child: Text(
                element,
                style: tabTitleStyle(context),
              ),
            ),
          );
        }).toList(),
        indicatorColor: Colors.transparent,
      ),
    );
  }

  Widget tabTitle(String localizedTitle) {
    return Text(
      localizedTitle,
      style: tabTitleStyle(context),
    );
  }
}