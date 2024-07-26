import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_app/core/controllers/files_controller.dart';
import 'package:ml_app/core/widgets/app_button.dart';
import 'package:ml_app/core/widgets/app_list_view.dart';
import 'package:ml_app/features/input_data/domain/rc.dart';
import 'package:ml_app/injection_container.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool _isLoadingRCs = true;
  List<dynamic> _allRCs = [];

  Future<void> _initializeRCs() async {
    sl<FilesController>().getRCsList(ForScreen.history).then((value) {
      setState(() {
        _allRCs = value;
        _isLoadingRCs = false;
      });
    });
  }

  @override
  void initState() {
    _initializeRCs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoadingRCs
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AppListView(
                title: "批號",
                itemCount: _allRCs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: AppButton(
                      onPressed: () => _onSelectRC(context, _allRCs[index]),
                      textData: _allRCs[index].rcno!,
                    ),
                  );
                },
              ),
            ),
    );
  }

  void _onSelectRC(BuildContext context, RC selectedRC) {
    Navigator.pushNamed(context, '/rcDetails', arguments: selectedRC);
  }
}
