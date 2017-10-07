import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PaymentInfo {
  PaymentInfo(this.billerName, this.amount, this.dueDate);

  final String billerName;
  final int amount;
  final DateTime dueDate;

  String get formattedAmount {
    NumberFormat formatter =
        new NumberFormat.currency(decimalDigits: 0, symbol: 'Rs.');

    return formatter.format(amount);
  }

  String get formattedDate {
    DateFormat formatter = new DateFormat.MMMMEEEEd();
    return formatter.format(dueDate);
  }

  static Future<List<PaymentInfo>> get() async {
    var httpClient = createHttpClient();
    var response = await httpClient.read('http://10.0.0.84/dastak/index.php/api/GetSubscriberBill/1');

    List bills = JSON.decode(response);
    print('***response: ' + response);

    List<PaymentInfo> list = new List();
    for (int i = 0; i < bills.length; i++) {
      list.add(new PaymentInfo(bills[i]['Name'], int.parse(bills[i]['Amount']), DateTime.parse(bills[i]['due_date'])));
    }

    return list;
  }
}

class PaymentTransaction {
  PaymentTransaction(this.paymentInfo);

  final PaymentInfo paymentInfo;

  /// network: ep or jc
  Future pay(String network) async {
    final String uri =
        'https://api.telenor.com.pk/debitma/v1.1/mm/transactions';
    final String accessToken = '6KbctPoLOxBkSU7r3fPWS6koWWMN';
    final String apiKey = 'TelenorAPIGW';
    final String channel = 'gsmamerchant';
    final String userCredentials =
        'SGFja2F0aG9uOjEyYmNlMzc0ZTdiZTE1MTQyZTgxNzJmNjY4ZGEwMGQ4';
    final String walletNumber = "923478879284";

    String encodedString = JSON.encode(
      {
        "amount": paymentInfo.amount,
        "currency": "PKR",
        "type": "merchantpay",
        "subType": "debitMA",
        "requestDate": paymentInfo.dueDate.toIso8601String(),
        "debitParty": [
          {"key": "msisdn", "value": walletNumber}
        ],
        "creditParty": [
          {"key": "storeid", "value": "6978"}
        ],
        "senderKyc": {"emailAddress": "abc@xyz.com"},
        "requestingOrganisationTransactionReference": "1234567"
      },
    );

    var httpClient = createHttpClient();
    print('Access token: ' + accessToken);
    var response = await httpClient.post(
      uri,
      body: encodedString,
      headers: {
        "Authorization": "Basic 6KbctPoLOxBkSU7r3fPWS6koWWMN",
        "X-API-Key": apiKey,
        "X-Channel": channel,
        "X-User-Credential-1": userCredentials,
        "Content-Type": "application/json"
      },
    );
    print(response.body);

    // Map data = JSON.decode(response.body);
  }
}
