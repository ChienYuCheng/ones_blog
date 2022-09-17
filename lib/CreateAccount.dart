import 'dart:convert';
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/HomePage.dart';
import 'package:ones_blog/LoginAccount.dart';
import 'package:ones_blog/SignOutMenu.dart';
import 'package:ones_blog/model/user_model.dart';
import 'package:ones_blog/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CreateMenu.dart';
import 'function/BuildButton.dart';
import 'model/api_response.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();


  void _registerUser() async {
    ApiResponse response = await register(nameController.text, emailController.text, passwordController.text);

    if(response.error == null){
      _saveAndRedirectToHome(response.data as UserModel);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.error.toString())));
    }
  }
  void  _saveAndRedirectToHome(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token??'');
    await pref.setString('email', user.email??'');
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
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
  String? get _repassErrorText{
    loadDeviceInfo();
    final text1 = passwordController.text;
    final text2 = rePasswordController.text;
    if(text1 == text2){
      return '';
    }
    if(text1 != text2){
      return 'Confirm password does not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: CreateMenu(context),
      endDrawer: CreateMenu(context),
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
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomePage(),
                  //     maintainState: false,
                  //   ),
                  // );
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
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
                  height: MediaQuery.of(context).size.height + 100,
                  child: Column(
                    children: [
                      Text(
                        '創建帳號',
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
                            child: TextButton(
                              onPressed: () {
                                loadDeviceInfo();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginAccount(),
                                    maintainState: false,
                                  ),
                                );
                              },
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
                            "用戶名稱",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        width: 300,
                        height: 85,
                        child: TextFormField(
                          controller: nameController,
                          validator: (val) => val!.isEmpty ? 'Can\'t be empty' : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '請輸入您的用戶名稱',
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
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        width: 300,
                        height: 85,
                        child: TextFormField(
                          controller: passwordController,
                          validator: (val) => val!.isEmpty ? 'Can\'t be empty' : null,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '請輸入您的密碼',
                            errorText: _errorText,
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
                            "確認密碼",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        width: 300,
                        height: 85,
                        child: TextFormField(
                          controller: rePasswordController,
                          validator: (val) => val!.isEmpty ? 'Can\'t be empty' : null,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '請再次輸入您的密碼',
                            errorText: _repassErrorText,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildButtionPop('取消', 80, 52, context, HomePage()),
                          kbuildButtionPushAndRem('註冊', 80, 52, context, (){
                            if(formKey.currentState!.validate()){
                              _registerUser();
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
}
