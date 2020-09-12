
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Images extends StatefulWidget {
  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> {

  Future _data;

  Future getCandidats() async {
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("images").getDocuments();

    return snap.documents;
  }
  @override
  void initState() {
    super.initState();

    _data =  getCandidats();
  }
  double _scale = 1.0;
  double _previousScale = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 255),
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 23.0,
              color: Color.fromRGBO(71, 147, 12, 1),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            'Images',
            style: TextStyle(
                color: Color.fromRGBO(71, 147, 12, 1),
                fontSize: 20.0,
                fontFamily: 'Open Sans'
            ),
          ),
        ),
        body:
        FutureBuilder(
            future: _data,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color.fromRGBO(71, 147, 12, 1),
                  ),
                );
              } else {

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                  child: new ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemExtent: 145,
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return Container(
                            height: MediaQuery.of(context).size.height/5,
                            margin: const EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 3.0,
                            ),
                        child: GestureDetector(
                        onScaleStart: (ScaleStartDetails details) {
                        print(details);

                        _previousScale = _scale;
                        setState(() {

                        });
                        },
                        onScaleUpdate: (ScaleUpdateDetails details) {
                        print(details);
                        _scale = _previousScale*details.scale;
                        setState(() {

                        });
                        },
                        onScaleEnd: (ScaleEndDetails details) {
                        print(details);
                        _previousScale =1.0;
                        setState(() {

                        });
                        },
                        child: RotatedBox(
                        quarterTurns: 0,
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Transform(
                        alignment: FractionalOffset.center,
                        transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                        child:
                        Container(
                        height: MediaQuery.of(context).size.height/6,
                        width: MediaQuery.of(context).size.width/3,
                        decoration: BoxDecoration(
                        image: DecorationImage(
                        image: NetworkImage(
                          snapshot.data[index].data['image']
                        )
                        ))
                        )
                        ),
                        ),
                        ),
                        ));
                      }
                  ),
                );

              }
            }),
        );
  }
}