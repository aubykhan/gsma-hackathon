import 'package:flutter/material.dart';

class ExploreServicesPage extends StatefulWidget {
  @override
  _ExploreServicesPageState createState() => new _ExploreServicesPageState();
}

class _ExploreServicesPageState extends State<ExploreServicesPage> {
  List<ServiceCard> _services = new List();

  @override
  initState() {
    super.initState();

    _services.add(new ServiceCard(new Service('', 'Milkshop', 3, 'https://s-media-cache-ak0.pinimg.com/originals/a7/aa/b8/a7aab833b279b897a232376a0e0cc996.jpg')));
    _services.add(new ServiceCard(new Service('', 'Cable service', 4, 'http://images.jdmagicbox.com/comp/mumbai/z1/022pxx22.xx22.150826145401.j3z1/catalogue/nagori-milk-center-kandarpada-dahisar-west-mumbai-0.jpg')));
    _services.add(new ServiceCard(new Service('', 'Murghi wala', 4, 'http://i.dawn.com/medium/2015/09/55edf82fdbafc.jpg')));
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: _services.length,
      itemBuilder: (__, index) => _services[index],
    );
  }
}

class Service {
  Service(this.id, this.billerName, this.rating, this.imgUrl);

  final String id;
  final String billerName;
  final int rating;
  final String imgUrl;
}

class ServiceCard extends StatelessWidget {
  ServiceCard(this._info);

  final Service _info;

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: 180.0,
      child: new Card(
        child: new Stack(
          children: <Widget>[
            _buildExpandedImage(context),
            _buildOverlayInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayInfo(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Expanded(
          child: new Container(),
        ),
        new ListTile(
          title: new Text(
            _info.billerName,
            style: new TextStyle(color: Colors.white),
          ),
          subtitle: new Text(
            'Rating ${_info.rating.toString()}/5',
            style: new TextStyle(color: Colors.white),
          ),
          trailing: new RaisedButton(
            onPressed: _subscribe,
            color: Theme.of(context).accentColor,
            child: const Text(
              'Subscribe',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildExpandedImage(BuildContext context) {
    return new Row(
      children: [
        new Expanded(
          child: new Image.network(
            _info.imgUrl,
            fit: BoxFit.fitWidth,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
        ),
      ],
    );
  }

  void _subscribe() {
    
  }
}
