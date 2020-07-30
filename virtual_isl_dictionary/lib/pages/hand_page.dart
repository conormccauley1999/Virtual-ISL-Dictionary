import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:virtual_isl_dictionary/models/Challenge.dart';
import 'package:virtual_isl_dictionary/pages/completed_page.dart';
import 'package:virtual_isl_dictionary/services/unity_api.dart';
import 'package:virtual_isl_dictionary/widgets/RotateWidget.dart';
import 'package:virtual_isl_dictionary/models/User.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HandPage extends StatefulWidget {
  User user;
  String searchParameter;
  bool isLearning;
  Challenge challenge;
  HandPage({@required this.searchParameter, @required this.user, this.isLearning, this.challenge});
  @override
  State<StatefulWidget> createState() =>
      new _HandPageState(this.searchParameter, this.user, this.isLearning, this.challenge);
}

class _HandPageState extends State<HandPage> {
  User user;
  UnityWidgetController _unityWidgetController;
  double sliderValue = -360;
  String searchParameter;
  UnityApi _apiController;
  IconData bookmark;
  bool isLearning;
  Challenge challenge;
  double percentComplete;
  TextEditingController textEditingController = new TextEditingController();

  IconData playPauseIcon = Icons.play_arrow;

  _HandPageState(this.searchParameter, this.user, this.isLearning, this.challenge);

  @override
  void initState() {
    if(isLearning == null) {
      isLearning = false;
    }
    else {
      percentComplete = this.challenge.percentageComplete();
    }
    if (user.bookmarks.contains(searchParameter)) {
      bookmark = Icons.bookmark;
    } else {
      bookmark = Icons.bookmark_border;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double rotateWidgetWidth = MediaQuery.of(context).size.width * .66;

    return new Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            !isLearning ? IconButton(
              icon: Icon(bookmark),
              onPressed: setBookmark,
            ) : Container()
          ],
          backgroundColor: isLearning ? Colors.white : Colors.lightBlue[200],
          title: !isLearning ? Text(
            this.searchParameter,
            style: TextStyle(color: Colors.white),
          ) : Center(
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width*.65,
              lineHeight: 14,
              percent: this.percentComplete/100,
              backgroundColor: Colors.grey[200],
              progressColor: Color(0xff64dd17),
              animation: true,
              animationDuration: 200,
            ),
          ),
          centerTitle: true,
          iconTheme: isLearning ? IconThemeData(color: Colors.lightBlue[200]) : IconThemeData(color: Colors.white),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: UnityWidget(
                        onUnityViewCreated: (controller) {
                          setState(() {
                            _apiController = new UnityApi(controller);
                            _apiController.show(searchParameter);
                          });
                        },
                        isARScene: false,
                      ),
                      height: MediaQuery.of(context).size.height * .7,
                    ),
                    Positioned(
                      left:
                          (MediaQuery.of(context).size.width - rotateWidgetWidth) /
                              2,
                      top: MediaQuery.of(context).size.height * .02,
                      child: _apiController != null
                          ? RotateWidgetSlider(
                              type: "rotation",
                              icon: Icons.threesixty,
                              initialSliderValue: -360,
                              min: -360,
                              max: 0,
                              width: rotateWidgetWidth,
                              apiController: _apiController,
                            )
                          : Container(),
                    )
                  ],
                ),
                _apiController != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  _apiController.replay();
                                },
                                child: Icon(
                                  Icons.replay,
                                  size: MediaQuery.of(context).size.width * .08,
                                  color: Colors.lightBlue[200],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                              ),
                              GestureDetector(
                                child: Icon(
                                  playPauseIcon,
                                  color: Colors.lightBlue[200],
                                  size: MediaQuery.of(context).size.width * .15,
                                ),
                                onTap: () {
                                  setState(() {
                                    if (playPauseIcon == Icons.play_arrow) {
                                      playPauseIcon = Icons.pause;
                                      _apiController.play();
                                    } else {
                                      playPauseIcon = Icons.play_arrow;
                                      _apiController.pause();
                                    }
                                  });
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                              ),
                              Icon(
                                Icons.repeat,
                                size: MediaQuery.of(context).size.width * .08,
                                color: Colors.lightBlue[200],
                              ),
                            ],
                          ),
                          isLearning ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  height: MediaQuery.of(context).size.height*.045,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: TextField(
                                      controller: textEditingController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Guess the letter",
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    RaisedButton(
                                      child: Text("Continue"),
                                      textColor: Colors.white,
                                      color: Color(0xff64dd17),
                                      onPressed: () {
                                        guessWord(textEditingController.text);
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                          : RotateWidgetSlider(
                            type: "playback",
                            icon: Icons.fast_forward,
                            title: "Playback Speed",
                            valueUnit: "x",
                            initialSliderValue: 1,
                            width: MediaQuery.of(context).size.width * .9,
                            apiController: _apiController,
                            min: 0.25,
                            max: 2,
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ],
        ));
  }

  setBookmark() {
    if (bookmark == Icons.bookmark_border) {
      user.bookmarks.add(searchParameter);
      setState(() {
        bookmark = Icons.bookmark;
      });
    } else {
      user.bookmarks.remove(searchParameter);
      setState(() {
        bookmark = Icons.bookmark_border;
      });
    }
  }

  playPause() {
    print("what");
  }

  guessWord(String guess) {
    print("guess!");
    if(guess.toLowerCase() == searchParameter.toLowerCase()) {
      print("correct!");
      setState(() {
        this.challenge.completeWord(searchParameter);
        this.percentComplete = this.challenge.percentageComplete();
      });
      if(this.percentComplete == 100) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CompletedPage(
                  challenge: this.user.challenges[0],
                  user: this.user,
                )));
      }
    }
  }

  repeat(BuildContext context) {}

  replay(BuildContext context) {}
}
