import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/orders/ontheway_controller.dart';
import '../../../controller/orders/orderscompletedView_controller.dart';
import '../../../core/constant/color.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/routes.dart';
import '../../../data/model/ordersmodel.dart';
class CardOrdersListOnTheWay extends GetView<OnTheWayOrdersController> {
  final OrdersModel listdata;

  const CardOrdersListOnTheWay({Key? key, required this.listdata})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Order Number : #${listdata.ordersId}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  // Text(listdata.ordersDatetime!)
                  Text(
                    DateFormat('dd-MMM-yyyy').format(
                      DateTime.parse(listdata.ordersDatetime!,),
                    ),    style: const TextStyle(
                      color: AppColor.primaryColor,
                      fontSize:12),
                  )
                ],
              ),
              const Divider(),
              Text(
                  "Order Type : ${controller.printOrderType(listdata.ordersType!)}"),
              Text("Order Price : ${listdata.ordersPrice}  ${"215".tr}"),
              Text("Delivery Price : ${listdata.ordersPricedelivery}  ${"215".tr}"),
              Text(
                  "Payment Method : ${controller.printPaymentMethod(listdata.ordersPaymentmethod!)} "),
              Text(
                  "Order Status : ${controller.printOrderStatus(listdata.ordersStatus!)} "),
              const Divider(),

                  Text("Total Price : ${listdata.ordersTotalprice!.toStringAsFixed(2)}  ${"215".tr} ",
                      style: const TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Spacer(),
                  if (listdata.ordersStatus! == 3)
                    MaterialButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.onthewayordersdetails,
                           arguments: {"ordersmodel": listdata});
                      },
                      color: AppColor.primaryColor,
                      textColor: AppColor.secondColor,
                      child: const Text("Details"),
                    ),

                ],
              ),
            ],
          )),
    );
  }
}