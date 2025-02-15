import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

void main() {
  // Set up M-Pesa credentials (Replace with your real credentials)
  MpesaFlutterPlugin.setConsumerKey(
      "ZlAM06kufVirRfW7YvCecWbOVWk5JbAPebGkgC8GuW1TBoO7");
  MpesaFlutterPlugin.setConsumerSecret(
      "ASdyLyaGUE18iq8yyZALvufjBVwOVJ7YD5w9jvYkGedzGOfFBSGrAOGkhqAFGepa");

  runApp(MpesaApp());
}

class MpesaApp extends StatelessWidget {
  const MpesaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M-Pesa Payment',
      theme: ThemeData(primarySwatch: Colors.green),
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Future<void> initiateMpesaPayment() async {
    try {
      // Call the M-Pesa STK Push API
      dynamic transaction = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379", // Replace with your Shortcode
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: 10.0, // Payment amount
        partyA: "254701440449", // your phone number (MSISDN)
        partyB: "174379", //  M-Pesa Paybill/Till number
        callBackURL: Uri.parse("https://mpesa.free.beeceptor.com"),
        accountReference: "Test Payment",
        phoneNumber: "2547XXXXXXXX",
        baseUri: Uri.parse("https://sandbox.safaricom.co.ke"),
        transactionDesc: "Payment for goods/services",
        passKey:
            "ZXHTA2pSGrNdPEB+iCFQ8LoivnHasY3XN7Od3GoXtA/+Phgiw3aI8AKzVfe6vx2KvI7Flu5+1Kz4NO9CGKVO/zjDquYghM7byr0q7uPtd24jPPohkU0u4QjRRK9HkiYHhcBOVZ7JDUMgmAiZGpoNBPTzsX8YRh8ZbsNpebODeUWLcNCweWqyH2l/D7u/yq7frbditEQS44H0/9UH4ykZaykeCDc+6yupGyq/V/F460duJehTEEhwUeskqrRLScUM3Lao07PEsAZF121ys/CWJ9RtWzTSpSmSxW/wMDeen/mcy1ffXWj3tIuu9pkv5TLY0C4x7plBnodye+r0jIrM3w==", // Replace with your passkey
      );

      print("Transaction Response: $transaction");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("M-Pesa Payment"), centerTitle: true),
      body: Center(
        child: ElevatedButton(
          onPressed: initiateMpesaPayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          child: Text(
            "Pay with M-Pesa",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
