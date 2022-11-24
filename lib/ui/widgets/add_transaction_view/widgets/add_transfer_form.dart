import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/add_transaction/add_transaction_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/models/ModelProvider.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/amount/amount_currency_prefix.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/colored_elevated_button.dart';
import 'package:radency_internship_project_2/ui/shared_components/field_title.dart';
import 'package:radency_internship_project_2/ui/shared_components/elevated_buttons/stylized_elevated_button.dart';
import 'package:radency_internship_project_2/ui/shared_components/modals/single_choice_modals/show_single_choice_modal.dart';
import 'package:radency_internship_project_2/ui/widgets/add_transaction_view/widgets/add_income_form.dart';
import 'package:radency_internship_project_2/utils/date_helper.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/styles.dart';
import 'package:radency_internship_project_2/utils/ui_utils.dart';
import 'package:radency_internship_project_2/utils/update_forex.dart';

class AddTransferForm extends StatefulWidget {
  @override
  _AddTransferFormState createState() => _AddTransferFormState();
}

class _AddTransferFormState extends State<AddTransferForm> {
  static final GlobalKey<FormState> _fromValueFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _toValueFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _amountValueFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _feesValueFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _noteValueFormKey = GlobalKey<FormState>();

  late DateTime _selectedDateTime;
  String? _fromValue;
  String? _toValue;
  double? _amountValue;
  double? _feesValue;
  String? _noteValue;

  TextEditingController _dateFieldController = TextEditingController();
  TextEditingController _fromFieldController = TextEditingController();
  TextEditingController _toFieldController = TextEditingController();
  TextEditingController _amountFieldController = TextEditingController();
  TextEditingController _feesFieldController = TextEditingController();
  TextEditingController _noteFieldController = TextEditingController();

  bool _areFeesVisible = false;

