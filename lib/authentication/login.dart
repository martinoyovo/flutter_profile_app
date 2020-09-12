import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:degigban/user/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String phoneNo;
  String smsCode;
  String verificationId;
  String psd;


  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed in');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential credential) async{
      print('verified');
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Center(
              child: Text('Entrer le code sms', style: TextStyle(
                fontFamily: 'Open Sans',
              ),),
            ),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Continuer', style:
                TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Open Sans',color: Color.fromRGBO(71, 147, 12, 1),
                ),
                ),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) async{
                    if (user != null) {
                      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
                      userUpdateInfo.displayName = psd;
                      user.updateProfile(userUpdateInfo);
                      Firestore.instance.collection('/users').add ({
                        'pseudo': user.displayName,
                        'uid': user.uid,
                        'telephone': user.phoneNumber,
                      }).then((value) {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> Dashboard()));
                      }).catchError((e) {
                        print(e);
                      });
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() async{
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsCode
    );
    await FirebaseAuth.instance.signInWithCredential(credential)
        .then((signedInUser) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> Dashboard()));
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/image164.png'),
            )
        ),
        child: Stack(
            fit: StackFit.expand,
            children: <Widget> [
              Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromRGBO(13, 173, 181, 1), Color.fromRGBO(137, 217, 82, 1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),

                  )
              ),
              Column (
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget> [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget> [
                          SizedBox(height: 25,),
                          Text('Inscrivez-vous pour continuer ', style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 14.0,
                              color: Colors.white )
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30.0),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width/3.0,
                            width: MediaQuery.of(context).size.width/3.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/6),
                                image: DecorationImage(
                                    alignment: Alignment.bottomCenter,
                                    image: AssetImage('assets/icons/person.png')
                                )
                            ),
                          ),
                          SizedBox(height: 30,),
                          Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width/1.55,
                            child: TextFormField(
                              autocorrect: true,
                              decoration: InputDecoration(
                                hintText: 'Votre pseudo',
                                hintStyle: TextStyle(
                                    fontFamily: 'Open Sans',
                                    color: Colors.grey),
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
                              onChanged: (value) {
                                this.psd = value;
                              },
                              validator: (String value) {
                                if(value.isEmpty) {
                                  return 'Votre pseudo est requis';
                                }
                                if(value.length < 3) {
                                  return 'Votre pseudo doit contenir au moins trois lettres';
                                }
                                return 'Votre pseudo est requis';
                              },
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width/1.55,
                            child: TextFormField(
                              autocorrect: true,
                              decoration: InputDecoration(
                                hintText: 'Téléphone',
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
                              onChanged: (value) {
                                this.phoneNo = value;
                              },
                              onSaved: (String value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                              validator: (value) {
                                if(value.isEmpty) {
                                  return 'Votre numéro est requis';
                                }
                                if(value.length < 6) {
                                  return 'Le numéro doit avoir au moins six caractères';
                                }
                                return 'Votre numéro est requis';
                              },
                            ),
                          ),
                          SizedBox(height: 30.0,),
                        ]
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Color.fromRGBO(71, 147, 12, 1)
                          ),
                          child: IconButton(
                            onPressed: () {
                              verifyPhone();
                            },
                            icon: Icon(Icons.arrow_forward,
                              color: Colors.white,
                              size: 25.0,
                            )
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('En cliquant, vous acceptez les ', style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 9.0,
                            color: Colors.white )
                        ),
                        Text('conditions d\'utilistation', style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 9.0,
                          color: Color.fromRGBO(71, 147, 12, 1), )
                        ),
                      ],
                    ),
                    SizedBox(height: 70.0,)
                  ]
              )
            ]
        ),
      ),
    );
  }
}


