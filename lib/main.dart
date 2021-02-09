import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

//add Dart Async to the imports since this is an asynchronous process
import 'dart:async';

void main() {
  MpesaFlutterPlugin.setConsumerKey("kVbAIHO3fyJSNvYaooZeVjCfNCAjBAQ7");
  MpesaFlutterPlugin.setConsumerSecret("kKnYdiotLuCxZUnO");

  runApp(DarajaApp());
}

class DarajaApp extends StatefulWidget {
  @override
  _DarajaAppState createState() => _DarajaAppState();
}

class _DarajaAppState extends State<DarajaApp> {

  //create the lipaNaMpesa method here.Please note, the method can have any name, I chose lipaNaMpesa
  Future<void> lipaNaMpesa() async {
    dynamic transactionInitialisation;
    try {
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: 1.0,
          partyA:  "254727916009",
          partyB: "174379",
//Lipa na Mpesa Online ShortCode
          callBackURL: Uri(scheme: "https",
              host: "mpesa-requestbin.herokuapp.com",
              path: "/1hhy6391"),
//This url has been generated from http://mpesa-requestbin.herokuapp.com/?ref=hackernoon.com for test purposes
          accountReference: "George Waweru",
          phoneNumber:  "254727916009",
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "purchase",
          passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");
//This passkey has been generated from Test Credentials from Safaricom Portal

      return transactionInitialisation;
    }

    catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF481E4D)),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mpesa Payment Demo'),
          centerTitle: true,
        ),
        body: Center(
          child: RaisedButton(
            color: Color(0xFF481E4D),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            onPressed: () {
              lipaNaMpesa();
            },
            child: Text(
              "Lipa na Mpesa",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

}
