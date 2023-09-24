import 'package:flutter/material.dart';
import 'package:hero_vired/Resources/color_picker.dart';
import 'package:hero_vired/Resources/string_constants.dart';
import 'package:hero_vired/Resources/styling.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: greenColor,
      ),
      child: Drawer(
        backgroundColor: lightGreenColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// header
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                    child: Icon(
                      Icons.close,
                      color: greenColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.04),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: greenColor,
                        child: Icon(Icons.face, color: whiteColor,),
                      ),
                    ),
                    Text(
                      StringConstants().profile,
                      style: CustomStyle.sixteenSemiBoldBlackText,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: deviceHeight*0.02),
                child: Divider(
                  color: greenColor.withOpacity(0.6),
                  thickness: 0.6,
                  endIndent: 20,
                  indent: 20,
                ),
              ),

              /// terms & condition
              SizedBox(height: deviceHeight*0.01,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.04),
                      child: const Icon(Icons.warning_amber),
                    ),
                    Text(
                      StringConstants().termsCondition,
                      style: CustomStyle.fourteenNormalBlackText,
                    ),
                  ],
                ),
              ),

              /// privacy policy
              SizedBox(height: deviceHeight*0.03,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.04),
                      child: const Icon(Icons.privacy_tip_outlined),
                    ),
                    Text(
                      StringConstants().privacyPolicy,
                      style: CustomStyle.fourteenNormalBlackText,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
