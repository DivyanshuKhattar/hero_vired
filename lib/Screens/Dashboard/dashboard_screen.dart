import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hero_vired/CommonClasses/common_function.dart';
import 'package:hero_vired/CommonClasses/custom_drawer.dart';
import 'package:hero_vired/ModelClasses/product_model_class.dart';
import 'package:hero_vired/Resources/color_picker.dart';
import 'package:hero_vired/Resources/getx_controller_custom.dart';
import 'package:hero_vired/Resources/string_constants.dart';
import 'package:hero_vired/Resources/styling.dart';
import 'package:hero_vired/Screens/Dashboard/detail_page.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double deviceHeight = 0.0;
  double deviceWidth = 0.0;
  TextEditingController searchController = TextEditingController();
  final GetXControllerCustom getController = Get.put(GetXControllerCustom());
  List<ProductModelClass> searchList = [];
  Timer? searchTimer;
  bool searchStarted = false;

  @override
  void initState() {
    /// for setting green status bar
    CommonFunction.darkGreenStatusBarColor();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// function to SEARCH PRODUCT LIST
  Future searchProduct(String text) async {
    setState(() {
      searchList.clear();
      searchStarted = true;
    });
    for(var value in getController.productList){
      if(value.category!.toLowerCase().contains(text) || value.title!.toLowerCase().contains(text)){
        searchList.add(value);
      }
    }
    setState(() {});
  }

  /// function to FETCH PRODUCT as per future needs
  Future pullToRefresh() async{
    getController.fetchProductList();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: whiteColor,
        drawer: const CustomDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                /// Appbar
                Container(
                  height: deviceHeight*0.24,
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.045, vertical: deviceHeight*0.01),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap:(){
                              scaffoldKey.currentState!.openDrawer();
                            },
                            child: SvgPicture.asset(
                              "assets/svg_icons/menu.svg",
                              height: deviceHeight*0.026,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap:(){ },
                            child: SvgPicture.asset(
                              "assets/svg_icons/heart.svg",
                              height: deviceHeight*0.026,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(width: deviceWidth*0.04,),
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.02, vertical: deviceHeight*0.012),
                                child: GestureDetector(
                                  onTap:(){ },
                                  child: SvgPicture.asset(
                                    "assets/svg_icons/cart.svg",
                                    height: deviceHeight*0.026,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Obx(() => getController.cart.value != 0
                                ? CircleAvatar(
                                  radius: 7,
                                  backgroundColor: Colors.red,
                                  child: Center(
                                    child: Text(
                                      "${getController.cart.value}",
                                      style: CustomStyle.eightSemiBoldWhiteText,
                                    ),
                                  ),
                                )
                                : Container(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            StringConstants().grabFavouriteProduct,
                            style: CustomStyle.twentySemiBoldWhiteText,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: deviceWidth*0.9,
                        height: deviceHeight*0.055,
                        child: TextField(
                          controller: searchController,
                          onChanged: (value){
                            if(value.trim().isNotEmpty){
                              if(searchTimer != null && searchTimer!.isActive){
                                setState(() {
                                  searchTimer!.cancel();
                                });
                              }
                              searchTimer = Timer(const Duration(milliseconds: 300), () {
                                searchProduct(value.trim());
                              });
                            }
                            else{
                              pullToRefresh();
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() {
                                searchStarted = false;
                                searchList.clear();
                              });
                            }
                          },
                          cursorColor: greenColor,
                          style: CustomStyle.fourteenNormalBlackText,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            prefixIcon: Icon(Icons.search, size: deviceHeight*0.026, color: blackColor.withOpacity(0.35),),
                            suffixIcon: searchStarted
                              ? GestureDetector(
                                onTap: (){
                                  setState(() {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    searchStarted = false;
                                    searchController.clear();
                                    searchList.clear();
                                  });
                                },
                                child: Icon(Icons.cancel_outlined, size: deviceHeight*0.026, color: blackColor.withOpacity(0.35),),
                              )
                              : Icon(Icons.mic_outlined, size: deviceHeight*0.026, color: blackColor.withOpacity(0.35),),
                            filled: true,
                            fillColor: whiteColor,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: "Search your favourite Product",
                            hintStyle: CustomStyle.fourteenNormalLightBlackText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /// Product List
                Container(
                  color: greenColor,
                  child: Container(
                    height: deviceHeight*0.72,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(40)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.014, vertical: deviceHeight*0.01),
                    child: LiquidPullToRefresh(
                      onRefresh: pullToRefresh,
                      springAnimationDurationInMilliseconds: 100,
                      backgroundColor: greenColor,
                      color: whiteColor,
                      child: Obx((){
                        if(getController.dataFetched.value == false){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        else if(getController.productList.isEmpty || (searchStarted == true && searchList.isEmpty)){
                          return Center(
                            child: Text(
                              StringConstants().noProductFound,
                              style: CustomStyle.sixteenSemiBoldBlackText,
                            ),
                          );
                        }
                        else{
                          return MasonryGridView.builder(
                            itemCount: searchList.isEmpty ? getController.productList.length : searchList.length,
                            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index){
                              ProductModelClass? data;
                              if(searchList.isEmpty){
                                data = getController.productList[index];
                              }
                              else{
                                data = searchList[index];
                              }
                              return GestureDetector(
                                onTap: (){
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPageScreen(productId: data!.id!,),
                                    ),
                                  ).then((value) {
                                    CommonFunction.darkGreenStatusBarColor();
                                  });
                                },
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: deviceWidth*0.024, vertical: deviceHeight*0.014),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.02, vertical: deviceHeight*0.008),
                                    child: Column(
                                      children: [
                                        FadeInImage(
                                          placeholder: Image.asset("assets/images/transparent_image.png").image,
                                          image: Image.network(
                                            data!.image!,
                                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                              return Image.asset("assets/images/image_error.png");
                                            },
                                          ).image,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: deviceHeight*0.016, bottom: deviceHeight*0.008,),
                                          child: Text(
                                            data.title!,
                                            style: CustomStyle.twelveNormalBlackText,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$ ${data.price!.toString()}",
                                              style: CustomStyle.fourteenBoldGreenText,
                                            ),
                                            Container(
                                              width: deviceWidth*0.075,
                                              height: deviceHeight*0.03,
                                              decoration: BoxDecoration(
                                                color: greenColor,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: SvgPicture.asset("assets/svg_icons/right-arrow.svg"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      })
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
