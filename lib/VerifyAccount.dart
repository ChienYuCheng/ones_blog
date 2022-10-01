import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'function/BuildButton.dart';

Widget verifyAccount(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: [
          IconButton(
              onPressed: () {

              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 40,
              )),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    color: Color.fromRGBO(222, 215, 209, 1),
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 10.0,
                            ),
                            SizedBox(
                              height: 50,
                              width: 300,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.length == 6) {
                                    // FocusScope.of(context).unfocus();
                                  }else{
                                    // FocusScope.of(context).hasFocus;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "請輸入驗證碼",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                textCapitalization: TextCapitalization.characters,
                                inputFormatters: [
                                  // LengthLimitingTextInputFormatter(6),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 60.0,),
                        // kbuildButtionPushAndRem('驗證', 80, 52, context, (){
                        //   verifyOtp();
                        // }),
                        TextButton(
                            onPressed: () {
                              print("pressed");
                              // verifyOtp();
                            },
                            child: Text(
                              "重寄驗證信",
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            )),
                      ],
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}