import 'dart:math';

import 'package:flutter/material.dart';
import 'package:virtual_isl_dictionary/widgets/CustomDrawer.dart';
import 'package:virtual_isl_dictionary/models/User.dart';

class LearningCategory extends StatefulWidget {
  GestureTapCallback onPressed;
  IconData icon;
  String title;
  bool isComplete;
  LearningCategory({this.onPressed, this.icon, this.title, this.isComplete});
  @override
  State<StatefulWidget> createState() => new _LearningCategoryState(
      this.onPressed, this.icon, this.title, this.isComplete);
}

class _LearningCategoryState extends State<LearningCategory> {
  GestureTapCallback onPressed;
  IconData icon;
  String title;
  bool isComplete = false;
  Random random = new Random();
  _LearningCategoryState(
      this.onPressed, this.icon, this.title, this.isComplete);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * .25,
            height: MediaQuery.of(context).size.width * .25,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: isComplete ? Color(0xff64dd17) : Colors.grey[300]),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                    ),
                    isComplete
                        ? Icon(
                            Icons.check_circle,
                            color: Color(0xff64dd17),
                          )
                        : Container()
                  ],
                ),
                isComplete
                    ? Container()
                    : Text(
                        random.nextInt(100).toString() + "%",
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
