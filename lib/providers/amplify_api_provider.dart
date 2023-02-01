import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:rxdart/rxdart.dart';

class AmplifyApiProvider{
  Stream<AmplifyApiEvent> getTransactionsStream() {
    final Stream<AmplifyApiEvent> addOperation = Amplify.API.subscribe(
      ModelSubscriptions.onCreate(AppTransaction.classType),
      onEstablished: () => print('Subscription on added established'),
    ).map((event) => AmplifyApiEvent(event, AmplifyResponseType.add));
    final Stream<AmplifyApiEvent> changeOperation = Amplify.API.subscribe(
      ModelSubscriptions.onUpdate(AppTransaction.classType),
      onEstablished: () => print('Subscription on updated established'),
    ).map((event) => AmplifyApiEvent(event, AmplifyResponseType.change));
    final Stream<AmplifyApiEvent> deleteOperation = Amplify.API.subscribe(
      ModelSubscriptions.onDelete(AppTransaction.classType),
      onEstablished: () => print('Subscription on deleted established'),
    ).map((event) => AmplifyApiEvent(event, AmplifyResponseType.delete));

    final mergedStream = MergeStream([
      addOperation,
      changeOperation,
      deleteOperation,
    ]);
    return mergedStream;
  }
}

class AmplifyApiEvent {
  final GraphQLResponse<AppTransaction> response;
  final AmplifyResponseType type;

  AmplifyApiEvent(this.response, this.type);
}

enum AmplifyResponseType{add, change, delete}
