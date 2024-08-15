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
  int _toDeleteIndex = -1;
  bool _isLoadingRCs = true;
  List<dynamic> _allRCs = [];

  void _setDeleteIndex(int index) {
    setState(() {
      _toDeleteIndex = index;
    });
  }

  Future<void> _initializeRCs() async {
    sl<FilesController>().getRCsList().then((value) {
      setState(() {
        _allRCs = value;
        _toDeleteIndex = -1;
        _isLoadingRCs = false;
      });
    });
  }

  void _deleteRC(BuildContext context) async {
    setState(() {
      _isLoadingRCs = true;
    });
    sl<FilesController>().deleteRowFromCsv(_allRCs[_toDeleteIndex]).then((value) => _initializeRCs());
  }

  @override
  void initState() {
    _initializeRCs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _setDeleteIndex(-1),
      child: Scaffold(
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
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: AppButton(
                            onPressed: () => _onSelectRC(context, _allRCs[index]),
                            onLongPressed: () => _setDeleteIndex(index),
                            textData: _allRCs[index].rcno!,
                          ),
                        ),
                        if (_toDeleteIndex == index)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: FloatingActionButton.extended(
                              backgroundColor: Colors.red,
                              onPressed: () => _deleteRC(context),
                              label: const Text(
                                "刪除",
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }

  void _onSelectRC(BuildContext context, RC selectedRC) {
    Navigator.pushNamed(context, '/rcDetails', arguments: selectedRC);
  }
}
