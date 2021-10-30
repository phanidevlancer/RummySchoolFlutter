// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../utils//CustomDialog.dart';

class Footer extends StatelessWidget {
  final Function() sortBtnClickListener;

  const Footer({Key? key, required this.sortBtnClickListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double fontW = width * 0.02;

    final double topPos = (height * 0.12)/3 ;
    final double leftPos = (width * 0.08);
    print('fontSize : ${topPos}');

    return Container(
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
                Image.asset('images/male_active_glow_themered.png'),
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
                    onPressed: sortBtnClickListener,
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
