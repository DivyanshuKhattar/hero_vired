import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_vired/CommonClasses/custom_toast.dart';
import 'package:hero_vired/ModelClasses/product_model_class.dart';
import 'package:hero_vired/Resources/shared_pref_data.dart';
import 'package:hero_vired/Resources/string_constants.dart';
import 'package:hero_vired/Resources/util.dart';

class GetXControllerCustom extends GetxController{

  @override
  void onInit() {
    fetchProductList();
    super.onInit();
  }

  RxBool dataFetched = false.obs;
  RxList productList = <ProductModelClass>[].obs;
  final cart = 0.obs;

  /// function to FETCH PRODUCT LIST
  Future fetchProductList() async{
    int cartValue = await SharedPrefData().getCartValue();
    dataFetched(false);
    productList.clear();
    try{
      final response = await Util.getProductListData();
      final productResponse = productModelClassFromJson(response);
      if(productResponse.isNotEmpty){
        productList.assignAll(productResponse.obs);
      }
    }
    catch(e){
      dataFetched(true);
      CustomToast.showToastMessage(StringConstants().errorMessage);
      debugPrint(e.toString());
    }
    finally{
      dataFetched(true);
      cart.value = cartValue;
    }
  }

  /// managing the CART VALUE
  increment() => cart.value++;
  decrement() => cart.value--;

}