import 'package:flutter/material.dart';
import 'package:ml_app/core/widgets/app_labelled_text.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';

class RCDetails extends StatelessWidget {
  final RC selectedRC;

  const RCDetails({super.key, required this.selectedRC});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Text(
              selectedRC.rcno!,
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
            const Text(
              "生產參數",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppLabelledText(
                      label: "日期",
                      text: selectedRC.date,
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "材料",
                      text: selectedRC.material,
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "供應商",
                      text: selectedRC.supplier,
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "硬度",
                      text: selectedRC.hardness,
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "圖面尺寸",
                      text: selectedRC.targetDimensions.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "圖面公差",
                      text: selectedRC.tolerancePrecision.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "材料尺寸",
                      text: selectedRC.measuredDimensions.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "尺寸預留量",
                      text: selectedRC.dimensionalAllowance.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "環境濕度",
                      text: selectedRC.ambientHumidity.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "環境溫度",
                      text: selectedRC.ambientTemperature.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "進給量",
                      text: selectedRC.feedRate.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "主軸轉速",
                      text: selectedRC.spindleSpeed.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "切削量",
                      text: selectedRC.cuttingVolume.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "主軸電流",
                      text: selectedRC.spindleCurrent.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "負載",
                      text: selectedRC.load.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "尺寸精度",
                      text: selectedRC.dimensionalAccuracy.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "表面粗度",
                      text: selectedRC.surfaceRoughness.toString(),
                    ),
                    const SizedBox(height: 20),
                    AppLabelledText(
                      label: "偏擺",
                      text: selectedRC.runout.toString(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
