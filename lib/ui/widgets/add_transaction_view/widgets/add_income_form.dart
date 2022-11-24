import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/add_transaction/add_transaction_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/models/TransactionType.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/amount/amount_modal.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/amount/amount_currency_prefix.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/colored_elevated_button.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/stylized_elevated_button.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/single_choice_modals/show_single_choice_modal.dart';
import 'package:radency_internship_project_2/utils/date_helper.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/styles.dart';
import 'package:radency_internship_project_2/utils/ui_utils.dart';
import 'package:radency_internship_project_2/utils/update_forex.dart';

class AddIncomeForm extends StatefulWidget {
  @override
  _AddIncomeFormState createState() => _AddIncomeFormState();
}

class _AddIncomeFormState extends State<AddIncomeForm> {
  static final GlobalKey<FormState> _accountValueFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _categoryValueFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _amountValueFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _noteValueFormKey = GlobalKey<FormState>();

  late DateTime _selectedDateTime;
  String? _accountValue;
  String? _categoryValue;
  double? _amountValue;
  String? _noteValue;

  TextEditingController _dateFieldController = TextEditingController();
  TextEditingController _accountFieldController = TextEditingController();
  TextEditingController _categoryFieldController = TextEditingController();
  TextEditingController _amountFieldController = TextEditingController();
  TextEditingController _noteFieldController = TextEditingController();

  Map<dynamic, bool> _focusMap = {};

  final int _titleFlex = 3;
  final int _textFieldFlex = 7;
  final int _saveButtonFlex = 6;
  final int _continueButtonFlex = 4;

  @override
  void initState() {
    _selectedDateTime = DateTime.now();
    updateForex(context, _selectedDateTime);
    _clearFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTransactionBloc, AddTransactionState>(
      listener: (context, state) {
        if (state is AddTransactionSuccessfulAndContinued) {
          _clearFields();
          showSnackBarMessage(context, S.current.addTransactionSnackBarSuccessMessage);
          FocusScope.of(context).unfocus();
        }

        if (state is AddTransactionSuccessfulAndCompleted) {
          showSnackBarMessage(context, S.current.addTransactionSnackBarSuccessMessage);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is AddTransactionLoaded) {
          return _addIncomeFormBody(state);
        }

        return SizedBox();
      },
    );
  }

