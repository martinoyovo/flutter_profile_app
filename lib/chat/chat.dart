import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String uid = '';
  String pseudo = '';
  String telephone = '';

  getUid() {}

  @override
  void initState() {
    this.uid = '';
    FirebaseAuth.instance.currentUser().then((val) {
      setState(() {
        this.uid = val.uid;
        this.pseudo = val.displayName;
        this.telephone = val.phoneNumber;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }
  final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async{
    if(messageController.text.length <= 200 && messageController.text.length > 0) {
      await
      _firestore.collection('messages').add({'timestamp': DateTime.now().toIso8601String(),
      'text': messageController.text,
      'from': '$pseudo',
      });
      messageController.clear();
      scrollController.animateTo(scrollController.position.maxScrollExtent, curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    }
  }

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
            'Opinion',
            style: TextStyle(
                color: Color.fromRGBO(71, 147, 12, 1),
                fontSize: 20.0,
                fontFamily: 'Open Sans'
            ),
          ),
        ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').orderBy('timestamp', descending: false).limit(200).snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(71,147,12,1),
                    ),
                  );

                  List<DocumentSnapshot> docs = snapshot.data.documents;

                  List<Widget> messages = docs
                      .map((doc) => Message(
                        timestamp: doc.data['timestamp'].toString(),
                        from: doc.data['from'],
                        text: doc.data['text'],
                        me: '$pseudo' == doc.data['from'])
                  ).toList();

                  return ListView(
                    controller: scrollController,
                      children: <Widget>[
                        ...messages,
                      ],
                  );
                },
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width/1.55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(23), bottomLeft: Radius.circular(23),),
                          color: Colors.white,
                        ),
                        child: TextField(
                          textInputAction: TextInputAction.send,
                          onSubmitted: (value) => callback(),
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: 'Entrer le message...',
                            hintStyle: TextStyle(fontFamily: 'Open Sans',color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(

                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        width: 84,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(79, 196, 128, 1),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(23), bottomRight: Radius.circular(23,),
                        ),),
                        child: SendButton(
                          text: "Envoyer",
                          callback: callback,
                        )
                      )
                    ],
                  ),
                )
              ]
            )
          ]
        ),
      )
    );
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final timestamp;
  final VoidCallback callback;

  const SendButton({Key key, this.timestamp, this.text, this.callback}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: callback,
      child: Text(text, style: TextStyle(fontSize: 13, letterSpacing: 0, color: Colors.white, fontFamily: 'Open Sans',fontWeight: FontWeight.bold),),
    );
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;
  final String timestamp;
  final bool me;

  const Message({Key key,this.timestamp, this.from, this.text, this.me}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(

        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width*0.90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.0)
            ),
              color: Colors.grey[100],
            ),
            padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 15.0, top: 10.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if(me)
                    Text('',
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    )

                    else(
                      Text(
                    '@'+from,
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  )),
                  Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      color: Colors.grey,
                  ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text((timestamp), style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Open Sans',
                        color: Colors.grey,
                    ),)],
                  )
                ],
              ),
            ),
          ),

        ],
      )
    );
  }
}


