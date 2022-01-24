import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height) - 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/background_head.png"),
                      // alignment: Alignment.topCenter,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                    left: 30,
                    child: Image(
                  image: AssetImage("images/titleWord.png"),
                  width: 300,
                ))
              ],
            ),
            Container(
              height: 1220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/background_body.png"),
                  alignment: Alignment.topCenter,
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
