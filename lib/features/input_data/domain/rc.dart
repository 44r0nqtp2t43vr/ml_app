const header = [
  "RC No.",
  "Date",
  "Material",
  "Supplier",
  "Hardness",
  "Target dimensions",
  "Tolerance Precision",
  "Measured dimensions",
  "Dimensional Allowance",
  "Ambient Humidity",
  "Ambient Temperature",
  "Feed Rate",
  "Spindle Speed",
  "Cutting Volume",
  "Spindle Current",
  "Load",
  "Dimensional Accuracy",
  "Surface Roughness",
  "Runout",
];

class RC {
  String? rcno;
  String? date;
  String? material;
  String? supplier;
  String? hardness;
  double? targetDimensions;
  double? tolerancePrecision;
  double? measuredDimensions;
  double? dimensionalAllowance;
  double? ambientHumidity;
  double? ambientTemperature;
  double? feedRate;
  double? spindleSpeed;
  double? cuttingVolume;
  double? spindleCurrent;
  double? load;
  double? dimensionalAccuracy;
  double? surfaceRoughness;
  double? runout;

  RC({
    this.rcno,
    this.date,
    this.material,
    this.supplier,
    this.hardness,
    this.targetDimensions,
    this.tolerancePrecision,
    this.measuredDimensions,
    this.dimensionalAllowance,
    this.ambientHumidity,
    this.ambientTemperature,
    this.feedRate,
    this.spindleSpeed,
    this.cuttingVolume,
    this.spindleCurrent,
    this.load,
    this.dimensionalAccuracy,
    this.surfaceRoughness,
    this.runout,
  });

  Map<String, dynamic> toMap() {
    return {
      'rcno': rcno,
      'date': date,
      'material': material,
      'supplier': supplier,
      'hardness': hardness,
      'targetDimensions': targetDimensions,
      'tolerancePrecision': tolerancePrecision,
      'measuredDimensions': measuredDimensions,
      'dimensionalAllowance': dimensionalAllowance,
      'ambientHumidity': ambientHumidity,
      'ambientTemperature': ambientTemperature,
      'feedRate': feedRate,
      'spindleSpeed': spindleSpeed,
      'cuttingVolume': cuttingVolume,
      'spindleCurrent': spindleCurrent,
      'load': load,
      'dimensionalAccuracy': dimensionalAccuracy,
      'surfaceRoughness': surfaceRoughness,
      'runout': runout,
    };
  }

  List<dynamic> toList() {
    return [
      rcno,
      date,
      material,
      supplier,
      hardness,
      targetDimensions,
      tolerancePrecision,
      measuredDimensions,
      dimensionalAllowance,
      ambientHumidity,
      ambientTemperature,
      feedRate,
      spindleSpeed,
      cuttingVolume,
      spindleCurrent,
      load,
      dimensionalAccuracy,
      surfaceRoughness,
      runout,
    ];
  }
}

RC listToRC(List<dynamic> list) {
  return RC(
    rcno: list[0].toString(),
    date: list[1],
    material: list[2].toString(),
    supplier: list[3].toString(),
    hardness: list[4].toString(),
    targetDimensions: double.tryParse(list[5].toString()),
    tolerancePrecision: double.tryParse(list[6].toString()),
    measuredDimensions: double.tryParse(list[7].toString()),
    dimensionalAllowance: double.tryParse(list[8].toString()),
    ambientHumidity: double.tryParse(list[9].toString()),
    ambientTemperature: double.tryParse(list[10].toString()),
    feedRate: double.tryParse(list[11].toString()),
    spindleSpeed: double.tryParse(list[12].toString()),
    cuttingVolume: double.tryParse(list[13].toString()),
    spindleCurrent: double.tryParse(list[14].toString()),
    load: double.tryParse(list[15].toString()),
    dimensionalAccuracy: double.tryParse(list[16].toString()),
    surfaceRoughness: double.tryParse(list[17].toString()),
    runout: double.tryParse(list[18].toString()),
  );
}

bool isListIncompForI2(List<dynamic> list) {
  return list[11] == '' || list[12] == '' || list[13] == '' || list[14] == '' || list[15] == '';
}

bool isListIncompForI3(List<dynamic> list) {
  return list[16] == '' || list[17] == '' || list[18] == '';
}
