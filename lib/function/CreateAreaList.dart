import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ones_blog/Constant.dart';
import 'package:ones_blog/StoreInformation.dart';
import 'package:ones_blog/bloc/location_bloc.dart';
import 'package:ones_blog/bloc/restaurant_bloc.dart';
import 'package:ones_blog/repository/location_repo.dart';

TextButton CreateAreaList(String title, String address, String avgScore, String route, BuildContext context,Widget storeInformation) {
  return TextButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context){
                return BlocProvider<LocationBloc>(create: (context)=>LocationBloc(LocationRepository()),child: storeInformation,);
                // return storeInformation;
              }
          ));
    },
    child: Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(198, 201, 203, 1),
        borderRadius: new BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      width: 220,
      height: 260,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: AssetImage(route),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    title,
                    style: titleStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      address,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.star,
                    color: Color.fromRGBO(241, 208, 10, 1),
                  ),
                  Text(
                    avgScore,
                    style: contextStyle,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}
