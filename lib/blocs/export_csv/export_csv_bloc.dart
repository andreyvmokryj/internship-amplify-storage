import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:share/share.dart';
import 'dart:core';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';
import 'package:radency_internship_project_2/local_models/transactions/transactions_helper.dart';
import 'package:isolate_handler/isolate_handler.dart';

part 'export_csv_event.dart';
part 'export_csv_state.dart';

final logger = Logger();
final isolates = IsolateHandler();

class CsvExportBloc extends Bloc<CsvExportEvent, CsvExportState> {
  CsvExportBloc({required this.transactionsRepository}) : super(CsvExportStateInitial());

  final TransactionsRepository transactionsRepository;
  @override
  Stream<CsvExportState> mapEventToState(CsvExportEvent event) async* {
      if(event is ExportDataToCsv) {
        final result = await saveCSV();
        if (result is File) {
          yield CsvExportLoadedState(file: result);
        }
      }
  }

  saveCSV() async {
    final result = await spawnIsolate();
    if (result is Map){
      String filePath = result["filePath"] as String;
      shareData(filePath);
      return File(filePath);
    }

    return result;
  }

  Future<dynamic> spawnIsolate() async {
    try {
      List<AppTransaction?> data = await transactionsRepository.getAllData();
      List<List<String>> list = [];
      data.forEach((transaction) {
        if (transaction != null) {
          List<String> convertedTransaction = TransactionsHelper().toStringInList(
              transaction);
          list.add(convertedTransaction);
        }
      });
      String filePath = await getCsvFilePath();
      String csv = createCsvString(list);

      var _completer = new Completer();

      final pdfIsolateId = 'pdf' + Random().nextInt(1000).toString();
      final fileUploadIsolate = isolates.spawn(entryPoint,
          name: pdfIsolateId, onReceive: (message) {
            print('pdfIsolate message: $message');
            if (message is Map ||
                message is String && message.startsWith('error ')) {
               _completer.complete(message);
            }
          }, onInitialized: () {
            isolates.send({
              'csv': csv,
              'filePath': filePath,
            }, to: pdfIsolateId);
          });
      final result = await _completer.future;
      fileUploadIsolate.dispose();
      return result;
    } catch (e, stacktrace) {
      logger.e(e);
      return null;
    }
  }
}

void entryPoint(Map<String, dynamic> context) {
  // Calling initialize from the entry point with the context is
  // required if communication is desired. It returns a messenger which
  // allows listening and sending information to the main isolate.
  final messenger = HandledIsolate.initialize(context);

  // Triggered every time data is received from the main isolate.
  messenger.listen((message) async {
    try {
      if (message is Map) {
        String csv = message["csv"] as String;
        String filePath = message["filePath"] as String;

        File file = File(filePath);
        file.writeAsString(csv);

        messenger.send({
          "filePath": filePath,
        });
      }
    } catch (e, stacktrace) {
      logger.e(e);
      messenger.send('error ' + e.toString());
    }
  });
}

createCsvString(List<List<String>> transactionsData) {
  List tableHeader = [
    'transactionType', 'amount', 'date', 'creationDate', 'accountOrigin',
    'category', 'note', 'currency', 'subcurrency', 'accountDestination', 'fees',
    'locationLatitude', 'locationLongitude', 'sharedContact', 'creationType'
  ];
  List<List> dataWithHeader = [
    [tableHeader.join(';')]
  ];

  dataWithHeader += transactionsData;

  String csv = ListToCsvConverter().convert(dataWithHeader);
  return csv;
}

Future<String> getCsvFilePath() async{
  Directory? dir;
  if (Platform.isAndroid) {
    dir = await getExternalStorageDirectory();
  }
  if (Platform.isIOS) {
    dir = await getApplicationDocumentsDirectory();
  }
  String path = dir!.path;
  var timestamp = DateTime.now();
  var milliseconds = timestamp.millisecondsSinceEpoch;
  return '$path/expensesData$milliseconds.csv';
}

shareData(path) {
  Share.shareFiles([path]);
}