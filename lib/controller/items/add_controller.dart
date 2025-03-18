import 'dart:io';
import 'package:adminpharmacy/controller/items/view_controller.dart';
import 'package:adminpharmacy/core/constant/routes.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/functions/uploadfile.dart';
import '../../data/datasource/remote/categories_data.dart';
import '../../data/datasource/remote/items_data.dart';
import '../../data/model/categoriesmodel.dart';

class  ItemsAddController extends GetxController{

  ItemsData  itemsData = ItemsData(Get.find());
  List <SelectedListItem> dropdownlist=[];
  GlobalKey<FormState> formState = GlobalKey<FormState>();
   StatusRequest? statusRequest = StatusRequest.none ;
  late TextEditingController dropdownname;
  late TextEditingController dropdownid;
  late TextEditingController name;
  late TextEditingController namear;
  late TextEditingController desc;
  late TextEditingController desc_ar;
  late TextEditingController count;
  late TextEditingController quantityinboxnt;
  late TextEditingController pricrofbox;
  late TextEditingController price;
  late TextEditingController discount;
  TextEditingController?  catname;
  TextEditingController?  catid;
  File? file;

  addData()async{
    if(formState.currentState!.validate()){
      if(file ==null) Get.snackbar("Warning", "Please Choose Image");
    statusRequest=StatusRequest.loading;
    update();
    Map data ={
      "name":name.text,
      "namear":namear.text,
      "desc":desc.text,
      "descar":desc_ar.text,
      "count":count.text,
      "quantityinboxnt":quantityinboxnt.text,
      "pricrofbox":pricrofbox.text,
      "price":price.text,
      "discount":discount.text,
      "datenow":DateTime.now().toString(),
      "catid":catid!.text,
    };
    var response = await itemsData.add(data,file!);
    print("=============== ItemsAddController $response");
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest){
      if(response['status']=="success"){
        Get.offNamed(AppRoute.itemsview);
        ItemsController c =Get.find();
        c.getData();
      }else{
        statusRequest = StatusRequest.failure;
      }
    }
    update();}

  }
  getCategories()async{
    CategoriesData  categorieData = CategoriesData(Get.find());
    statusRequest=StatusRequest.loading;
    var response = await categorieData.get();
    print("=============== CategorieController $response");
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest){
      if(response['status']=="success"){
        List<CategoriesModel> data =[];
        List datalist = response['data'];
        data.addAll(datalist.map((e)=> CategoriesModel.fromJson(e)));
        for(int i =0 ;i< data.length; i++){
          dropdownlist.add(SelectedListItem(name: data[i].categoriesName!, value:data[i].categoriesId.toString() ) );
        }
      }else{
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }


  showOptionImage(){
    showbottommenu(chooseImageCamera,chooseImageGallery);

  }
  chooseImageCamera()async{
    file = await imageUploadCamera();
    update();
  }
  chooseImageGallery()async{
    file = await fileUploadGallery(false);
    update();
  }


  showDropdown(context){
    DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          "Category",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: [SelectedListItem(name:"a"),SelectedListItem(name:"b")],
        onSelected: (List<dynamic> selectedList) {
          SelectedListItem selectedListItem = selectedList[0];
          dropdownname.text = selectedListItem.name;

        },
      ),
    ).showModal(context);
  }

  @override
  void onInit() {
    getCategories();
    name =TextEditingController();
    namear =TextEditingController();
    desc =TextEditingController();
    desc_ar =TextEditingController();
    count =TextEditingController();
    quantityinboxnt =TextEditingController();
    price =TextEditingController();
    pricrofbox =TextEditingController();
    discount =TextEditingController();
    catid =TextEditingController();
    catname =TextEditingController();
    dropdownname = TextEditingController();
    dropdownid =TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    name.dispose();
    namear.dispose();
    desc.dispose();
    desc_ar.dispose();
    count.dispose();
    quantityinboxnt.dispose();
    price.dispose();
    pricrofbox.dispose();
    discount.dispose();
    dropdownname.dispose();
    dropdownid.dispose();
    super.dispose();
  }
}