  Map<dynamic, bool> focusMap = {};

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
          return _addTransferFormBody(state);
        }

        return SizedBox();
      },
    );
  }

  Widget _addTransferFormBody(AddTransactionLoaded state) {
    return Container(
      decoration: addTransactionFormBodyStyle(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _dateField(),
          _fromField(state.accounts),
          _toField(state.accounts),
          _amountField(),
          _feesField(),
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
          child: buildFormFieldTitle(context, title: S.current.addTransactionDateFieldTitle),
          flex: _titleFlex,
        ),
        Flexible(
          flex: _textFieldFlex,
          child: TextFormField(
            decoration: addTransactionFormFieldDecoration(context, focused: focusMap[AddTransactionFields.Date] ?? false),
            style: addTransactionFormInputTextStyle(),
            controller: _dateFieldController,
            readOnly: true,
            showCursor: false,
            onTap: () async {
              setState(() {
                focusOnField(focusMap, AddTransactionFields.Date);
              });
              await _selectNewDate();
            },
          ),
        )
      ],
    );
  }

  Widget _fromField(List<String> accounts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: buildFormFieldTitle(context, title: S.current.addTransactionFromFieldTitle),
          flex: _titleFlex,
        ),
        Flexible(
          flex: _textFieldFlex,
          child: Form(
            key: _fromValueFormKey,
            child: TextFormField(
              decoration: addTransactionFormFieldDecoration(context, focused: focusMap[AddTransactionFields.Account] ?? false),
              style: addTransactionFormInputTextStyle(),
              controller: _fromFieldController,
              readOnly: true,
              showCursor: false,
              onTap: () async {
                setState(() {
                  focusOnField(focusMap, AddTransactionFields.Account);
                });
                _fromFieldController.text = await showSingleChoiceModal(context: context, type: SingleChoiceModalType.Account, values: accounts, onAddCallback: null) ?? "";
                setState(() {
                  _fromValueFormKey.currentState!.validate();
                });
              },
              onSaved: (value) => _fromValue = value,
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

  Widget _toField(List<String> accounts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: buildFormFieldTitle(context, title: S.current.addTransactionToFieldTitle),
          flex: _titleFlex,
        ),
        Flexible(
          flex: _textFieldFlex,
          child: Form(
            key: _toValueFormKey,
            child: TextFormField(
              decoration: addTransactionFormFieldDecoration(context, focused: focusMap[AddTransactionFields.AccountTo] ?? false),
              style: addTransactionFormInputTextStyle(),
              controller: _toFieldController,
              readOnly: true,
              showCursor: false,
              onTap: () async {
                setState(() {
                  focusOnField(focusMap, AddTransactionFields.AccountTo);
                });
                _toFieldController.text = await showSingleChoiceModal(context: context, values: accounts, type: SingleChoiceModalType.Account, onAddCallback: null) ?? "";
                setState(() {
                  _toValueFormKey.currentState!.validate();
                });
              },
              onSaved: (value) => _toValue = value,
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

  Widget _amountField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: buildFormFieldTitle(context, title: S.current.addTransactionAmountFieldTitle),
          flex: _titleFlex,
        ),
        Flexible(
          flex: _textFieldFlex,
          child: Row(
            children: [
              Expanded(
                child: Form(
                  key: _amountValueFormKey,
                  child: TextFormField(
                    style: addTransactionFormInputTextStyle(),
                    decoration: addTransactionFormFieldDecoration(context, prefixIcon: AmountCurrencyPrefix(), focused: focusMap[AddTransactionFields.Amount] ?? false),
                    controller: _amountFieldController,
                    readOnly: true,
                    showCursor: false,
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
                        focusOnField(focusMap, AddTransactionFields.Amount);
                      });
                      await showSingleChoiceModal(context: context, type: SingleChoiceModalType.Amount, updateAmountCallback: updateAmountCallback);
                      setState(() {
                        _amountValueFormKey.currentState?.validate();
                      });
                    },
                    onSaved: (value) => _amountValue = double.tryParse(value ?? "") ?? 0,
                  ),
                ),
              ),
              _feesButton(),
            ],
          ),
        )
      ],
    );
  }

  Widget _feesButton() {
    return StylizedElevatedButton(
      child: Text(
        S.current.addTransactionFeesFieldTitle,
      ),
      onPressed: () {
        _toggleFeesVisibility();
      },
    );
  }

  Widget _feesField() {
    return Visibility(
      visible: _areFeesVisible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: buildFormFieldTitle(context, title: S.current.addTransactionFeesFieldTitle),
            flex: _titleFlex,
          ),
          Flexible(
            flex: _textFieldFlex,
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: _feesValueFormKey,
                    child: TextFormField(
                      decoration: addTransactionFormFieldDecoration(context, prefixIcon: AmountCurrencyPrefix(), focused: focusMap[AddTransactionFields.Fees] ?? false),
                      style: addTransactionFormInputTextStyle(),
                      controller: _feesFieldController,
                      readOnly: true,
                      showCursor: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(numberWithDecimalRegExp)),
                      ],
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (val) {
                        if (!_areFeesVisible) {
                          return null;
                        }

                        if (!RegExp(moneyAmountRegExp).hasMatch(val ?? "")) {
                          return S.current.addTransactionAmountFieldValidationEmpty;
                        }

                        return null;
                      },
                      onTap: () async {
                        setState(() {
                          focusOnField(focusMap, AddTransactionFields.Fees);
                        });
                        await showSingleChoiceModal(
                          context: context,
                          type: SingleChoiceModalType.Amount,
                          updateAmountCallback: updateFeeCallback,
                          title: S.current.addTransactionFeesFieldTitle
                        );
                        setState(() {
                          _feesValueFormKey.currentState?.validate();
                        });
                      },
                      onSaved: (value) {
                        _areFeesVisible ? _feesValue = double.tryParse(value ?? "") ?? 0 : _feesValue = 0;
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _noteField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: buildFormFieldTitle(context, title: S.current.addTransactionNoteFieldTitle),
          flex: _titleFlex,
        ),
        Flexible(
          flex: _textFieldFlex,
          child: Form(
            key: _noteValueFormKey,
            child: TextFormField(
              decoration: addTransactionFormFieldDecoration(context),
              style: addTransactionFormInputTextStyle(),
              controller: _noteFieldController,
              onSaved: (value) => _noteValue = value,
              onTap: (){
                setState(() {
                  focusOnField(focusMap, AddTransactionFields.Note);
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
                      transactionType: TransactionType.Transfer,
                      accountOrigin: _fromValue ?? "",
                      accountDestination: _toValue ?? "",
                      note: _noteValue ?? "",
                      fees: _feesValue ?? 0,
                      date: TemporalDateTime(_selectedDateTime),
                      amount: _amountValue ?? 0,
                      currency: state.currency)));
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
                      transactionType: TransactionType.Transfer,
                      note: _noteValue ?? "",
                      accountOrigin: _fromValue ?? "",
                      date: TemporalDateTime(_selectedDateTime),
                      accountDestination: _toValue ?? "",
                      amount: _amountValue ?? 0,
                      fees: _feesValue ?? 0,
                      currency: state.currency)));
            }
          });
    });
  }

  void _toggleFeesVisibility() {
    _areFeesVisible = !_areFeesVisible;
    if (_areFeesVisible) {
      _feesFieldController.text = '';
    }
    setState(() {});
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

  void updateFeeCallback(var value) {
    String amount = getUpdatedAmount(_feesFieldController, value);
    setState(() {
      _feesFieldController.text = amount;
    });
  }

  void _clearFields() {
    setState(() {
      _selectedDateTime = DateTime.now();
      _dateFieldController.text = DateHelper().dateToTransactionDateString(_selectedDateTime);

      _fromFieldController.text = '';
      _toFieldController.text = '';
      _amountFieldController.text = '';
      _noteFieldController.text = '';
      _areFeesVisible = false;

      AddTransactionFields.values.forEach((element) {
        focusMap[element] = false;
      });
    });
  }

  void _saveForms() {
    _toValueFormKey.currentState!.save();
    _fromValueFormKey.currentState!.save();
    _amountValueFormKey.currentState!.save();
    _noteValueFormKey.currentState!.save();
    if (_areFeesVisible) {
      _feesValueFormKey.currentState!.save();
    }
  }

  bool _validateForms() {
    bool result = true;

    if (!_fromValueFormKey.currentState!.validate()) {
      result = false;
    }
    if (!_toValueFormKey.currentState!.validate()) {
      result = false;
    }
    if (!_amountValueFormKey.currentState!.validate()) {
      result = false;
    }
    if (!_noteValueFormKey.currentState!.validate()) {
      result = false;
    }
    if (_areFeesVisible && !_feesValueFormKey.currentState!.validate()) {
      result = false;
    }

    return result;
  }
}
