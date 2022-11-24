import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:collection/collection.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/providers/amplify_auth_service.dart';
import 'package:radency_internship_project_2/repositories/repository.dart';

class TransactionsRepository extends IRepository<AppTransaction> {
  TransactionsRepository({
    required this.amplifyAuthenticationService
  });

  final AmplifyAuthenticationService amplifyAuthenticationService;

  @override
  Future<void> add(AppTransaction transaction) async {
    String uid = await amplifyAuthenticationService.getUserID();
    await Amplify.DataStore.save(transaction.copyWith(userID: uid));
  }

  @override
  Future<void> delete({String? transactionID}) async {
    String uid = await amplifyAuthenticationService.getUserID();
    final snapshot = await find(transactionID: transactionID);
    if (snapshot != null && snapshot.userID == uid) {
      await Amplify.DataStore.delete(snapshot);
    }
  }

  @override
  Future<AppTransaction?> find({String? transactionID}) async {
    String uid = await amplifyAuthenticationService.getUserID();
    final snapshot = await Amplify.DataStore.query(
      AppTransaction.classType,
      where: AppTransaction.ID.eq(transactionID)
          .and(AppTransaction.USERID.eq(uid))
    );

    return snapshot.firstOrNull;
  }

  @override
  Future<void> update({AppTransaction? transaction}) async {
    String uid = await amplifyAuthenticationService.getUserID();
    if (transaction!.userID == uid) {
      await Amplify.DataStore.save(transaction);
    }
  }

  Future<Stream<QuerySnapshot<AppTransaction>>> getTransactionsByTimePeriod({required DateTime start, required DateTime end}) async {
    String uid = await amplifyAuthenticationService.getUserID();
    TemporalDateTime _start = TemporalDateTime(start);
    TemporalDateTime _end = TemporalDateTime(end);
    final snapshot = Amplify.DataStore.observeQuery(
        AppTransaction.classType,
        where: AppTransaction.USERID.eq(uid)
            .and(AppTransaction.DATE.between(_start, _end))
    );

    return snapshot;
  }

  Future<List<AppTransaction>> getAllData() async {
    String uid = await amplifyAuthenticationService.getUserID();
    final snapshot = await Amplify.DataStore.query(
      AppTransaction.classType,
      where: AppTransaction.USERID.eq(uid)
    );
    return snapshot;
  }
}
