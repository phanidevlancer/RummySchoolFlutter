// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final Function onDealAnotherHandClikc;

  const Header({Key? key,required this.onDealAnotherHandClikc}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset('images/add_table_themered.png',height:100,width:100,),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(60),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: const Text(
                  "Show Validator",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          widget.onDealAnotherHandClikc();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(6),
                            child: Text(
                              "Deal another hand",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'images/lobbylogoutthemered.png',
                        width: 40,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
