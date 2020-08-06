import 'package:flutter/material.dart';
import 'messages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements Api2Flutter {
  Player _player;
  Api2Host _api2host;

  @override
  void initState() {
    assert(() {
      // Setup mock data
      BattingStats battingStats = BattingStats()
        ..avg = .300
        ..fld = 1.0;

      _player = Player()
        ..name = "Fake Player"
        ..battingStats = battingStats;
      return true;
    }());
    Api2Flutter.setup(this);
    _api2host = Api2Host();
    super.initState();
  }

  void _likePlayer() {
    LikeMessage likeMessage = LikeMessage()..number = _player.number;
    _api2host.likePlayer(likeMessage);
  }

  Widget buildStats(Player player) {
    double width = 150.0;
    double height = 500.0;
    if (player == null) {
      return Container(width: width, height: height);
    } else if (player.pitchingStats != null) {
      return Container(
        width: width,
        height: height,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 30,
          mainAxisSpacing: 0,
          childAspectRatio: 2,
          crossAxisCount: 2,
          children: <Widget>[
            Text('ip'),
            Text('${_player.pitchingStats.ip ?? 0}'),
            Text('k9'),
            Text('${_player.pitchingStats.k9 ?? 0}'),
            Text('bb9'),
            Text('${_player.pitchingStats.bb9 ?? 0}'),
            Text('babip'),
            Text('${_player.pitchingStats.babip ?? 0}'),
            Text('era'),
            Text('${_player.pitchingStats.era ?? 0}'),
          ],
        ),
      );
    } else if (player.battingStats != null) {
      return Container(
        width: width,
        height: height,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 30,
          mainAxisSpacing: 0,
          childAspectRatio: 2,
          crossAxisCount: 2,
          children: <Widget>[
            Text('pa'),
            Text('${_player.battingStats.pa ?? 0}'),
            Text('avg'),
            Text('${_player.battingStats.avg ?? 0}'),
            Text('obp'),
            Text('${_player.battingStats.obp ?? 0}'),
            Text('slg'),
            Text('${_player.battingStats.slg ?? 0}'),
            Text('woba'),
            Text('${_player.battingStats.woba ?? 0}'),
            Text('fld'),
            Text('${_player.battingStats.fld ?? 0}'),
            Text('war'),
            Text('${_player.war ?? 0}'),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${_player == null ? '' : _player.name}',
            ),
            buildStats(_player),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _likePlayer,
        tooltip: 'Like',
        child: Icon(Icons.favorite),
      ),
    );
  }

  @override
  void showPlayer(Player arg) {
    setState(() {
      _player = arg;
    });
  }
}
