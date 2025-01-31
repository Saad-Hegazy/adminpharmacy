import 'package:adminpharmacy/controller/categories/view_controller.dart';
import 'package:adminpharmacy/core/class/handlingdataview.dart';
import 'package:adminpharmacy/core/constant/routes.dart';
import 'package:adminpharmacy/linkapi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';
class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategorieController());
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      appBar: AppBar(
        title: Text("Categories"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.toNamed(AppRoute.categoriesadd);
      },
      child: Icon(Icons.add),
      ),
      body: GetBuilder<CategorieController>(
        builder: ((controller)=>HandlingDataView(
          statusRequest: controller.statusRequest,
            widget:Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: controller.data.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        controller.goToPageEdit(controller.data[index]);
                      },
                      child: Card(
                        child: Row(
                          children: [Expanded(
                        flex:2,
                        child:
                          Container(
                            padding: EdgeInsets.all(4),
                            child: CachedNetworkImage(
                              height: 80,
                              imageUrl: "${AppLink.imagestCategories}/${controller.data[index].categoriesImage}", ),
                          )),
                          Expanded(
                              flex:3,
                              child: ListTile(
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: (){
                                          Get.defaultDialog(
                                              title: "warning",
                                              middleText: "are you sure from deleting this category",
                                              onCancel: (){},
                                              onWillPop:null,
                                              onConfirm:(){
                                                controller.deleteCategory(
                                                    controller.data[index].categoriesId.toString(),
                                                    controller.data[index].categoriesImage!
                                                );
                                                Get.back();
                                              }
                                          );
                                        }, icon: Icon(Icons.delete)),
                             
                                  ],
                                ),
                                subtitle:Text(controller.data[index].categoriesDatetime!),
                                title: Text(controller.data[index].categoriesName!),
                              )
                          )
                          ],
                      
                        ),
                      ),
                    );
                  }
                )),

            )
        )
      ),

    );
  }
}
