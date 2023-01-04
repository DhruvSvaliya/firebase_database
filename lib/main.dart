
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MaterialApp(
    home: home(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
  ));
}

class home extends StatefulWidget {
  DocumentSnapshot? document;
  home([this.document]);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  CollectionReference users = FirebaseFirestore.instance.collection('form');
  TextEditingController name = TextEditingController();
  TextEditingController con = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3185429566857502/6279836883',
    size: AdSize.smartBanner,
    request: AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );

  //InterstitialAd
  // InterstitialAd? _interstitialAd;
  // int _numInterstitialLoadAttempts = 0;

  // _createInterstitialAd() {
  //   InterstitialAd.load(
  //       adUnitId: Platform.isAndroid
  //           ? 'ca-app-pub-3940256099942544/1033173712'
  //           : 'ca-app-pub-3940256099942544/4411468910',
  //       request: AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: (InterstitialAd ad) {
  //           print('$ad loaded');
  //           _interstitialAd = ad;
  //           _numInterstitialLoadAttempts = 0;
  //           _interstitialAd!.setImmersiveMode(true);
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           print('InterstitialAd failed to load: $error.');
  //           _numInterstitialLoadAttempts += 1;
  //           _interstitialAd = null;
  //           if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
  //             _createInterstitialAd();
  //           }
  //         },
  //       ));
  // }
  //
  // void _showInterstitialAd() {
  //   if (_interstitialAd == null) {
  //     print('Warning: attempt to show interstitial before loaded.');
  //     return;
  //   }
  //   _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (InterstitialAd ad) =>
  //         print('ad onAdShowedFullScreenContent.'),
  //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //       print('$ad onAdDismissedFullScreenContent.');
  //       ad.dispose();
  //       _createInterstitialAd();
  //     },
  //     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //       _createInterstitialAd();
  //     },
  //   );
  //   _interstitialAd!.show();
  //   _interstitialAd = null;
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myBanner.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.document!=null)
    {
      Map<String, dynamic> data = widget.document!.data()! as Map<String, dynamic>;
      name.text=data['user_name'];
      con.text=data['contact'];
      email.text=data['email'];
      pass.text=data['password'];
    }
    myBanner.load();
    // _createInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage("image/photo1.jpg"))),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.cyanAccent)),
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width / 1.2,
            child: Column(children: [
              Expanded(
                  child: Container(
                child: TextField(
                  controller: name,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "User name",
                      labelText: "User name",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                margin: EdgeInsets.all(10),
              )),
              Expanded(
                  child: Container(
                child: TextField(
                  maxLength: 10,
                  controller: con,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      prefix: Text("+91"),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Contact",
                      labelText: "Contact",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                margin: EdgeInsets.all(5),
              )),
              Expanded(
                  child: Container(
                child: TextField(
                  controller: email,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Email id",
                      labelText: "Email id",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                margin: EdgeInsets.all(5),
              )),
              Expanded(
                  child: Container(
                child: TextField(
                  controller: pass,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Password",
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                margin: EdgeInsets.all(5),
              )),
              Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                ElevatedButton(
                  onPressed: () {
                    addUser().then((value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return view();
                        },
                      ));
                    });
                    name.text = "";
                    name.text = "";
                    name.text = "";
                    name.text = "";
                  },
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.cyanAccent,
                      elevation: 3),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                      return view();
                    }));
                  },
                  child: Text("View"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.tealAccent,
                      elevation: 3),
                ),
              ],)
            ]),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          alignment: Alignment.center,
          child: AdWidget(ad: myBanner),
          width: double.infinity,
          height: 50),
    );
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'user_name': name.text, // John Doe
          'contact': con.text, // Stokes and Sons
          'email': email.text, // 42
          'password': pass.text // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
