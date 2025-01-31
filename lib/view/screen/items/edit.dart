import 'package:adminpharmacy/core/class/handlingdataview.dart';
import 'package:adminpharmacy/core/constant/color.dart';
import 'package:adminpharmacy/core/functions/validinput.dart';
import 'package:adminpharmacy/core/shared/customtextformglobal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/items/edit_controller.dart';
import '../../../core/shared/custombutton.dart';
import '../../../core/shared/customdropdownsearch.dart';
class ItemsEdit extends StatelessWidget {
  const ItemsEdit({super.key});

  @override
  Widget build(BuildContext context) {
    ItemEditController controlle =Get.put(ItemEditController()) ;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Products"),
      ),
      body: GetBuilder<ItemEditController>(builder: (controller)=> HandlingDataView(
          statusRequest: controller.statusRequest!, widget: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: controller.formState ,
          child: ListView(
            children: [
              CustomTextFormGlobal(
                  hinttext: "Add Product Name",
                  labeltext: "Product name",
                  iconData: Icons.category,
                  mycontroller: controlle.name,
                  valid: (val){
                    return validInput(val!, 1, 200, "");
                  },
                  isNumber: false),
              CustomTextFormGlobal(
                  hinttext:  "product name (Arabic)",
                  labeltext: "product name (Arabic)",
                  iconData: Icons.category,
                  mycontroller:  controlle.namear,
                  valid:  (val){
                    return validInput(val!, 1, 200, "");
                  },
                  isNumber: false),
              CustomTextFormGlobal(
                  hinttext: "Add Description",
                  labeltext: "Description",
                  iconData: Icons.category,
                  mycontroller: controlle.desc,
                  valid: (val){
                    return validInput(val!, 1, 250, "");
                  },
                  isNumber: false),
              CustomTextFormGlobal(
                  hinttext:  "Description (Arabic)",
                  labeltext: "Description (Arabic)",
                  iconData: Icons.category,
                  mycontroller:  controlle.desc_ar,
                  valid:  (val){
                    return validInput(val!, 1, 250, "");
                  },
                  isNumber: false),
              CustomTextFormGlobal(
                  hinttext: "Add Count",
                  labeltext: "Count",
                  iconData: Icons.category,
                  mycontroller: controlle.count,
                  valid: (val){
                    return validInput(val!, 1, 100, "");
                  },
                  isNumber: true),
              CustomTextFormGlobal(
                  hinttext: "Quantity in box",
                  labeltext: "Quantity",
                  iconData: Icons.category,
                  mycontroller: controlle.quantityinboxnt,
                  valid: (val){
                    return validInput(val!, 1, 100, "");
                  },
                  isNumber: true),
              CustomTextFormGlobal(
                  hinttext:  "price",
                  labeltext: "price  for Box",
                  iconData: Icons.category,
                  mycontroller:  controlle.pricrofbox,
                  valid:  (val){
                    return validInput(val!, 1, 100, "");
                  },
                  isNumber: true),
              CustomTextFormGlobal(
                  hinttext:  "price",
                  labeltext: "price  for Box Merchant",
                  iconData: Icons.category,
                  mycontroller:  controlle.priceForMerchant,
                  valid:  (val){
                    return validInput(val!, 1, 100, "");
                  },
                  isNumber: true),
              CustomTextFormGlobal(
                  hinttext:  "price",
                  labeltext: "price  for Box Mosque",
                  iconData: Icons.category,
                  mycontroller:  controlle.priceForMosque,
                  valid:  (val){
                    return validInput(val!, 1, 100, "");
                  },
                  isNumber: true),
              CustomTextFormGlobal(
                  hinttext:  "price",
                  labeltext: "price",
                  iconData: Icons.category,
                  mycontroller:  controlle.price,
                  valid:  (val){
                    return validInput(val!, 1, 100, "");
                  },
                  isNumber: true),
              CustomTextFormGlobal(
                  hinttext:  "price For Merchant",
                  labeltext: "price For Merchant",
                  iconData: Icons.category,
                  mycontroller:  controlle.priceForMerchant,
                  valid:  (val){
                    return validInput(val!, 1, 100, "");
                  },
                  isNumber: true),
              CustomTextFormGlobal(
                  hinttext:  "price For Mosque",
                  labeltext: "price For Mosque",
                  iconData: Icons.category,
                  mycontroller:  controlle.priceForMosque,
                  valid:  (val){
                    return validInput(val!, 1, 100, "");
                  },
                  isNumber: true),
              CustomTextFormGlobal(
                  hinttext:  "Discount",
                  labeltext: "Discount",
                  iconData: Icons.category,
                  mycontroller:  controlle.discount,
                  valid:  (val){
                    return validInput(val!, 1, 30, "");
                  },
                  isNumber: true),
              CustomTextFormGlobal(
                  hinttext:  "Discount For Merchant",
                  labeltext: "Discount For Merchant",
                  iconData: Icons.category,
                  mycontroller:  controlle.discountForMerchant,
                  valid:  (val){
                    return validInput(val!, 1, 30, "");
                  },
                  isNumber: true),
              CustomTextFormGlobal(
                  hinttext:  "Discount For Mosque",
                  labeltext: "Discount For Mosque",
                  iconData: Icons.category,
                  mycontroller:  controlle.discountForMosque,
                  valid:  (val){
                    return validInput(val!, 1, 30, "");
                  },
                  isNumber: true),
              CustomDropDownSearch(
                title: "Choose Category",
                listdata:controller.dropdownlist,
                dropdownSelecteName: controller.catname,
                dropdownSelecteID: controller.catid,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  color: AppColor.primaryColor,
                  textColor: AppColor.secondColor,
                  onPressed: (){
                    controlle.showOptionImage();
                  },child:
                Text("Choose product Image",style: TextStyle(color: Colors.white),),),
              ),
              if(controlle.file !=null)
                Image.file(controlle.file!,
                  height: 150,
                  width: 250,
                ),
              SizedBox(height: 10,),
              RadioListTile(
                title: Text("active"),
                  value: "1", groupValue: controller.active, onChanged:(val){
                controller.changeStatusActive(val);
              }),
              RadioListTile(
                  title: Text("hiden"),
                  value: "0", groupValue: controller.active, onChanged:(val){
                controller.changeStatusActive(val);
              } ),
              SizedBox(height: 10,),

              CustomButton(text: "Edit",
                onPressed: (){
                  controlle.editData();
                },
              )
            ],
          ),
        ),
      ))),
    );
  }
}
