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
          await file.writeAsString('\n$csvData', mode: FileMode.append);
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

  Future<void> readCsvFromDirectory() async {
    final directoryPath = await getExternalSdCardPath();

    if (directoryPath == null) {
      return;
    }

    final file = File('$directoryPath/202407.csv');

    if (!await file.exists()) {
      return;
    }

    final csvData = await file.readAsString();

    List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

    for (List<dynamic> row in rows) {
      print(row);
    }
  }
}
