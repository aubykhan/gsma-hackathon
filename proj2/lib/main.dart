import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Dastak',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Dastak'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new ListView(
        children: <Widget>[
          _buildUserCard(
            context,
            'https://organicthemes.com/demo/profile/files/2012/12/profile_img.png',
            'Mohsin T.',
            '4',
            Colors.green,
          ),
          _buildUserCard(
            context,
            'http://static2.businessinsider.com/image/5899ffcf6e09a897008b5c04-1200/.jpg',
            'Naveed',
            '3',
            Colors.orange,
          ),
        ],
      ),
    );
  }

  _buildUserCard(BuildContext context, String imgUrl, String name,
      String rating, Color ratingColor) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new ListTile(
            leading:
                new CircleAvatar(backgroundImage: new NetworkImage(imgUrl)),
            title: new Text(name),
            subtitle: new Text(
              'Rating ' + rating + '/5',
              style: new TextStyle(
                color: ratingColor,
              ),
            ),
          ),
          new ButtonBar(
            children: <Widget>[
              new RaisedButton(
                onPressed: () {},
                child: const Text(
                  'Reject',
                ),
              ),
              new RaisedButton(
                onPressed: () {},
                color: Theme.of(context).accentColor,
                child: const Text(
                  'Accept',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
