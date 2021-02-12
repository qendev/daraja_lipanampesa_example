import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:flutter/services.dart';

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
  final TextEditingController phonenumberController = new TextEditingController();
  final TextEditingController amountController = new TextEditingController();
  bool validator = false;



  //create the lipaNaMpesa method here.Please note, the method can have any name, I chose lipaNaMpesa
  Future<void> lipaNaMpesa() async {
    dynamic transactionInitialisation;
    try {
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode: "174379",
              transactionType: TransactionType.CustomerPayBillOnline,
              amount: double.parse(amountController.text),
              partyA: phonenumberController.text,
              partyB: "174379",
//Lipa na Mpesa Online ShortCode
              callBackURL: Uri(
                  scheme: "https",
                  host: "mpesa-requestbin.herokuapp.com",
                  path: "/1hhy6391"),
//This url has been generated from http://mpesa-requestbin.herokuapp.com/?ref=hackernoon.com for test purposes
              accountReference: "Cdan",
              phoneNumber: phonenumberController.text,
              baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
              transactionDesc: "purchase",
              passKey:
                  "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");
//This passkey has been generated from Test Credentials from Safaricom Portal

      return transactionInitialisation;
    } catch (e) {
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
          child: Container(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: phonenumberController,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Your PhoneNumber';
                      }
                      return null;
                    },

                    decoration:
                        InputDecoration(labelText: 'Enter your PhoneNumber'),
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  ),
                     TextFormField(
                      controller: amountController,
                     // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Your PhoneNumber';
                        }
                        return null;
                      },

                      decoration: InputDecoration(labelText: 'Enter Amount'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                      // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    ),

                  SizedBox(
                    height: 56.0,
                    child: Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                ],
              ),
            ),
          ),
        ),
      );

  }
}

