import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class FavouriteAdsViewModel extends FutureViewModel<QuerySnapshot> {
  Logger log;

  FavouriteAdsViewModel() {
    log = getLogger(this.runtimeType.toString());
  }

  Future<QuerySnapshot> getMyFavourites() async {
    var uid = (await FirebaseAuth.instance.currentUser()).uid;
    var data = await FirebaseFirestore.instance
        .collection('favorite')
        .where('uid', isEqualTo: uid)
        .get();
    return data;
  }

  openURL(url) async {
    print(url);

    launch(url);
  }

  @override
  Future<QuerySnapshot> futureToRun() => getMyFavourites();
}
