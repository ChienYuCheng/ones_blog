import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CreateMenu.dart';

class ArticleComments extends StatefulWidget {
  const ArticleComments({Key? key}) : super(key: key);

  @override
  _ArticleCommentsState createState() => _ArticleCommentsState();
}

class _ArticleCommentsState extends State<ArticleComments> {
  bool bookMarkIsPressed = false;
  final myController = TextEditingController();


  @override
  Widget build(BuildContext context) {
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
                Navigator.pop(
                  context,
                );
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 40,
              ),
            ),
            toolbarHeight: 70,
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
        body: Container(
          color: Color.fromRGBO(222, 215, 209, 1),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),

              Spacer(),
              ListTile(
                title: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    hintText: '留言...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send_rounded),
                      onPressed: () {
                        setState(() {

                        });
                      },
                    ),
                  ),
                ),
              ),
              Text(myController.text.toString(),),
            ],
          ),
        ),
      ),
    );
  }
}
