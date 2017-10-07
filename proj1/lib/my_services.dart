import 'package:flutter/material.dart';

class MyServicesPage extends StatefulWidget {
  @override
  _MyServicesPageState createState() => new _MyServicesPageState();
}

class _MyServicesPageState extends State<MyServicesPage> {
  List<SubscriptionCard> _subscriptions = new List();

  @override
  initState() {
    super.initState();

    _subscriptions.add(
      new SubscriptionCard(
        new Subscription(
          'Hammad',
          'Internet',
          'Monthly',
        ),
      ),
    );

    _subscriptions.add(
      new SubscriptionCard(
        new Subscription(
          'Asad',
          'Water',
          'Monthly',
        ),
      ),
    );

    _subscriptions.add(
      new SubscriptionCard(
        new Subscription(
          'Shah',
          'Milk',
          'Monthly',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: _subscriptions.length,
      itemBuilder: (BuildContext __, int index) {
        return _subscriptions[index];
      },
    );
  }
}

class Subscription {
  Subscription(this.billerName, this.type, this.frequency);

  final String billerName;
  final String type;
  final String frequency;
}

class SubscriptionCard extends StatelessWidget {
  SubscriptionCard(this._info);

  final Subscription _info;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new ListTile(
            title: new Text(
              _info.billerName,
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            subtitle: new Text(_info.type),
            trailing: new Container(
              padding: const EdgeInsets.all(4.0),
              color: Colors.amber,
              child: new Text(
                _info.frequency,
                style: new TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          new Divider(),
          new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {},
                  child: const Text(
                    'Unsubscribe',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                new Container(
                  width: 64.0,
                ),
                const Text('Auto pay'),
                new Switch(
                  onChanged: (bool value) { },
                  value: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