  Widget _addIncomeFormBody(AddTransactionLoaded state) {
    return Container(
      decoration: addTransactionFormBodyStyle(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _dateField(),
          _accountField(state.accounts),
          _categoryField(state.incomeCategories),
          _amountField(),
          _noteField(),
          SizedBox(height: 10),
          _submitButtons(),
        ],
      ),
    );
  }

  Widget _dateField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: _fieldTitleWidget(title: S.current.addTransactionDateFieldTitle),
          flex: _titleFlex,
        ),
        Flexible(
          flex: _textFieldFlex,
          child: TextFormField(
            style: addTransactionFormInputTextStyle(),
            decoration: addTransactionFormFieldDecoration(context, focused: _focusMap[AddTransactionFields.Date] ?? false),
            controller: _dateFieldController,
            readOnly: true,
            showCursor: false,
            onTap: () async {
              setState(() {
                focusOnField(_focusMap, AddTransactionFields.Date);
              });
              await _selectNewDate();
            },
          ),
        )
      ],
    );
  }

  Widget _accountField(List<String> accounts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: _fieldTitleWidget(title: S.current.addTransactionAccountFieldTitle),
          flex: _titleFlex,
        ),
        Flexible(
          flex: _textFieldFlex,
          child: Form(
            key: _accountValueFormKey,
            child: TextFormField(
              style: addTransactionFormInputTextStyle(),
              decoration: addTransactionFormFieldDecoration(context, focused: _focusMap[AddTransactionFields.Account] ?? false),
              controller: _accountFieldController,
              readOnly: true,
              showCursor: false,
              onTap: () async {
                setState(() {
                  focusOnField(_focusMap, AddTransactionFields.Account);
                });
                _accountFieldController.text = await showSingleChoiceModal(context: context, values: accounts, type: SingleChoiceModalType.Account, onAddCallback: null) ?? "";
                setState(() {
                  _accountValueFormKey.currentState?.validate();
                });
              },
              onSaved: (value) => _accountValue = value,
              validator: (val) {
                if ((val ?? "").isEmpty) {
                  return S.current.addTransactionAccountFieldValidationEmpty;
                }

                return null;
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _categoryField(List<String> categories) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: _fieldTitleWidget(title: S.current.addTransactionCategoryFieldTitle),
          flex: _titleFlex,
        ),
        Flexible(
          flex: _textFieldFlex,
          child: Form(
            key: _categoryValueFormKey,
            child: TextFormField(
              style: addTransactionFormInputTextStyle(),
              decoration: addTransactionFormFieldDecoration(context, focused: _focusMap[AddTransactionFields.Category] ?? false),
              controller: _categoryFieldController,
              readOnly: true,
              showCursor: false,
              onTap: () async {
                setState(() {
                  focusOnField(_focusMap, AddTransactionFields.Category);
                });
                _categoryFieldController.text = await showSingleChoiceModal(context: context, values: categories, type: SingleChoiceModalType.Category, onAddCallback: null) ?? "";
                setState(() {
                  _categoryValueFormKey.currentState?.validate();
                });
              },
              onSaved: (value) => _categoryValue = value,
              validator: (val) {
                if ((val ?? "").isEmpty) {
                  return S.current.addTransactionCategoryFieldValidationEmpty;
                }

                return null;
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _amountField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: _fieldTitleWidget(title: S.current.addTransactionAmountFieldTitle),
          flex: _titleFlex,
        ),
        Flexible(
          flex: _textFieldFlex,
          child: Form(
            key: _amountValueFormKey,
            child: TextFormField(
              style: addTransactionFormInputTextStyle(),
              decoration: addTransactionFormFieldDecoration(context, prefixIcon: AmountCurrencyPrefix(), focused: _focusMap[AddTransactionFields.Amount] ?? false),
              readOnly: true,
              showCursor: true,
              controller: _amountFieldController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(numberWithDecimalRegExp)),
              ],
              validator: (val) {
                if (!RegExp(moneyAmountRegExp).hasMatch(val ?? "")) {
                  return S.current.addTransactionAmountFieldValidationEmpty;
                }

                return null;
              },
              onTap: () async {
                setState(() {
                  focusOnField(_focusMap, AddTransactionFields.Amount);
                });
                await showSingleChoiceModal(context: context, type: SingleChoiceModalType.Amount, updateAmountCallback: updateAmountCallback);
                setState(() {
                  _amountValueFormKey.currentState?.validate();
                });
              },
              onSaved: (value) => _amountValue = double.tryParse(value ?? ""),
            ),
          ),
        )
      ],
    );
  }

  Widget _noteField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: _fieldTitleWidget(title: S.current.addTransactionNoteFieldTitle),
          flex: _titleFlex,
        ),
        Flexible(
          flex: _textFieldFlex,
          child: Form(
            key: _noteValueFormKey,
            child: TextFormField(
              style: addTransactionFormInputTextStyle(),
              decoration: addTransactionFormFieldDecoration(context),
              controller: _noteFieldController,
              onSaved: (value) => _noteValue = value,
              onTap: (){
                setState(() {
                  focusOnField(_focusMap, AddTransactionFields.Note);
                });
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _submitButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: _saveButtonFlex, child: _saveButton()),
        Expanded(flex: _continueButtonFlex, child: _continueButton()),
      ],
    );
  }

  Widget _saveButton() {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return ColoredElevatedButton(
          child: Text(
            S.current.addTransactionButtonSave,
          ),
          onPressed: () {
            _saveForms();

            if (_validateForms()) {
              BlocProvider.of<AddTransactionBloc>(context).add(AddTransaction(
                  isAddingCompleted: true,
                  transaction: AppTransaction(
                    transactionType: TransactionType.Income,
                    note: _noteValue ?? "",
                    accountOrigin: _accountValue ?? "",
                    date: TemporalDateTime(_selectedDateTime),
                    category: _categoryValue ?? "",
                    amount: _amountValue ?? 0,
                    currency: state.currency,
                  )));
            }
          });
    });
  }

  Widget _continueButton() {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return StylizedElevatedButton(
          child: Text(
            S.current.addTransactionButtonContinue,
          ),
          onPressed: () {
            _saveForms();

            if (_validateForms()) {
              BlocProvider.of<AddTransactionBloc>(context).add(AddTransaction(
                  isAddingCompleted: false,
                  transaction: AppTransaction(
                    transactionType: TransactionType.Income,
                    note: _noteValue ?? "",
                    accountOrigin: _accountValue ?? "",
                    date: TemporalDateTime(_selectedDateTime),
                    category: _categoryValue ?? "",
                    amount: _amountValue ?? 0,
                    currency: state.currency,
                  )));
            }
          });
    });
  }

  Widget _fieldTitleWidget({required String title}) {
    return Text(
      title,
      style: addTransactionFormTitleTextStyle(context),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Future _selectNewDate() async {
    DateTime? result = await showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime(1960), lastDate: DateTime.now());
    if (result != null) {
      setState(() {
        _selectedDateTime = result;
        _dateFieldController.text = DateHelper().dateToTransactionDateString(result);
      });
      updateForex(context, result);
    }
  }

  void updateAmountCallback(var value) {
    String amount = getUpdatedAmount(_amountFieldController, value);
    setState(() {
      _amountFieldController.text = amount;
    });
  }

  void _clearFields() {
    setState(() {
      _selectedDateTime = DateTime.now();
      _dateFieldController.text = DateHelper().dateToTransactionDateString(_selectedDateTime);

      _accountFieldController.text = '';
      _categoryFieldController.text = '';
      _amountFieldController.text = '';
      _noteFieldController.text = '';

      AddTransactionFields.values.forEach((element) {
        _focusMap[element] = false;
      });
    });
  }

  void _saveForms() {
    _accountValueFormKey.currentState?.save();
    _categoryValueFormKey.currentState?.save();
    _amountValueFormKey.currentState?.save();
    _noteValueFormKey.currentState?.save();
  }

  bool _validateForms() {
    bool result = true;

    if (!(_accountValueFormKey.currentState?.validate() ?? false)) {
      result = false;
    }
    if (!(_categoryValueFormKey.currentState?.validate() ?? false)) {
      result = false;
    }
    if (!(_amountValueFormKey.currentState?.validate() ?? false)) {
      result = false;
    }
    if (!(_noteValueFormKey.currentState?.validate() ?? false)) {
      result = false;
    }

    return result;
  }
}

String getUpdatedAmount(TextEditingController controller, var value) {
  String amount = controller.text.toString();

  if (value == CalculatorButton.Back && amount.length > 0) {
    amount = amount.substring(0, amount.length - 1);
  }
  if (RegExp(moneyAmountEditRegExp).hasMatch(amount + value.toString())) {
    amount = amount + value.toString();
  }

  return amount;
}

void focusOnField(Map focusMap, AddTransactionFields field){
  AddTransactionFields.values.forEach((element) {
    focusMap[element] = element == field;
  });
}

enum AddTransactionFields {Date, Account, Category, Amount, Note, Shared, Location, AccountTo, Fees, MinAmount, MaxAmount}
