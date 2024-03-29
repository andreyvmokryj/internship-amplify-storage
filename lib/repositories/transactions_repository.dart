import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:collection/collection.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/providers/amplify_auth_service.dart';
import 'package:radency_internship_project_2/providers/mixpanel_service.dart';
import 'package:radency_internship_project_2/repositories/repository.dart';

class TransactionsRepository extends IRepository<AppTransaction> {
  TransactionsRepository({
    required this.amplifyAuthenticationService
  });

  final AmplifyAuthenticationService amplifyAuthenticationService;

  @override
  Future<void> add(AppTransaction transaction) async {
    try {
      String uid = await amplifyAuthenticationService.getUserID();
      final request = ModelMutations.create(transaction.copyWith(userID: uid));
      final response = await Amplify.API
          .mutate(request: request)
          .response;

      final createdItem = response.data;
      if (createdItem == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${createdItem.toString()}');
      MixpanelService.instance.track("Transaction Added", properties: {
        "type" : transaction.transactionType.toString(),
        "amount" : transaction.amount
      });
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
    }
  }

  @override
  Future<void> delete({String? transactionID}) async {
    String uid = await amplifyAuthenticationService.getUserID();
    final snapshot = await find(transactionID: transactionID);
    if (snapshot != null && snapshot.userID == uid) {
      final request = ModelMutations.deleteById(AppTransaction.classType, transactionID!);
      final response = await Amplify.API.mutate(request: request).response;
      print('Response: $response');
    }
  }

  @override
  Future<AppTransaction?> find({String? transactionID}) async {
    try {
      String uid = await amplifyAuthenticationService.getUserID();
      final request = ModelQueries.get(AppTransaction.classType, transactionID!);
      final response = await Amplify.API.query(request: request).response;
      final result = response.data;
      if (result?.userID != null && result!.userID == uid) {
        return result;
      } else {
        return null;
      }
    } on ApiException catch (e) {
      print('Query failed: $e');
      return null;
    }
  }

  @override
  Future<void> update({AppTransaction? transaction}) async {
    String uid = await amplifyAuthenticationService.getUserID();
    if (transaction!.userID == uid) {
      final request = ModelMutations.update(transaction);
      final response = await Amplify.API.mutate(request: request).response;
      print('Response: $response');
    }
  }

  Future<List<AppTransaction>> getTransactionsByTimePeriod({required DateTime start, required DateTime end}) async {
    try {
      String uid = await amplifyAuthenticationService.getUserID();
      TemporalDateTime _start = TemporalDateTime(start);
      TemporalDateTime _end = TemporalDateTime(end);
      final request = ModelQueries.list(
        AppTransaction.classType,
        where: AppTransaction.USERID.eq(uid)
            .and(AppTransaction.DATE.between(_start, _end))
      );
      final response = await Amplify.API.query(request: request).response;

      final transactions = response.data?.items;
      if (transactions == null) {
        print('errors: ${response.errors}');
        return [];
      }
      return transactions.whereNotNull().toList();
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return [];
  }

  Future<List<AppTransaction?>> getAllData() async {
    try {
      String uid = await amplifyAuthenticationService.getUserID();
      final request = ModelQueries.list(
          AppTransaction.classType, where:
      AppTransaction.USERID.eq(uid));
      final response = await Amplify.API.query(request: request).response;

      final transactions = response.data?.items;
      if (transactions == null) {
        print('errors: ${response.errors}');
        return [];
      }
      return transactions;
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return [];
  }
}
