class ModelInput {
  String? machine;
  double? machineYP02;
  double? machineYP03;
  String? hardness1;
  String? hardness2;
  double? hardness1RB;
  double? hardness2RB;
  double? targetDimensions;
  double? maxDimensionalAllowance;
  double? minDimensionalAllowance;
  double? measuredDimensions;
  double? ambientHumidity;
  double? ambientTemperature;

  ModelInput({
    this.machine,
    this.machineYP02,
    this.machineYP03,
    this.hardness1,
    this.hardness2,
    this.hardness1RB,
    this.hardness2RB,
    this.targetDimensions,
    this.maxDimensionalAllowance,
    this.minDimensionalAllowance,
    this.measuredDimensions,
    this.ambientHumidity,
    this.ambientTemperature,
  });

  List<dynamic> toList() {
    return [
      machineYP02,
      machineYP03,
      hardness1RB,
      hardness2RB,
      ambientHumidity,
      ambientTemperature,
      targetDimensions,
      maxDimensionalAllowance,
      minDimensionalAllowance,
      measuredDimensions,
    ];
  }
}
