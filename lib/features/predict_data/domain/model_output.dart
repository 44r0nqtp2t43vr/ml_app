class ModelOutput {
  double? feedRate;
  double? spindleSpeedRough;
  double? spindleSpeedFine;
  double? spindleCurrent;

  ModelOutput({
    this.feedRate,
    this.spindleSpeedRough,
    this.spindleSpeedFine,
    this.spindleCurrent,
  });

  ModelOutput.fromList(List<dynamic> data, bool isRough)
      : feedRate = data[0],
        spindleSpeedRough = isRough ? data[1] : null,
        spindleSpeedFine = isRough ? null : data[1],
        spindleCurrent = data[2];
}
