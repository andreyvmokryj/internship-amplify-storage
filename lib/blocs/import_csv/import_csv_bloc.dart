import 'dart:async';
import 'package:csv/csv.dart';
import 'package:bloc/bloc.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';
import 'package:radency_internship_project_2/local_models/transactions/transactions_helper.dart';

part 'import_csv_event.dart';
part 'import_csv_state.dart';

/// Discontinued
class ImportCsvBloc extends Bloc<ImportCsvEvent, ImportCsvState> {
  ImportCsvBloc({required this.transactionsRepository}) : super(ImportCsvInitial(expensesData: null));

  final TransactionsRepository transactionsRepository;

  @override
  Stream<ImportCsvState> mapEventToState(
      ImportCsvEvent event,
      ) async* {
    if(event is ImportCsvFile) {
      List<AppTransaction> expensesData = await getDataFromCsv();
      yield ImportCsvLoaded(expensesData: expensesData);
    }
  }

  Future<List<AppTransaction>> getDataFromCsv() async{
    // FilePickerCross file = await importCsv();
    // List<List<dynamic>> expensesData = CsvToListConverter().convert(file.toString());
    //
    // List<AppTransaction> listOfTransactions = createListOfTransactions(expensesData);
    //
    // listOfTransactions.forEach((transaction) async {
    //   await transactionsRepository.add(transaction);
    // });
    //
    // return listOfTransactions;

    return [];
  }

  List<AppTransaction> createListOfTransactions(expensesData) {
    List<AppTransaction> listOfExpenses = [];
    expensesData.removeAt(0); // first item is a header

    expensesData.forEach((element) {
      AppTransaction transaction = TransactionsHelper().fromStringInList(element);
      listOfExpenses.add(transaction);
    });
    
    return listOfExpenses;
  }

  // Future<FilePickerCross> importCsv() async {
  //   FilePickerCross csvFile = await FilePickerCross.importFromStorage(
  //     type: FileTypeCross.custom,
  //     fileExtension: 'csv'
  //   );
  //
  //   return csvFile;
  // }
}