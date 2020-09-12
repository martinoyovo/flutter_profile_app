import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/services.dart';
class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {



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
              SystemNavigator.pop();
            }),
        title: Text(
          'Liste des candidats',
          style: TextStyle(
              color: Color.fromRGBO(71, 147, 12, 1),
              fontSize: 20.0,
              fontFamily: 'Open Sans'),
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

  navigateToDetail(DocumentSnapshot candidat) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => DetailPage(candidat: candidat,))
    );
    print('ca a marché');
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
                        backgroundColor: Color.fromRGBO(71, 147, 12, 1)));
              } else {

                return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemExtent: 120.0,
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            color: Color.fromRGBO(137, 217, 82, 1),
                            child: ListTile(
                              dense: true,
                              onTap: () => navigateToDetail(snapshot.data[index]),
                              leading: Container(
                                height: 100.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data[index].data['photo']
                                      ),
                                    )
                                ),
                              ),
                              title: Padding(
                                padding: EdgeInsets.only(top: 23.0),
                                child: Text(
                                    snapshot.data[index].data['nom_complet'],
                                    style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    )
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: <Widget>[
                                    Wrap(
                                      direction: Axis.horizontal,
                                      spacing: 10.0,
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
                                  ],
                                ),
                              ),
                              trailing: Container(
                                width: 40.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.0),
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data[index]
                                            .data['logo_parti']),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                            ),
                          ),
                        );
                      });
              }
            })
    );
  }
}



class DetailPage extends StatefulWidget {

  final DocumentSnapshot candidat;

  DetailPage({this.candidat});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final Color blue = Color.fromRGBO(13, 173, 181, 1);
  final Color green = Color.fromRGBO(137, 217, 82, 1);

  bool _isSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Color.fromRGBO(13, 173, 181, 1),
              height: 210.0,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(13, 173, 181, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  image: DecorationImage(
                      alignment: Alignment.centerRight,
                      image: AssetImage('assets/icons/monument.png'))),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Portrait',
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          color: Colors.white
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },

                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            image: DecorationImage(
                                image: NetworkImage(widget.candidat.data['photo']), fit: BoxFit.cover)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.candidat.data['nom_complet'],
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            widget.candidat.data['nom_parti'],
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Téléchargez mon ',
                          style: TextStyle(fontFamily: 'Open Sans'),
                        ),
                        Text('Plan d\'actions 2020',
                            style: TextStyle(
                                fontFamily: 'Open Sans',
                                color: Color.fromRGBO(71, 147, 12, 1),
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    IconButton(
                      icon: Image.asset('assets/icons/image100.png'),
                      onPressed: () {},
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Bonjour Tino,',
                      style: TextStyle(
                        color: Color.fromRGBO(13, 173, 181, 1),
                        fontFamily: 'Open Sans',
                        fontSize: 23,
                      )),
                  ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Text(
                          'N sit amet ante consequat, dictum neque sit amet, lacinia turpis. '
                              'Cras interdum ante ut urna feugiat, eu tempus mi ultricies. '
                              'Nulla sem eros, ornare eget neque ac, venenatis cursus mi. '
                              'Proin aliquet nunc eu bibendum finibus. Quisque viverra bibendum facilisis. ',
                          style: TextStyle(
                            color: Color.fromRGBO(13, 173, 181, 0.5),
                            fontFamily: 'Open Sans',
                            fontSize: 17.0,
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('Ce lundi, 20 janvier 2020 à 20:20',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(71, 147, 12, 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text('${widget.candidat.data['likes']} Mentions J\'aime',
                                style: TextStyle(
                                    fontFamily: 'Open Sans', fontSize: 18)),
                          ],
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 0, 0, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  _isSelected
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Color.fromRGBO(255, 0, 0, 1),
                                  size: 34.0,
                                ),
                                onPressed: () {

                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('Biographie',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 147, 12, 1),
                        fontFamily: 'Open Sans',
                        fontSize: 20,
                      )),
                  Text(
                      'Interdum et malesuada fames ac ante ipsum primis in faucibus. '
                          'Donec non eros quis lectus suscipit pretium. Nulla nec dictum nisl, '
                          'et porta elit. Morbi vehicula ipsum at velit tincidunt fermentum. '
                          'Vivamus id fringilla purus, dictum auctor augue. '
                          'Nam ultricies finibus libero non sollicitudin. '
                          'Etiam posuere nibh a ante consectetur porta. '
                          'Pellentesque nisl est, tincidunt sit amet molestie non,'
                          ' dignissim quis turpis. Cras eu commodo tellus. '
                          'Quisque scelerisque magna purus, ut hendrerit erat ullamcorper eu',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 17,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Age:',
                                style: TextStyle(fontFamily: 'Open Sans')),
                            Text(
                              '20',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(71, 147, 12, 1),
                                fontSize: 21,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Profession:',
                                style: TextStyle(fontFamily: 'Open Sans')),
                            Text(
                              'AppMaker',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(71, 147, 12, 1),
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Niveau d\'études:',
                                style: TextStyle(fontFamily: 'Open Sans')),
                            Text('Master',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(71, 147, 12, 1),
                                  fontSize: 20,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding:
                EdgeInsets.only(top: 20.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        height: 18,
                        width: 23,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(9.0),
                            ),
                            gradient: LinearGradient(
                              colors: [blue, green],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                        ),
                        child: Text('Vidéos', style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 24.0,
                            color: Colors.white
                        ))
                    ),
                    Container(
                        height: 18,
                        width: 23,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(9.0),
                            ),
                            gradient: LinearGradient(
                              colors: [blue, green],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                        ),
                        child: GestureDetector(
                          onTap: () {
                          },
                          child: Text('Vidéos', style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 24.0,
                              color: Colors.white
                          )),
                        )
                    ),
                    Container(
                        height: 18,
                        width: 23,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(9.0),
                            ),
                            gradient: LinearGradient(
                              colors: [blue, green],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                        ),
                        child: GestureDetector(
                          onTap: () {
                          },
                          child: Text('Audios', style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 24.0,
                              color: Colors.white
                          )),
                        )
                    ),
                    Container(
                        height: 18,
                        width: 23,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(9.0),
                            ),
                            gradient: LinearGradient(
                              colors: [blue, green],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                        ),
                        child: GestureDetector(
                          onTap: () {
                          },
                          child: Text('Images', style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 24.0,
                              color: Colors.white
                          )),
                        )
                    ),
                  ],
                )),
          ],
        )
    );
  }
}



