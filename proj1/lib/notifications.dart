import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => new _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<BillNotificationCard> _notifications = new List();

  @override
  initState() {
    super.initState();

    _notifications.add(new BillNotificationCard());
    _notifications.add(new BillNotificationCard());
    _notifications.add(new BillNotificationCard());
    _notifications.add(new BillNotificationCard());
    _notifications.add(new BillNotificationCard());
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: _notifications.length,
      itemBuilder: (BuildContext __, int index) {
        return _notifications[index];
      },
    );
  }
}

class BillNotificationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new ListTile(
            title: const Text(
              'Nagori Milk Shop',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            subtitle: const Text('1 November - 4 days remaining'),
            trailing: const Text(
              'Rs. 3,000',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new RaisedButton(
                  onPressed: () {},
                  child: const Text('Remind me'),
                ),
                new RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
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
                                    new PaymentTransaction(
                                      paymentInfo
                                    ).Pay();
                                  },
                                  leading: new CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      backgroundImage: new NetworkImage(
                                          'http://www.jazzcash.com.pk/assets/uploads/2016/05/jazzcash-logo-200x200.png')),
                                  title: const Text('Pay with JazzCash'),
                                ),
                                new ListTile(
                                  onTap: () {

                                  },
                                  leading: new CircleAvatar(
                                      backgroundImage: new NetworkImage(
                                          'https://lh3.googleusercontent.com/b5Sk189FfE4X43i-28gLLL1V08TQOQWDwHl-yQzHeMu1DSDFEn3RFqFQ9FBUyRM9hfc=w300')),
                                  title: const Text('Pay with EasyPaisa'),
                                ),
                              ],
                            ),
                          );
                        });
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
          )
        ],
      ),
    );
  }
}
