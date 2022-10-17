import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/Constant.dart';
import 'package:ones_blog/StoreInformation.dart';
import 'package:ones_blog/bloc/cities_bloc.dart';
import 'package:ones_blog/model/cities_model.dart';
import 'package:ones_blog/model/user_model.dart';
import 'package:ones_blog/repository/cities_repo.dart';
import 'package:ones_blog/repository/location_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Community.dart';
import 'CreateMenu.dart';
import 'HomePage.dart';
import 'bloc/lodging_bloc.dart';
import 'bloc/restaurant_bloc.dart';
import 'bloc/spot_bloc.dart';
import 'function/BuildButton.dart';
import 'model/api_response.dart';
import 'model/location_model.dart';

import 'package:http/http.dart' as http;
List<bool> isPressed = [false, false, false, false, false, false, false];
const List<String> category = <String>['餐廳', '景點', '旅宿'];

class BecomeStore extends StatefulWidget {
  String token;
  BecomeStore({required this.token});
  @override
  _BecomeStoreState createState() => _BecomeStoreState();
}

class _BecomeStoreState extends State<BecomeStore> {
  bool twentyFourSeven = false, nonBusinessDays = false;
  TimeOfDay? startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay? endTime = const TimeOfDay(hour: 0, minute: 0);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController introductionController = TextEditingController();
  String? cityDropdownValue;
  String? cityAreaDropdownValue;
  String dropdownValue = category.first;
  int cityId = 1;
  int cityAreaId = 1;
  int categoryId = 1;

  // late String cityArea;

  // @override
  // void initState() {
  //   super.initState();
  //   CitiesRepository().fetchCities();
  // }

  void _becomeStore() async {
    ApiResponse response = await LocationRepository().becomeStore(cityAreaId,categoryId,nameController.text, addressController.text, phoneController.text, introductionController.text,widget.token);

    if(response.error == null){
      _saveAndRedirectToHome(response.data as UserModel);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.error.toString())));
    }
  }

  void _saveAndRedirectToHome(UserModel user) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.setString('token', user.token??'');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<RestaurantBloc>(
                      create: (BuildContext context) =>
                          RestaurantBloc(LocationRepository()),
                    ),
                    BlocProvider<SpotBloc>(
                      create: (BuildContext context) =>
                          SpotBloc(LocationRepository()),
                    ),
                    BlocProvider<LodgingBloc>(
                      create: (BuildContext context) =>
                          LodgingBloc(LocationRepository()),
                    ),
                  ],
                  child: HomePage(token: widget.token,))),
    );
  }

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
      endDrawer: CreateMenu(context, widget.token),
      body: Form(
        key: formKey,
        child: NestedScrollView(
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
                        height: 1000,
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
                              child: TextFormField(
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                validator: (val) => val!.isEmpty ? 'Can\'t be empty' : null,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: '店家名稱',
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
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Text('城市'),
                                    FutureBuilder<List<String>>(
                                        future: CitiesRepository().fetchCities(),
                                        builder:(context,snapshot){
                                          if(snapshot.hasData){
                                            var data = snapshot.data!;
                                            return DropdownButton(
                                              value: cityDropdownValue ?? data[0],
                                              icon: Icon(Icons.keyboard_arrow_down),
                                              items: data.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  cityDropdownValue = newValue!;
                                                  cityId = data.indexOf(newValue)+1;
                                                  // CitiesRepository().fetchCityAreas(cityAreaId.toString());
                                                  print('CITY => $cityDropdownValue');
                                                  print('CityId => $cityId');
                                                });
                                              },
                                            );
                                          }else{
                                            return const CircularProgressIndicator();
                                          }
                                        }
                                    ),
                                    FutureBuilder<List<String>>(
                                        future: CitiesRepository().fetchCityAreas(cityId.toString()),
                                        builder:(context,snapshot){
                                          if(snapshot.hasData){
                                            var data = snapshot.data!;
                                            return DropdownButton(
                                              value: cityAreaDropdownValue ?? data[0],
                                              icon: Icon(Icons.keyboard_arrow_down),
                                              items: data.map((String items) {
                                                // index = data.indexOf(items);
                                                // print('ITEMS : ${data.indexOf(items)}');
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  cityAreaDropdownValue = newValue!;
                                                  cityAreaId = cityAreaId;
                                                  print('AREA => $cityAreaDropdownValue');
                                                  print('AreaId => $cityAreaId');
                                                });
                                              },
                                            );
                                          }else{
                                            return const CircularProgressIndicator();
                                          }
                                        }
                                    ),
                                    SizedBox(),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Text('分類'),
                                    DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      // elevation: 16,
                                      style: TextStyle(color: Colors.black,fontSize: 16),
                                      underline: Container(
                                        height: 2,
                                        color: Color.fromRGBO(222, 215, 209, 1),
                                      ),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          dropdownValue = value!;
                                          categoryId = category.indexOf(value)+1;
                                          print('CATEGORY => $dropdownValue');
                                          print('CategoryId => $categoryId');
                                        });
                                      },
                                      items: category.map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                    SizedBox(),
                                  ],
                                ),
                              ],
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              width: 300,
                              height: 40,
                              child: TextFormField(
                                controller: addressController,
                                validator: (val) => val!.isEmpty ? 'Can\'t be empty' : null,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: '地址',
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
                              child: TextFormField(
                                controller: phoneController,
                                validator: (val) => val!.isEmpty ? 'Can\'t be empty' : null,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: '電話/手機',
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
                              '選取營業時間',
                              style: contextStyle,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildDateButton(0, '一'),
                                buildDateButton(1, '二'),
                                buildDateButton(2, '三'),
                                buildDateButton(3, '四'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildDateButton(4, '五'),
                                buildDateButton(5, '六'),
                                buildDateButton(6, '日'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '開始時間',
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
                                      '結束時間',
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
                                  child: Text('新增時間', style: contextStyle),
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
                              child: TextFormField(
                                controller: introductionController,
                                validator: (val) => val!.isEmpty ? 'Can\'t be empty' : null,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: '簡介',
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
                          buildButtionPop('取消', 80, 52, context, HomePage(token: widget.token,)),
                          kbuildButtion('發佈', 80, 52, context, (){
                            if(formKey.currentState!.validate()){
                              _becomeStore();
                            }
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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