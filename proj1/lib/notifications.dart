import 'dart:async';

import 'package:flutter/material.dart';
import 'payments.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => new _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<BillNotificationCard> _notifications = new List();
  bool _isLoading = false;

  @override
  initState() {
    super.initState();

    _refresh();
  }

  _refresh() async {
    setState(() => _isLoading = true);
    try {
      var list = await PaymentInfo.get();
      print('***list count: ' + list.length.toString());
      setState(
        () {
          _notifications.clear();

          for (var info in list) {
            _notifications
                .add(new BillNotificationCard(info, () => _refresh()));
          }
        },
      );
    } catch (ex) {
      print(ex);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? _buildLoader() : _buildList();
  }

  Widget _buildLoader() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  Widget _buildList() {
    return new ListView.builder(
      itemCount: _notifications.length,
      itemBuilder: (BuildContext __, int index) {
        return _notifications[index];
      },
    );
  }
}

class BillNotificationCard extends StatefulWidget {
  BillNotificationCard(this._info, this.refreshCallback);

  final PaymentInfo _info;
  final VoidCallback refreshCallback;

  @override
  _BillNotificationCardState createState() =>
      new _BillNotificationCardState(_info, refreshCallback);
}

class _BillNotificationCardState extends State<BillNotificationCard> {
  _BillNotificationCardState(this._info, this.refreshCallback);

  final PaymentInfo _info;
  final VoidCallback refreshCallback;
  bool _isBusy = false;

  @override
  Widget build(BuildContext context) {
    return new Card(child: _buildCardContent(context));
  }

  Widget _buildLoader() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return new Column(
      children: <Widget>[
        new ListTile(
          title: new Text(
            _info.billerName,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          subtitle: new Text(_info.formattedDate),
          trailing: new Text(
            _info.formattedAmount,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        new ButtonBar(
          children: <Widget>[
            new RaisedButton(
              onPressed: () {},
              child: const Text('Remind me'),
            ),
            _isBusy
                ? _buildLoader()
                : new RaisedButton(
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      _showPaymentSelection(context);
                    },
                    child: const Text(
                      'Pay now',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  _showPaymentSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return new Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                onTap: () {
                  _initPayment(context, 'jc');
                  Navigator.of(context).pop();
                },
                leading: new CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: new NetworkImage(
                        'http://www.jazzcash.com.pk/assets/uploads/2016/05/jazzcash-logo-200x200.png')),
                title: const Text('Pay with JazzCash'),
              ),
              new ListTile(
                onTap: () {
                  _initPayment(context, 'ep');
                  Navigator.of(context).pop();
                },
                leading: new CircleAvatar(
                    backgroundImage: new NetworkImage(
                        'https://lh3.googleusercontent.com/b5Sk189FfE4X43i-28gLLL1V08TQOQWDwHl-yQzHeMu1DSDFEn3RFqFQ9FBUyRM9hfc=w300')),
                title: const Text('Pay with EasyPaisa'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future _initPayment(BuildContext context, String network) async {
    try {
      setState(() => _isBusy = true);
      await new PaymentTransaction(_info).pay(network);

      showDialog(
        context: context,
        child: new AlertDialog(
          content: const Text('Congratulations! Your bill has been paid.'),
          actions: [
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                refreshCallback();
              },
            ),
          ],
        ),
      );
    } catch (ex) {
      print(ex.toString());
      showDialog(
        context: context,
        child: new AlertDialog(
          content: const Text('Unable to pay the bill right now.'),
          actions: [
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isBusy = false);
    }
  }
}
