import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/Constant.dart';
import 'Community.dart';
import 'CreateMenu.dart';
import 'HomePage.dart';
import 'function/BuildButton.dart';

List<bool> isPressed = [false, false, false, false, false, false, false];

class BecomeStore extends StatefulWidget {
  @override
  _BecomeStoreState createState() => _BecomeStoreState();
}

class _BecomeStoreState extends State<BecomeStore> {
  bool twentyFourSeven = false, nonBusinessDays = false;
  TimeOfDay? startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay? endTime = const TimeOfDay(hour: 0, minute: 0);

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Color.fromRGBO(198, 201, 203, 1);
    }

    return Scaffold(
      endDrawer: CreateMenu(context),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            pinned: true,
            backgroundColor: Color.fromRGBO(222, 215, 209, 1),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(context);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 40,
              ),
            ),
            toolbarHeight: 70,
            leadingWidth: 100,
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: Image.asset('images/element/menu.png'),
                  iconSize: 70,
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          ),
        ],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color.fromRGBO(222, 215, 209, 1),
                height: MediaQuery.of(context).size.height + 400,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 950,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                            width: 300,
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: '????????????',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 2.0,
                            width: 280,
                            color: Color.fromRGBO(222, 215, 209, 1),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                            width: 300,
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: '??????',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 2.0,
                            width: 280,
                            color: Color.fromRGBO(222, 215, 209, 1),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                            width: 300,
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: '??????/??????',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            height: 2.0,
                            width: 280,
                            color: Color.fromRGBO(222, 215, 209, 1),
                          ),
                          Text(
                            '??????????????????',
                            style: contextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildDateButton(0, '???'),
                              buildDateButton(1, '???'),
                              buildDateButton(2, '???'),
                              buildDateButton(3, '???'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildDateButton(4, '???'),
                              buildDateButton(5, '???'),
                              buildDateButton(6, '???'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '????????????',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(241, 208, 10, 1),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(222, 215, 209, 1),
                                          width: 2.0),
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        child: Text(
                                          '${startTime!.hour.toString()}:${startTime!.minute.toString()}',
                                          style: contextStyle,
                                        ),
                                        onPressed: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: startTime!,
                                          );
                                          if (newTime != null) {
                                            setState(() {
                                              startTime = newTime;
                                            },);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '????????????',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(241, 208, 10, 1),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(222, 215, 209, 1),
                                          width: 2.0),
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        child: Text(
                                          '${endTime!.hour.toString()}:${endTime!.minute.toString()}',
                                          style: contextStyle,
                                        ),
                                        onPressed: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: endTime!,
                                          );
                                          if (newTime != null) {
                                            setState(() {
                                              endTime = newTime;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Spacer(),
                              TextButton(
                                child: Text('????????????', style: contextStyle),
                                onPressed: () {},
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          Container(
                            height: 2.0,
                            width: 280,
                            color: Color.fromRGBO(222, 215, 209, 1),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            width: 300,
                            height: 280,
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: '??????',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 280,
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(185, 153, 98, 1.0),
                                    width: 2.0)),
                            child: TextButton(
                              onPressed: () {},
                              child: Icon(
                                FontAwesomeIcons.photoVideo,
                                color: Color.fromRGBO(198, 201, 203, 1.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButtion('??????', 80, 52, context, HomePage()),
                        buildButtion('??????', 80, 52, context, Community()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDateButton(int buttonIndex, String date) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Color.fromRGBO(222, 215, 209, 1),
          width: 3.0,
        ),
        color: isPressed[buttonIndex]
            ? Color.fromRGBO(222, 215, 209, 1)
            : Colors.white,
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            isPressed[buttonIndex] = !isPressed[buttonIndex];
          });
          print('press');
        },
        child: Text(
          date,
          style: contextStyle
        ),
      ),
    );
  }
}
