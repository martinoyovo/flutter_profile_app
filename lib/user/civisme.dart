import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Civisme extends StatelessWidget {
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
          'Civisme',
          style: TextStyle(
              color: Color.fromRGBO(71, 147, 12, 1),
              fontSize: 20.0,
              fontFamily: 'Open Sans'),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('civisme').snapshots(),
        builder: (context, snapshot){
          if (!snapshot.hasData)
            return Center(
            child: Text('Chargement', style: TextStyle(color: Color.fromRGBO(71, 147, 12, 1), fontFamily: 'Open Sans',
            fontSize: 22.0,)
           ),
        );
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index])
          );
      }
      )
      );
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  return Container(
    child: ExpansionTile(

      title: Text(document['titre'], style: TextStyle(color: Color.fromRGBO(71, 147, 12, 1), fontFamily: 'Open Sans',fontSize: 19)),
      leading: Image.asset('assets/icons/image164.png'),
      children: <Widget>[
        Padding(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  document['contenu'],
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 15
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
