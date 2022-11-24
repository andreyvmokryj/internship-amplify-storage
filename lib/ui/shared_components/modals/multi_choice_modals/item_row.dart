import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget{
  final bool selected;
  final String title;
  final onTap;

  const ItemRow({Key? key, required this.selected, required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 20
      ),
      selected: selected,
      leading: Icon(
        selected ? Icons.check_box : Icons.check_box_outline_blank,
        size: 30,
      ),
      title: Text(title),
      onTap: onTap,
    );
  }
}