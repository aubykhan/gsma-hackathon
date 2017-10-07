import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

String baseUri = 'http://10.0.0.84/dastak/index.php/api/';

class PaymentInfo {
  PaymentInfo(this.id, this.billerName, this.amount, this.dueDate);

  final String id;
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
    var response = await httpClient.read(baseUri + 'GetSubscriberBill/1');

    List bills = JSON.decode(response);
    print('***response: ' + response);

    List<PaymentInfo> list = new List();
    for (int i = 0; i < bills.length; i++) {
      list.add(new PaymentInfo(bills[i]['ID'], bills[i]['Name'],
          int.parse(bills[i]['Amount']), DateTime.parse(bills[i]['due_date'])));
    }

    return list;
  }
}

class PaymentTransaction {
  PaymentTransaction(this.paymentInfo);

  final PaymentInfo paymentInfo;

  /// network: ep or jc
  Future pay(String network) async {
    final String uri = baseUri + 'merchantTrans_' + (network == 'ep'
        ? 'Telenor/${paymentInfo.id}'
        : 'JazzCash/${paymentInfo.id}');

    print(uri);
    var httpClient = createHttpClient();
    var response = await httpClient.post(
      uri,
    );
    print(response.body);

    Map body = JSON.decode(response.body);

    if (body.containsKey('errorDescription')) {
      throw new Exception('Error occurred. ' + body.toString());
    }
  }
}
