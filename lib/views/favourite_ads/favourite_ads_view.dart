import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'favourite_ads_view_model.dart';
          
class FavouriteAdsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavouriteAdsViewModel>.reactive(
      builder: (BuildContext context, FavouriteAdsViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('FavouriteAds View'),
          ),
        );
      },
      viewModelBuilder: () => FavouriteAdsViewModel(),
    );
  }
}
