import 'package:flutter/material.dart';
import 'package:master_price_picker/theme/colors.dart';
import 'package:master_price_picker/theme/fonts.dart';
import 'package:stacked/stacked.dart';
import 'my_profile_view_model.dart';

class MyProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ViewModelBuilder<MyProfileViewModel>.reactive(
      builder: (BuildContext context, MyProfileViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("My Profile"),
          ),
          body: viewModel.isBusy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : viewModel.user_data != null
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          child: CircleAvatar(
                            radius: size.width * 0.2,
                            backgroundColor: compColor,
                            child: Icon(
                              Icons.person_outline_rounded,
                              size: size.width * 0.2,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Text(
                            viewModel.user_data.email,
                            style: titleFont,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          width: size.width,
                          margin: EdgeInsets.all(16.0),
                          child: MaterialButton(
                            padding: EdgeInsets.all(16.0),
                            onPressed: viewModel.logout,
                            color: compColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Sign out",
                                  style: smallHeading.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 150,
                          ),
                          Text(
                            "You are currently not signed in.",
                            style: smallHeading,
                          ),
                          Container(
                            width: size.width,
                            margin: EdgeInsets.all(16.0),
                            child: MaterialButton(
                              padding: EdgeInsets.all(16.0),
                              onPressed: viewModel.navigateToLoginScreen,
                              color: compColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Sign In",
                                    style: smallHeading.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        );
      },
      viewModelBuilder: () => MyProfileViewModel(),
    );
  }
}
