import 'package:flutter/material.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/core/widgets/app_list_view.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';

class History extends StatelessWidget {
  const History({super.key});

  void _onSelectRC(BuildContext context, RC selectedRC) {
    Navigator.pushNamed(context, '/rcDetails', arguments: selectedRC);
  }

  @override
  Widget build(BuildContext context) {
    final allRCs = [
      RC(
        rcno: "XXXXXXXXXX",
        date: "2024-07-26",
        material: "sample material",
        supplier: "sample supplier",
        hardness: "sample hardness",
        targetDimensions: 12.75,
        tolerancePrecision: 12.75,
        measuredDimensions: 12.75,
        dimensionalAllowance: 12.75,
        ambientHumidity: 12.75,
        ambientTemperature: 12.75,
        feedRate: 12.75,
        spindleSpeed: 12.75,
        cuttingVolume: 12.75,
        spindleCurrent: 12.75,
        load: 12.75,
        dimensionalAccuracy: null,
        surfaceRoughness: null,
        runout: null,
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: AppListView(
          title: "批號",
          itemCount: allRCs.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: AppButton(
                onPressed: () => _onSelectRC(context, allRCs[index]),
                textData: allRCs[index].rcno!,
              ),
            );
          },
        ),
      ),
    );
  }
}
