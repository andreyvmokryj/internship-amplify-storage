part of 'export_csv_bloc.dart';

class CsvExportState {
  CsvExportState();
}

class CsvExportStateInitial extends CsvExportState{
  CsvExportStateInitial();
}

class CsvExportLoadedState extends CsvExportState {
  CsvExportLoadedState({required this.file});

  File file;
}