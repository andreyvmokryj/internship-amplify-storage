import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/image_picker/image_picker_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/utils/routes.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';

class AddTransactionMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ImagePickerBloc imageBloc = BlocProvider.of<ImagePickerBloc>(context);

    return BlocBuilder<ImagePickerBloc, ImagePickerState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.09),
        child: CupertinoActionSheet(
          actions: createMenuItems(imageBloc, context),
          cancelButton: CupertinoActionSheetAction(
            child: Text(S.current.cancel, style: addTransactionMenuCancelButtonTextStyle()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    });
  }

  List<Widget> createMenuItems(imageBloc, context) {
    return [
      menuItem(onPressed: () {}, title: S.current.addTransaction, textStyle: addTransactionMenuTitleTextStyle()),
      menuItem(
        onPressed: () {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(Routes.addTransactionPage);
        },
        title: S.current.form,
      ),
      menuItem(
          onPressed: () {
            Navigator.pop(context);
            imageBloc.add(ImageFromGallery());
          },
          title: S.current.gallery),
      menuItem(
          onPressed: () {
            Navigator.pop(context);
            imageBloc.add(ImageFromCamera());
          },
          title: S.current.camera),
    ];
  }

  Widget menuItem({required Function onPressed, required String title, TextStyle? textStyle}) {
    return Material(
      child: GestureDetector(
        onTap: (){
          onPressed.call();
        },
        child: ListTile(title: Text(title, style: textStyle ?? addTransactionMenuItemTextStyle())),
      ),
    );
  }
}
