import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/orders/details_data.dart';
import '../../data/model/cartmodel.dart';
import '../../data/model/ordersmodel.dart';

class OrdersDetailsController extends GetxController {
  OrdersDetailsData ordersDetailsData = OrdersDetailsData(Get.find());
  List data = [];
  String? customerphone;
  String? customername;
  String? deliveryphone;
  String? deliveryname;
  late StatusRequest statusRequest;
  late OrdersModel ordersModel;
  late Completer<GoogleMapController> completercontroller;
  List<Marker> markers = [];
  double? lat;
  double? long;
  MyServices myServices = Get.find();

  CameraPosition? cameraPosition;

  intialData() {
    completercontroller = Completer<GoogleMapController>();
    if (ordersModel.ordersType == 0) {
      cameraPosition = CameraPosition(
        target: LatLng(ordersModel.ordersAddressLat!.toDouble(), ordersModel.ordersAddressLong!.toDouble()),
        zoom: 12.4746,
      );
      markers.add(
          Marker(
          markerId: MarkerId("1"),
          position: LatLng(ordersModel.ordersAddressLat!.toDouble(), ordersModel.ordersAddressLong!.toDouble())
          )
      );
    }
  }

  @override
  void onInit() {
    ordersModel = Get.arguments['ordersmodel'];
    getData();
    getcustomerData();
    if(ordersModel.ordersType==0){
      getdeliveryData();
    }
    intialData();
    super.onInit();
  }

  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await ordersDetailsData.getData(
        ordersModel.ordersId!.toString(),
    );
    print("===============================OrdersDetailsController  $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success"){
        data = response['data'];
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  getcustomerData() async {
    statusRequest = StatusRequest.loading;
    var response = await ordersDetailsData.customerData(
        ordersModel.ordersUsersid.toString()
    );
    print("===============================getcustomerData  $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success"){
         Map<String, dynamic> listdata2 = response['data'];
         customerphone= listdata2["users_phone"];
         customername= listdata2["users_name"];
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }
  getdeliveryData() async {
    statusRequest = StatusRequest.loading;
    var response = await ordersDetailsData.deliveryData(
        ordersModel.ordersDelivery.toString()
    );
    print("===============================getdeliveryData  $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success"){
        Map<String, dynamic> listdata3 = response['data'];
        deliveryphone= listdata3["delivery_phone"];
        deliveryname= listdata3["delivery_name"];
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }
  @override
  getPrice(itemsModel){
        if(itemsModel.itemsDescount! >0){
          return  itemsModel.itemsPrice! - itemsModel.itemsPrice! *itemsModel.itemsDescount! /100;
        }else {
          return  itemsModel.itemsPrice!;
        }
  }
}