import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/CreateAccount.dart';
import 'package:ones_blog/SignOutMenu.dart';
import 'package:ones_blog/bloc/post_bloc.dart';
import 'package:ones_blog/model/api_response.dart';
import 'package:ones_blog/model/user_model.dart';
import 'package:ones_blog/repository/location_repo.dart';
import 'package:ones_blog/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CreateMenu.dart';
import 'HomePage.dart';
import 'bloc/lodging_bloc.dart';
import 'bloc/restaurant_bloc.dart';
import 'bloc/spot_bloc.dart';
import 'function/BuildButton.dart';

class LoginAccount extends StatefulWidget {
  const LoginAccount({Key? key}) : super(key: key);

  @override
  _LoginAccountState createState() => _LoginAccountState();
}

class _LoginAccountState extends State<LoginAccount> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadDeviceInfo();
  }

  void _loginUser() async {
    ApiResponse response = await login(emailController.text, passwordController.text);
    if(response.error == null){
      _saveAndRedirectToHome(response.data as UserModel);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.error.toString())));
    }
  }

  void _saveAndRedirectToHome(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setString('email', user.email ?? '');
    print(pref.getString('token'));
    print(pref.getString('email'));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
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
                ], child: HomePage(token: pref.getString('token').toString(),))), (route) => false);
  }

  String? get _errorText{
    final text = passwordController.text;
    if(text.isEmpty){
      return '';
    }if(text.length<6){
      return 'Required at least 6 chars';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CreateMenu(context,''),
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
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MultiBlocProvider(
                    providers: [
                      BlocProvider<RestaurantBloc>(
                        create: (BuildContext context) => RestaurantBloc(LocationRepository()),
                      ),
                      BlocProvider<SpotBloc>(
                        create: (BuildContext context) => SpotBloc(LocationRepository()),
                      ),
                      BlocProvider<LodgingBloc>(
                        create: (BuildContext context) => LodgingBloc(LocationRepository()),
                      ),
                    ],
                    child: HomePage(token: '',),
                  ),), (route) => false);                    // Navigator.pushReplacement(
                  },
                  icon: Image.asset('images/icon/icon.png'),
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
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Text(
                        '歡迎回來',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 138,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                              ),
                              color: Colors.white,
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "登入",
                                style:
                                TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            width: 138,
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateAccount(),
                                    maintainState: false,
                                  ),
                                );
                              },
                              child: Text(
                                "註冊",
                                style:
                                TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        height: 2.0,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "*",
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                          Text(
                            "電子信箱",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 180,
                          ),
                          Text(
                            "*必填",
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        width: 300,
                        height: 85,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (val) => val!.isEmpty ? 'Can\'t be empty' : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '請輸入您的電子信箱',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "*",
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                          Text(
                            "密碼",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        width: 300,
                        height: 85,
                        child: TextFormField(
                          controller: passwordController,
                          validator: (val) => val!.isEmpty ? 'Can\'t be empty' : null,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            errorText: _errorText,
                            hintText: '請輸入您的密碼',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width - 90,),
                          GestureDetector(
                            child: Text('忘記密碼？',style: TextStyle(color: Colors.black),),
                            onTap: (){
                              print('pressed');
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildButtionPushAndRem('取消', 80, 52, context, HomePage(token: '',)),
                          kbuildButtionPushAndRem('登入', 80, 52, context, (){
                            if(formKey.currentState!.validate()){
                              _loginUser();
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
      )
    );
  }
}