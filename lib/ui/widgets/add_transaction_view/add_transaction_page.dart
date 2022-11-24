import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/add_transaction/transaction_type/transaction_type_bloc.dart';
import 'package:radency_internship_project_2/models/TransactionType.dart';
import 'package:radency_internship_project_2/ui/shared_components/design_scaffold.dart';
import 'package:radency_internship_project_2/ui/widgets/add_transaction_view/widgets/expenses_types_view.dart';
import 'package:radency_internship_project_2/utils/styles.dart';

class AddTransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
      appBar: _buildAppBar(context),
      header: _buildHeader(context),
      body: SingleChildScrollView(
        child: ExpensesTypesTabbar(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: BlocBuilder<TransactionTypeBloc, TransactionTypeState>(
        builder: (context, state) {
          TransactionType selectedTab = state.selectedType;
          String title = getTransactionType(selectedTab.toString().split('.').last);

          return Text(title, style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),);
        }
      ),
      centerTitle: true,
      toolbarHeight: 80,
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_sharp),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<TransactionTypeBloc, TransactionTypeState>(
      builder: (context, state) {
        TransactionType selectedTab = state.selectedType;

        return Container(
          padding: EdgeInsets.all(15),
          child: Row(
            children: TransactionType.values.map((element) {
              return Expanded(
                child: Container(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      backgroundColor: element == selectedTab ? Colors.black12 : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    child: Text(
                      getTransactionType(element.toString().split('.').last),
                      style: tabTitleStyle(context),
                    ),
                    onPressed: () {
                      BlocProvider.of<TransactionTypeBloc>(context).add(TransactionSelectType(element));
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }
    );
  }
}
