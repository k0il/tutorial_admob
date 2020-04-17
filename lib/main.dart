import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';

String _appid = "ca-app-pub-3940256099942544~3347511713";
String _idbanner = "ca-app-pub-3940256099942544/6300978111";
String _idintertitial = "ca-app-pub-3940256099942544/1033173712";

void main() {
  Admob.initialize(_appid);
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

class _MyHomePageState extends State<MyHomePage> {
  AdmobInterstitial interstitialAd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 50),
              child: Text("Tutorial Admob Flutter"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 150.0, top: 50),
              child: new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  interstitialAd.show();
                },
                child: new Text("Show Intertitial Ads"),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AdmobBanner(
                adUnitId: _idbanner,
                adSize: AdmobBannerSize.BANNER,
                listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                  handleEvent(event, args, 'Banner');
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    interstitialAd = AdmobInterstitial(
      adUnitId: _idintertitial,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        //showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        //showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        print("Goto next page");
        break;
      case AdmobAdEvent.failedToLoad:
        //print("Goto next page");
        break;
      case AdmobAdEvent.rewarded:
        break;
      default:
    }
  }
}
