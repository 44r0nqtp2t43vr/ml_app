import 'dart:io';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
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

  Future<void> writeCsvToDirectory() async {
    final directoryPath = await getExternalSdCardPath();

    if (directoryPath == null) {
      return;
    }

    List<List<dynamic>> rows = [
      ["Name", "Age", "City"],
      ["John Doe", "30", "New York"],
      ["Jane Smith", "25", "Los Angeles"],
      ["Sam Johnson", "40", "Chicago"]
    ];

    String csvData = const ListToCsvConverter().convert(rows);

    final file = File('$directoryPath/202407.csv');

    await file.writeAsString(csvData);

    print('CSV file written successfully to ${file.path}');
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
