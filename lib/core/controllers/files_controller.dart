import 'dart:io';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:ml_app/core/resources/formatters.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FilesController extends GetxController {
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  Future<String?> getExternalSdCardPath() async {
    if (await _requestPermission(Permission.storage)) {
      List<Directory>? extDirectories = await getExternalStorageDirectories(type: StorageDirectory.documents);
      if (extDirectories == null) {
        return null;
      } else if (extDirectories.length == 1) {
        return extDirectories[0].path;
      }
      return extDirectories[1].path;
    }
    return null;
  }

  Future<void> writeCsvToDirectory(RC data, {String? oldRcno}) async {
    final today = DateTime.now();
    final oldDate = data.date;
    data.date = dateTimeToString(today);

    final directoryPath = await getExternalSdCardPath();
    if (directoryPath == null) {
      return;
    }

    final file = File('$directoryPath/${dateTimeToFilename(today)}.csv');
    try {
      if (oldRcno != null) {
        if (stringToFilename(oldDate!) == stringToFilename(data.date!)) {
          // if same month as old row, simply edit the row
          final csvData = await file.readAsString();
          List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);
          final indexToEdit = rows.indexWhere((row) => row[0].toString() == oldRcno, 1);
          rows[indexToEdit] = data.toList();
          String csvDataUpdated = const ListToCsvConverter().convert(rows, convertNullTo: '');
          await file.writeAsString(csvDataUpdated);
        } else {
          // if different month as old row, delete the row from the old csv
          final oldFile = File('$directoryPath/${stringToFilename(oldDate)}.csv');
          final oldCsvData = await oldFile.readAsString();
          List<List<dynamic>> oldRows = const CsvToListConverter().convert(oldCsvData);
          final indexToRemove = oldRows.indexWhere((row) => row[0].toString() == oldRcno, 1);
          oldRows.removeAt(indexToRemove);
          String csvDataUpdated = const ListToCsvConverter().convert(oldRows, convertNullTo: '');
          await oldFile.writeAsString(csvDataUpdated);

          if (await file.exists()) {
            // append new data to csv
            List<List<dynamic>> csvRow = [data.toList()];
            String csvData = const ListToCsvConverter().convert(csvRow, convertNullTo: '');
            await file.writeAsString('\r\n$csvData', mode: FileMode.append);
          } else {
            // create a new csv file and insert the header with the data
            List<List<dynamic>> csvTable = [header, data.toList()];
            String csvData = const ListToCsvConverter().convert(csvTable, convertNullTo: '');
            await file.writeAsString(csvData);
          }
        }
      } else {
        if (await file.exists()) {
          // append new data to csv
          List<List<dynamic>> csvRow = [data.toList()];
          String csvData = const ListToCsvConverter().convert(csvRow, convertNullTo: '');
          await file.writeAsString('\r\n$csvData', mode: FileMode.append);
        } else {
          // create a new csv file and insert the header with the data
          List<List<dynamic>> csvTable = [header, data.toList()];
          String csvData = const ListToCsvConverter().convert(csvTable, convertNullTo: '');
          await file.writeAsString(csvData);
        }
      }
    } catch (e) {
      return;
    }
  }

  Future<List<List<dynamic>>> readCsvFromDirectory() async {
    final directoryPath = await getExternalSdCardPath();
    if (directoryPath == null) {
      return [];
    }

    final directory = Directory(directoryPath);
    if (!await directory.exists()) {
      return [];
    }

    final csvFiles = directory.listSync().where((file) => file.path.endsWith('.csv')).toList();

    List<List<dynamic>> allRows = [];
    for (var fileEntity in csvFiles) {
      if (fileEntity is File) {
        try {
          final csvData = await fileEntity.readAsString();
          List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);
          rows.removeAt(0);
          allRows.addAll(rows);
        } catch (e) {
          continue;
        }
      }
    }

    return allRows;
  }

  Future<List<RC>> getRCsList() async {
    final lists = await readCsvFromDirectory();
    return lists.map((list) => listToRC(list)).toList();
  }

  Future<void> deleteRowFromCsv(RC data) async {
    final directoryPath = await getExternalSdCardPath();
    if (directoryPath == null) {
      return;
    }

    final directory = Directory(directoryPath);
    if (!await directory.exists()) {
      return;
    }

    final file = File('$directoryPath/${stringToFilename(data.date!)}.csv');

    final csvData = await file.readAsString();
    List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

    final indexToDelete = rows.indexWhere((row) => row[0].toString() == data.rcno.toString(), 1);
    rows.removeAt(indexToDelete);

    String csvDataUpdated = const ListToCsvConverter().convert(rows, convertNullTo: '');
    await file.writeAsString(csvDataUpdated);
  }
}
