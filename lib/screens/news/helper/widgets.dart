import 'package:flutter/material.dart';
import 'package:lakhimpur_kheri/screens/news/views/article_view.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;
  NewsTile({this.imgUrl, this.desc, this.title, this.content, @required this.posturl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              postUrl: posturl
            )
        ));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        imgUrl,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(height: 10,),
                  Text(
                    title,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    desc,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  )
                ],
              ),
            ),
          )),
    );
  }
}


Widget Tabs(String tabn){
  return Tab(
    child: Text(tabn,
        style:
        new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
  );
}

Widget title(String title1, String title2){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        title1+" ",
        style:
        TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 18),
      ),
      Text(
        title2,
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600,fontSize: 18),
      )
    ],
  );
}

final List colorList2 = [
  Colors.pink,
  Colors.pinkAccent,
  Colors.orange,
  Colors.green,
  Colors.redAccent
];