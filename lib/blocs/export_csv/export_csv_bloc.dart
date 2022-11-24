import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:share/share.dart';
import 'dart:core';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';
import 'package:radency_internship_project_2/local_models/transactions/transactions_helper.dart';

part 'export_csv_event.dart';
part 'export_csv_state.dart';

class CsvExportBloc extends Bloc<CsvExportEvent, CsvExportState> {
  CsvExportBloc({required this.transactionsRepository}) : super(CsvExportStateInitial());

  final TransactionsRepository transactionsRepository;
  @override
  Stream<CsvExportState> mapEventToState(
      CsvExportEvent event,
      ) async* {
      if(event is ExportDataToCsv) {
        File csvFile = await saveCSV();
        yield CsvExportLoadedState(file: csvFile);
      }
  }

  saveCSV() async {
    List<AppTransaction> data = await transactionsRepository.getAllData();
    List<List<String>> list = [];
    data.forEach((transaction) {
      List<String> convertedTransaction = TransactionsHelper().toStringInList(transaction);
      list.add(convertedTransaction);
    });
    String filePath = await getCsvFilePath();
    String csv = createCsvString(list);
    
    File file = File(filePath);
    file.writeAsString(csv);

    shareData(filePath);
    return file;
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
}
