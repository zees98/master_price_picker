import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_price_picker/theme/colors.dart';
import 'package:master_price_picker/widgets/app_button.dart';
import 'package:master_price_picker/widgets/field.dart';
import 'package:stacked/stacked.dart';
import 'register_screen_view_model.dart';
          
class RegisterScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterScreenViewModel>.reactive(
      builder: (BuildContext context, RegisterScreenViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: ScreenUtilInit(
            designSize: Size(360, 690),
            builder: () => Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 130,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35.0),
                        topLeft: Radius.circular(35.0),
                      ),
                    ),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              //color: backgroundColor,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Register",
                                          style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 40),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Field(
                                    leadingText: "",
                                    hinttext: 'Name',
                                    color: backgroundColor,
                                    textColor: Colors.black,
                                    type: false,
                                    onchanged: (value) {
                                      viewModel.name = value;
                                    },
                                  ),
                                  Field(
                                    leadingText: "",
                                    hinttext: 'Email',
                                    color: backgroundColor,
                                    textColor: Colors.black,
                                    type: false,
                                    onchanged: (value) {
                                      viewModel.email = value;
                                    },
                                  ),
                                  Field(
                                    leadingText: "",
                                    hinttext: 'Password',
                                    color: backgroundColor,
                                    textColor: Colors.black,
                                    type: true,
                                    onchanged: (value) {
                                      viewModel.password = value;
                                    },
                                  ),
                          
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AppButton(
                                      text: "Register",
                                      color: backgroundColor,
                                      textColor: Colors.white,
                                      onpressed: () async {
                                        viewModel.provideEmailSign();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Already have an account? "),
                                        GestureDetector(
                                            child: Text(
                                          "Login",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: (){
                                           viewModel.navigateToLoginScreen();
                                        },),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
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
      viewModelBuilder: () => RegisterScreenViewModel(),
    );
  }
}
