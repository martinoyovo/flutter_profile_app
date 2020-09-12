
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:degigban/candidats/details.dart';

class ListPa extends StatefulWidget {
  @override
  _ListPaState createState() => _ListPaState();
}

class _ListPaState extends State<ListPa> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 23.0,
            color: Color.fromRGBO(71, 147, 12, 1),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Liste des candidats',
          style: TextStyle(
              color: Color.fromRGBO(71, 147, 12, 1),
              fontSize: 20.0,
              fontFamily: 'Open Sans'
          ),
        ),
      ),
      body: Candidats(),
    );
  }
}

class Candidats extends StatefulWidget {
  @override
  _CandidatsState createState() => _CandidatsState();
}

class _CandidatsState extends State<Candidats> {

  Future _data;

  Future getCandidats() async {
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("candidat").getDocuments();

    return snap.documents;
  }

  @override
  void initState() {
    super.initState();

    _data =  getCandidats();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
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
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Details()
                            ));
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height/5,
                              margin: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 3.0,
                              ),
                              child: new Stack(
                                children: <Widget>[
                                  Container(
                                    child: Container(
                                      margin: new EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 9.0),
                                      constraints: new BoxConstraints.expand(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            height: 120.0,
                                            width: 92.0,
                                            alignment: Alignment.center,
                                            child: new Image(
                                              image: new NetworkImage(snapshot.data[index].data['photo']),
                                              fit: BoxFit.cover,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                            ),
                                          ),
                                          new Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              new SizedBox(height: 10.0),
                                              new Text(snapshot.data[index].data['nom_complet'], style: TextStyle(color: Colors.white,
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w600)),
                                              new SizedBox(height: 17.0),
                                              new Container(
                                                margin: new EdgeInsets.symmetric(vertical: 8.0),
                                                height: 40,
                                                width: 110.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                                ),
                                                child: new Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    Text(snapshot.data[index].data['likes']
                                                        .toString(), style: TextStyle(
                                                      fontFamily: 'Open Sans',
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromRGBO(71, 147, 12, 1),
                                                    )),
                                                    Icon(Icons.favorite,
                                                        color: Colors.red,
                                                        size: 24.0
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 97.0,
                                            width: 80.0,
                                            alignment: Alignment.center,
                                            child: new Image(
                                              image: new NetworkImage(snapshot.data[index].data['logo_parti']),
                                              fit: BoxFit.cover,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(15))
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 170.0,
                                    decoration: new BoxDecoration(
                                      color: new Color.fromRGBO(137, 217, 82, 1),
                                      shape: BoxShape.rectangle,
                                      borderRadius: new BorderRadius.circular(8.0),
                                      boxShadow: <BoxShadow>[
                                        new BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10.0,
                                          offset: new Offset(0.0, 10.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          ),
                        );
                      }),
                );

              }
            })
    );
  }
}


