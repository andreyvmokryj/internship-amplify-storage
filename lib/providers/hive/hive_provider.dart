import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:radency_internship_project_2/local_models/budget/category_budget.dart';

import 'hive_types.dart';

class HiveProvider {
  static final HiveProvider _singleton = HiveProvider._internal();

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  factory HiveProvider() {
    return _singleton;
  }

  HiveProvider._internal();

  final String budgetsBoxKey = 'budgetsBox';
  final String credentialsBoxKey = 'credentialsBox';

  Future<void> initializeHive(String path) async {
    Hive.init(path);

    var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
    if (!containsEncryptionKey) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }

    try {
      await HiveProvider().openBudgetsBox();
      await HiveProvider().openCredentialsBox();
    } catch (error) {
      print('HiveProvider: initialization error $error');
    }
  }

  Future<Box<CategoryBudget>> openBudgetsBox() async {
    Box<CategoryBudget> box;
    if (!Hive.isBoxOpen(budgetsBoxKey)) {
      if (!Hive.isAdapterRegistered(HiveTypes.CATEGORY_BUDGET)) Hive.registerAdapter(CategoryBudgetAdapter());
      box = await Hive.openBox(budgetsBoxKey);
    } else
      box = Hive.box(budgetsBoxKey);
    return box;
  }

  Future<Box> openCredentialsBox() async {
    var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key') ?? "");
    Box box;
    if (!Hive.isBoxOpen(credentialsBoxKey)) {
      box = await Hive.openBox(credentialsBoxKey, encryptionCipher: HiveAesCipher(encryptionKey));
    } else
      box = Hive.box(credentialsBoxKey);
    return box;
  }
}
