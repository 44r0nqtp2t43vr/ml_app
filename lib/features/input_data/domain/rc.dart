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
