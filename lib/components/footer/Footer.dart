// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../utils//CustomDialog.dart';

class Footer extends StatefulWidget {
  final Function() sortBtnClickListener;

  const Footer({Key? key, required this.sortBtnClickListener})
      : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  var widgetKey = GlobalKey();
  var oldSize;
  double _footerWidth = 0;
  double _footerHeight = 0;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;
    if(newSize!.height != _footerHeight){
      setState(() {
        print('setState ${newSize!.width}');
        _footerHeight = newSize!.height;
      });
    }

    // build(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    _footerWidth = _footerHeight * 1.6;
    final double fontW = _footerWidth * 0.1;
    final double topPos = (height * 0.12) / 3;
    final double leftPos = (_footerWidth / 2.2);
    print('footer height : ${_footerHeight}');
    print('footer width : ${_footerWidth}');

    SchedulerBinding.instance?.addPostFrameCallback(postFrameCallback);

    return Container(
      key: widgetKey,
      color: Colors.black87.withAlpha(180),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              child: const Text("1"),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Stack(children: <Widget>[
                Image.asset(
                  'images/male_active_glow_themered.png',
                  height: _footerHeight,
                  width: _footerWidth,
                ),
                Positioned(
                  child: Text(
                    "Phanindra",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontW,
                    ),
                  ),
                  top: topPos,
                  left: leftPos,
                ),
                Positioned(
                  child: Text(
                    "124.45",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontW,
                    ),
                  ),
                  top: topPos + (topPos * 0.7),
                  left: leftPos,
                ),
              ]),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Row(
                children: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    padding: EdgeInsets.zero,
                    height: 30,
                    minWidth: 70,
                    color: Colors.blue,
                    child: const Text('Sort',
                        style: TextStyle(fontSize: 16.0, color: Colors.white)),
                    onPressed: widget.sortBtnClickListener,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    height: 30,
                    minWidth: 70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    padding: EdgeInsets.zero,
                    color: Colors.blue,
                    child: const Text('Submit',
                        style: TextStyle(fontSize: 16.0, color: Colors.white)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => const CustomDialog(
                                title: "Success",
                              ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
