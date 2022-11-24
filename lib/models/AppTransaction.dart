/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the AppTransaction type in your schema. */
@immutable
class AppTransaction extends Model {
  static const classType = const _AppTransactionModelType();
  final String id;
  final TransactionType _transactionType;
  final TemporalDateTime? _date;
  final String? _accountOrigin;
  final double? _amount;
  final String? _note;
  final String? _currency;
  final String? _subcurrency;
  final String? _category;
  final ExpenseCreationType? _creationType;
  final double? _locationLatitude;
  final double? _locationLongitude;
  final String? _accountDestination;
  final double? _fees;
  final String? _userID;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  TransactionType get transactionType {
    try {
      return _transactionType!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime get date {
    try {
      return _date!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get accountOrigin {
    try {
      return _accountOrigin!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get amount {
    try {
      return _amount!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get note {
    return _note;
  }
  
  String get currency {
    try {
      return _currency!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get subcurrency {
    return _subcurrency;
  }
  
  String? get category {
    return _category;
  }
  
  ExpenseCreationType? get creationType {
    return _creationType;
  }
  
  double? get locationLatitude {
    return _locationLatitude;
  }
  
  double? get locationLongitude {
    return _locationLongitude;
  }
  
  String? get accountDestination {
    return _accountDestination;
  }
  
  double? get fees {
    return _fees;
  }
  
  String get userID {
    try {
      return _userID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const AppTransaction._internal({required this.id, required transactionType, required date, required accountOrigin, required amount, note, required currency, subcurrency, category, creationType, locationLatitude, locationLongitude, accountDestination, fees, required userID, createdAt, updatedAt}): _transactionType = transactionType, _date = date, _accountOrigin = accountOrigin, _amount = amount, _note = note, _currency = currency, _subcurrency = subcurrency, _category = category, _creationType = creationType, _locationLatitude = locationLatitude, _locationLongitude = locationLongitude, _accountDestination = accountDestination, _fees = fees, _userID = userID, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory AppTransaction({String? id, required TransactionType transactionType, required TemporalDateTime date, required String accountOrigin, required double amount, String? note, required String currency, String? subcurrency, String? category, ExpenseCreationType? creationType, double? locationLatitude, double? locationLongitude, String? accountDestination, double? fees, String? userID}) {
    return AppTransaction._internal(
      id: id == null ? UUID.getUUID() : id,
      transactionType: transactionType,
      date: date,
      accountOrigin: accountOrigin,
      amount: amount,
      note: note,
      currency: currency,
      subcurrency: subcurrency,
      category: category,
      creationType: creationType,
      locationLatitude: locationLatitude,
      locationLongitude: locationLongitude,
      accountDestination: accountDestination,
      fees: fees,
      userID: userID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppTransaction &&
      id == other.id &&
      _transactionType == other._transactionType &&
      _date == other._date &&
      _accountOrigin == other._accountOrigin &&
      _amount == other._amount &&
      _note == other._note &&
      _currency == other._currency &&
      _subcurrency == other._subcurrency &&
      _category == other._category &&
      _creationType == other._creationType &&
      _locationLatitude == other._locationLatitude &&
      _locationLongitude == other._locationLongitude &&
      _accountDestination == other._accountDestination &&
      _fees == other._fees &&
      _userID == other._userID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("AppTransaction {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("transactionType=" + (_transactionType != null ? enumToString(_transactionType)! : "null") + ", ");
    buffer.write("date=" + (_date != null ? _date!.format() : "null") + ", ");
    buffer.write("accountOrigin=" + "$_accountOrigin" + ", ");
    buffer.write("amount=" + (_amount != null ? _amount!.toString() : "null") + ", ");
    buffer.write("note=" + "$_note" + ", ");
    buffer.write("currency=" + "$_currency" + ", ");
    buffer.write("subcurrency=" + "$_subcurrency" + ", ");
    buffer.write("category=" + "$_category" + ", ");
    buffer.write("creationType=" + (_creationType != null ? enumToString(_creationType)! : "null") + ", ");
    buffer.write("locationLatitude=" + (_locationLatitude != null ? _locationLatitude!.toString() : "null") + ", ");
    buffer.write("locationLongitude=" + (_locationLongitude != null ? _locationLongitude!.toString() : "null") + ", ");
    buffer.write("accountDestination=" + "$_accountDestination" + ", ");
    buffer.write("fees=" + (_fees != null ? _fees!.toString() : "null") + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  AppTransaction copyWith({String? id, TransactionType? transactionType, TemporalDateTime? date, String? accountOrigin, double? amount, String? note, String? currency, String? subcurrency, String? category, ExpenseCreationType? creationType, double? locationLatitude, double? locationLongitude, String? accountDestination, double? fees, String? userID}) {
    return AppTransaction._internal(
      id: id ?? this.id,
      transactionType: transactionType ?? this.transactionType,
      date: date ?? this.date,
      accountOrigin: accountOrigin ?? this.accountOrigin,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      currency: currency ?? this.currency,
      subcurrency: subcurrency ?? this.subcurrency,
      category: category ?? this.category,
      creationType: creationType ?? this.creationType,
      locationLatitude: locationLatitude ?? this.locationLatitude,
      locationLongitude: locationLongitude ?? this.locationLongitude,
      accountDestination: accountDestination ?? this.accountDestination,
      fees: fees ?? this.fees,
      userID: userID ?? this.userID);
  }
  
  AppTransaction.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _transactionType = enumFromString<TransactionType>(json['transactionType'], TransactionType.values)!,
      _date = json['date'] != null ? TemporalDateTime.fromString(json['date']) : null,
      _accountOrigin = json['accountOrigin'],
      _amount = (json['amount'] as num?)?.toDouble(),
      _note = json['note'],
      _currency = json['currency'],
      _subcurrency = json['subcurrency'],
      _category = json['category'],
      _creationType = enumFromString<ExpenseCreationType>(json['creationType'], ExpenseCreationType.values),
      _locationLatitude = (json['locationLatitude'] as num?)?.toDouble(),
      _locationLongitude = (json['locationLongitude'] as num?)?.toDouble(),
      _accountDestination = json['accountDestination'],
      _fees = (json['fees'] as num?)?.toDouble(),
      _userID = json['userID'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'transactionType': enumToString(_transactionType), 'date': _date?.format(), 'accountOrigin': _accountOrigin, 'amount': _amount, 'note': _note, 'currency': _currency, 'subcurrency': _subcurrency, 'category': _category, 'creationType': enumToString(_creationType), 'locationLatitude': _locationLatitude, 'locationLongitude': _locationLongitude, 'accountDestination': _accountDestination, 'fees': _fees, 'userID': _userID, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'transactionType': _transactionType, 'date': _date, 'accountOrigin': _accountOrigin, 'amount': _amount, 'note': _note, 'currency': _currency, 'subcurrency': _subcurrency, 'category': _category, 'creationType': _creationType, 'locationLatitude': _locationLatitude, 'locationLongitude': _locationLongitude, 'accountDestination': _accountDestination, 'fees': _fees, 'userID': _userID, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField TRANSACTIONTYPE = QueryField(fieldName: "transactionType");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField ACCOUNTORIGIN = QueryField(fieldName: "accountOrigin");
  static final QueryField AMOUNT = QueryField(fieldName: "amount");
  static final QueryField NOTE = QueryField(fieldName: "note");
  static final QueryField CURRENCY = QueryField(fieldName: "currency");
  static final QueryField SUBCURRENCY = QueryField(fieldName: "subcurrency");
  static final QueryField CATEGORY = QueryField(fieldName: "category");
  static final QueryField CREATIONTYPE = QueryField(fieldName: "creationType");
  static final QueryField LOCATIONLATITUDE = QueryField(fieldName: "locationLatitude");
  static final QueryField LOCATIONLONGITUDE = QueryField(fieldName: "locationLongitude");
  static final QueryField ACCOUNTDESTINATION = QueryField(fieldName: "accountDestination");
  static final QueryField FEES = QueryField(fieldName: "fees");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "AppTransaction";
    modelSchemaDefinition.pluralName = "AppTransactions";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["userID"], name: "byUser")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.TRANSACTIONTYPE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.DATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.ACCOUNTORIGIN,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.AMOUNT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.NOTE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.CURRENCY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.SUBCURRENCY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.CATEGORY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.CREATIONTYPE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.LOCATIONLATITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.LOCATIONLONGITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.ACCOUNTDESTINATION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.FEES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppTransaction.USERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _AppTransactionModelType extends ModelType<AppTransaction> {
  const _AppTransactionModelType();
  
  @override
  AppTransaction fromJson(Map<String, dynamic> jsonData) {
    return AppTransaction.fromJson(jsonData);
  }
}