import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:degigban/candidats/videos.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class TousLesVideos extends StatefulWidget {
  @override
  _TousLesVideosState createState() => _TousLesVideosState();
}

class _TousLesVideosState extends State<TousLesVideos> {

  Future _data;

  Future getCandidats() async {
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("videos").getDocuments();

    return snap.documents;
  }
  @override
  void initState() {
    super.initState();

    _data =  getCandidats();
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
            'Vidéos',
            style: TextStyle(
                color: Color.fromRGBO(71, 147, 12, 1),
                fontSize: 20.0,
                fontFamily: 'Open Sans'),
          ),
        ),
        body: FutureBuilder(
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
                        child:Videos(
                          videoPlayerController: VideoPlayerController.network(snapshot.data[index].data['video']),
                          looping: true,
                        ),
                        );
                    }
                  ),
            );

          }
        })
    );
  }
}

