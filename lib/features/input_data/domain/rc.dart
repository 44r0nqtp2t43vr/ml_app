const header = [
  "RC No.",
  "Date",
  "Machine",
  "Material",
  "Supplier",
  "Hardness_1",
  "Hardness_2",
  "Target dimensions",
  "Max Dimensional Allowance",
  "Min Dimensional Allowance",
  "Measured dimensions",
  "Ambient Humidity",
  "Ambient Temperature",
  "Feed Rate",
  "Spindle Speed rough",
  "Spindle Speed fine",
  "Cutting Volume",
  "Spindle Current",
  "Max Dimensional Accuracy",
  "Min Dimensional Accuracy",
  "Surface Roughness_1",
  "Surface Roughness_2",
  "Surface Roughness_3",
  "Roundness",
  "Straightness",
];

class RC {
  String? rcno;
  String? date;
  String? machine;
  String? material;
  String? supplier;
  String? hardness1;
  String? hardness2;
  double? targetDimensions;
  double? maxDimensionalAllowance;
  double? minDimensionalAllowance;
  double? measuredDimensions;
  double? ambientHumidity;
  double? ambientTemperature;
  double? feedRate;
  double? spindleSpeedRough;
  double? spindleSpeedFine;
  double? cuttingVolume;
  double? spindleCurrent;
  double? maxDimensionalAccuracy;
  double? minDimensionalAccuracy;
  double? surfaceRoughness1;
  double? surfaceRoughness2;
  double? surfaceRoughness3;
  double? roundness;
  double? straightness;

  RC({
    this.rcno,
    this.date,
    this.machine,
    this.material,
    this.supplier,
    this.hardness1,
    this.hardness2,
    this.targetDimensions,
    this.maxDimensionalAllowance,
    this.minDimensionalAllowance,
    this.measuredDimensions,
    this.ambientHumidity,
    this.ambientTemperature,
    this.feedRate,
    this.spindleSpeedRough,
    this.spindleSpeedFine,
    this.cuttingVolume,
    this.spindleCurrent,
    this.maxDimensionalAccuracy,
    this.minDimensionalAccuracy,
    this.surfaceRoughness1,
    this.surfaceRoughness2,
    this.surfaceRoughness3,
    this.roundness,
    this.straightness,
  });

  Map<String, dynamic> toMap() {
    return {
      'rcno': rcno,
      'date': date,
      'machine': machine,
      'material': material,
      'supplier': supplier,
      'hardness1': hardness1,
      'hardness2': hardness2,
      'targetDimensions': targetDimensions,
      'maxDimensionalAllowance': maxDimensionalAllowance,
      'minDimensionalAllowance': minDimensionalAllowance,
      'measuredDimensions': measuredDimensions,
      'ambientHumidity': ambientHumidity,
      'ambientTemperature': ambientTemperature,
      'feedRate': feedRate,
      'spindleSpeedRough': spindleSpeedRough,
      'spindleSpeedFine': spindleSpeedFine,
      'cuttingVolume': cuttingVolume,
      'spindleCurrent': spindleCurrent,
      'maxDimensionalAccuracy': maxDimensionalAccuracy,
      'minDimensionalAccuracy': minDimensionalAccuracy,
      'surfaceRoughness1': surfaceRoughness1,
      'surfaceRoughness2': surfaceRoughness2,
      'surfaceRoughness3': surfaceRoughness3,
      'roundness': roundness,
      'straightness': straightness,
    };
  }

  List<dynamic> toList() {
    return [
      rcno,
      date,
      machine,
      material,
      supplier,
      hardness1,
      hardness2,
      targetDimensions,
      maxDimensionalAllowance,
      minDimensionalAllowance,
      measuredDimensions,
      ambientHumidity,
      ambientTemperature,
      feedRate,
      spindleSpeedRough,
      spindleSpeedFine,
      cuttingVolume,
      spindleCurrent,
      maxDimensionalAccuracy,
      minDimensionalAccuracy,
      surfaceRoughness1,
      surfaceRoughness2,
      surfaceRoughness3,
      roundness,
      straightness,
    ];
  }
}

RC listToRC(List<dynamic> list) {
  return RC(
    rcno: list[0].toString(),
    date: list[1].toString(),
    machine: list[2].toString(),
    material: list[3].toString(),
    supplier: list[4].toString(),
    hardness1: list[5].toString(),
    hardness2: list[6].toString(),
    targetDimensions: double.tryParse(list[7].toString()),
    maxDimensionalAllowance: double.tryParse(list[8].toString()),
    minDimensionalAllowance: double.tryParse(list[9].toString()),
    measuredDimensions: double.tryParse(list[10].toString()),
    ambientHumidity: double.tryParse(list[11].toString()),
    ambientTemperature: double.tryParse(list[12].toString()),
    feedRate: double.tryParse(list[13].toString()),
    spindleSpeedRough: double.tryParse(list[14].toString()),
    spindleSpeedFine: double.tryParse(list[15].toString()),
    cuttingVolume: double.tryParse(list[16].toString()),
    spindleCurrent: double.tryParse(list[17].toString()),
    maxDimensionalAccuracy: double.tryParse(list[18].toString()),
    minDimensionalAccuracy: double.tryParse(list[19].toString()),
    surfaceRoughness1: double.tryParse(list[20].toString()),
    surfaceRoughness2: double.tryParse(list[21].toString()),
    surfaceRoughness3: double.tryParse(list[22].toString()),
    roundness: double.tryParse(list[23].toString()),
    straightness: double.tryParse(list[24].toString()),
  );
}

bool isListIncompForI2(List<dynamic> list) {
  return list[13] == '' || list[14] == '' || list[15] == '' || list[16] == '' || list[17] == '';
}

bool isListIncompForI3(List<dynamic> list) {
  return list[18] == '' || list[19] == '' || list[20] == '' || list[21] == '' || list[22] == '' || list[23] == '' || list[24] == '';
}
