import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'favorite_screen_view_model.dart';
          
class FavoriteScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoriteScreenViewModel>.reactive(
      builder: (BuildContext context, FavoriteScreenViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('FavoriteScreen View'),
          ),
        );
      },
      viewModelBuilder: () => FavoriteScreenViewModel(),
    );
  }
}
