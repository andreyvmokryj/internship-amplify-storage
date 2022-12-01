import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';

class AmplifyApiProvider{
  AmplifyStreamGroup getTransactionsStreams() {
    final Stream<GraphQLResponse<AppTransaction>> addOperation = Amplify.API.subscribe(
      ModelSubscriptions.onCreate(AppTransaction.classType),
      onEstablished: () => print('Subscription on added established'),
    );
    final Stream<GraphQLResponse<AppTransaction>> changeOperation = Amplify.API.subscribe(
      ModelSubscriptions.onUpdate(AppTransaction.classType),
      onEstablished: () => print('Subscription on updated established'),
    );
    final Stream<GraphQLResponse<AppTransaction>> deleteOperation = Amplify.API.subscribe(
      ModelSubscriptions.onDelete(AppTransaction.classType),
      onEstablished: () => print('Subscription on deleted established'),
    );

    return AmplifyStreamGroup(onTransactionAdded: addOperation, onTransactionChanged: changeOperation, onTransactionDeleted: deleteOperation);
  }
}

class AmplifyStreamGroup {
  Stream<GraphQLResponse<AppTransaction>> onTransactionAdded;
  Stream<GraphQLResponse<AppTransaction>> onTransactionChanged;
  Stream<GraphQLResponse<AppTransaction>> onTransactionDeleted;

  AmplifyStreamGroup({required this.onTransactionAdded, required this.onTransactionChanged, required this.onTransactionDeleted});
}