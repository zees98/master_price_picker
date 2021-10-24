import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';

class FavouriteAdsViewModel extends StreamViewModel {
  Logger log;

  FavouriteAdsViewModel() {
    log = getLogger(this.runtimeType.toString());
  }

  @override
  // TODO: implement stream
  Stream get stream => throw UnimplementedError();
}
