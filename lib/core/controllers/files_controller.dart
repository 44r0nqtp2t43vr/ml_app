import 'dart:io';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:ml_app/core/resources/formatters.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum ForScreen { input2, input3, history }

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
      List<Directory>? extDirectories = await getExternalStorageDirectories();
      return extDirectories?[1].path;
    }
    return null;
  }

  Future<void> writeCsvToDirectory(RC data, {bool isEdit = false}) async {
    final today = DateTime.now();
    data.date = dateTimeToString(today);

    final directoryPath = await getExternalSdCardPath();
    if (directoryPath == null) {
      return;
    }

    final file = File('$directoryPath/${dateTimeToFilename(today)}.csv');
    try {
      if (await file.exists()) {
        if (isEdit) {
        } else {
          List<List<dynamic>> csvRow = [data.toList()];
          String csvData = const ListToCsvConverter().convert(csvRow, convertNullTo: '');
          await file.writeAsString('\r\n$csvData', mode: FileMode.append);
        }
      } else {
        List<List<dynamic>> csvTable = [header, data.toList()];
        String csvData = const ListToCsvConverter().convert(csvTable, convertNullTo: '');
        await file.writeAsString(csvData);
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

  Future<List<RC>> getRCsList(ForScreen forScreen) async {
    final lists = await readCsvFromDirectory();
    if (forScreen == ForScreen.history) {
      return lists.map((list) => listToRC(list)).toList();
    } else if (forScreen == ForScreen.input2) {
      final incompsForI2 = lists.where((list) => isListIncompForI2(list)).toList();
      return incompsForI2.map((list) => listToRC(list)).toList();
    } else if (forScreen == ForScreen.input3) {
      final incompsForI3 = lists.where((list) => isListIncompForI3(list)).toList();
      return incompsForI3.map((list) => listToRC(list)).toList();
    }
    return [];
  }
}
