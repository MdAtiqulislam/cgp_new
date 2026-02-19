import 'package:cgp/app/modules/addOrUpdateAddress/views/selected_address_section.dart';
import 'package:cgp/common_widgets/custom_expanded_tile.dart';
import 'package:cgp/utils/enams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/cart_page_header.dart';
import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../constraints/dimensions.dart';
import '../controllers/add_or_update_address_controller.dart';
import 'add_or_update_address_form.dart';

class AddOrUpdateAddressView extends GetView<AddOrUpdateAddressController> {

 final GlobalKey<ScaffoldState> scaffoldKey=GlobalKey<ScaffoldState>();
// final GlobalKey<FormState>_formKey=GlobalKey<FormState>();

  AddOrUpdateAddressView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar:  CustomAppBar(
          minimal: false,
          enableBackButton: true,
          scaffoldKey: scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: bottomNavBar(),
        body: Obx(()=>Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CartPageHeader(
                      trailingText: "Location Preferences",
                      image: AppImagePath.colorLocationIcon,
                      title: "My Addresses",
                    ),
                    //   cartInfoSection(),
                    SizedBox(
                      height: AppDimensions.sectionPadding.h,
                    ),

                    CustomExpandedTile(
                      isExpanded: controller.selectedAddressType.value==AddressType.shipping.name, //controller.isExpanded[0],
                      horizontalGap: AppDimensions.contentPadding.w,
                      verticalGap: AppDimensions.contentPadding.h,
                      content:   const SelectedAddressSection(),
                      title: "Shipping Addresses",
                      onExpansionChange: (value){
                       if(!controller.isActiveSelectButton){
                         if(value){
                           controller.selectedAddressType.value=AddressType.shipping.name;
                           controller.getMySelectedAddress();
                         }else{
                           controller.selectedAddressType.value="";
                         }
                       }
                        //controller.isExpanded[0]=value;
                      },
                    ),
                    CustomExpandedTile(
                      isExpanded: controller.selectedAddressType.value==AddressType.billing.name,//controller.isExpanded[1],
                      horizontalGap: AppDimensions.contentPadding.w,
                      verticalGap: AppDimensions.contentPadding.h,
                      content:   const SelectedAddressSection(),
                      title: "Billing Addresses",
                      onExpansionChange: (value){
                        //controller.isExpanded[1]=value;
                        if (!controller.isActiveSelectButton) {
                          if(value){
                            controller.selectedAddressType.value=AddressType.billing.name;
                            controller.getMySelectedAddress();
                          }else{
                            controller.selectedAddressType.value="";
                          }
                        }
                      },
                    ),
                    CustomExpandedTile(
                      isExpanded: controller.selectedAddressType.value==AddressType.pickup.name,//controller.isExpanded[2],
                      horizontalGap: AppDimensions.contentPadding.w,
                      verticalGap: AppDimensions.contentPadding.h,
                      content:   SelectedAddressSection(),
                      title: "Pickup Addresses",
                      onExpansionChange: (value){
                       // controller.isExpanded[2]=value;
                        if (!controller.isActiveSelectButton) {
                          if(value){
                            controller.selectedAddressType.value=AddressType.pickup.name;
                            controller.getMySelectedAddress();
                          }else{
                            controller.selectedAddressType.value="";
                          }
                        }
                      },
                    ),


                    /*  HeaderText(
                      text: "Set Your Location Preferences",
                      size: 12,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: AppDimensions.widgetPadding.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.horizontalPadding.w,
                          vertical: AppDimensions.contentPadding.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius:
                        BorderRadius.circular(AppDimensions.borderRadius.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.map,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(
                            width: AppDimensions.contentPadding.w,
                          ),
                          BodyText(text: "Select from Map")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppDimensions.widgetPadding.h,
                    ),
                    HeaderText(
                      text: "Select From Previous Location",
                      size: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    Divider(),
                    BodyText(
                      text: "You haven't any location Added",
                      size: 12,
                    ),
                    SizedBox(
                      height: AppDimensions.widgetPadding.h,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Get.bottomSheet(
                          isScrollControlled: true,
                          ignoreSafeArea: false,
                          addLocationForm(),
                        );
                      },
                      child: HeaderText(
                        text: "Add New",
                        color: Colors.white,
                      ),
                      color: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    )*/
                  ],
                ),
              ),
            ),
            if (controller.isLoading.value) const LoadingScreen()
          ],
        ),),
      ),
    );
  }

 Widget bottomNavBar() {
   return Container(
     padding: EdgeInsets.symmetric(
         horizontal: AppDimensions.horizontalPadding.w,
         vertical: AppDimensions.contentPadding.h),
     height: 70.h,
     width: Get.width,
     child:!controller.isActiveSelectButton
         ? AppButton(
       bgColor: AppColors.primaryColor,
       showBorder: false,
       text: "Add New Address",
       onTap: () {
         Get.bottomSheet(
           isScrollControlled: true,
           ignoreSafeArea: false,
           AddOrUpdateAddressForm(formType:"Add New"),
         );
       },
     )
         : AppButton(
       bgColor: AppColors.primaryColor,
       showBorder: false,
       text: "Select Address",
       onTap: () {
         controller.selectLocationAndBack();
       },
     ),
   );
 }
/* Widget addLocationForm() {
   return SafeArea(
     child: Container(
       width: Get.width,
       color: Colors.white,
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Container(
             padding: EdgeInsets.symmetric(
                 horizontal: AppDimensions.horizontalPadding.w,
                 vertical: AppDimensions.contentPadding.h),
             width: Get.width,
             color: AppColors.primaryColor,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const HeaderText(
                   text: "Add New Location Manually",
                   color: Colors.white,
                 ),
                 InkWell(
                     onTap: () {
                       Get.back();
                     },
                     child: Image.asset(AppImagePath.cancelIcon))
               ],
             ),
           ),
           Flexible(
             child: SingleChildScrollView(
               child: Padding(
                 padding: EdgeInsets.symmetric(
                     horizontal: AppDimensions.horizontalPadding.w),
                 child: Form(
                   key: _formKey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SizedBox(
                         height: AppDimensions.sectionPadding.h,
                       ),
                       Row(
                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Expanded(
                             child: CustomTextField(
                               levelText: "First Name",
                               hintText: "First Name",
                               isRequired: true,
                               validatorText: "Required",
                               controller: controller.firstNameController,
                             ),
                           ),
                           SizedBox(
                             width: AppDimensions.contentPadding.w,
                           ),
                           Expanded(
                             child: CustomTextField(
                               levelText: "Last Name",
                               hintText: "Last Name",
                               isRequired: true,
                               validatorText: "Required",
                               controller: controller.lastNameController,
                             ),
                           ),
                         ],
                       ),
                       SizedBox(
                         height: AppDimensions.contentPadding.h,
                       ),
                       CustomTextField(
                         levelText: "Phone/ Mobile",
                         hintText: "Phone/ Mobile",
                         isRequired: true,
                         validatorText: "Required",
                         textInputType: TextInputType.phone,
                         controller: controller.phoneController,
                       ),
                       SizedBox(
                         height: AppDimensions.contentPadding.h,
                       ),
                       CustomTextField(
                         levelText: "Country",
                         hintText: "Country",
                         isRequired: true,
                         validatorText: "Required",
                         controller: controller.countryController,
                       ),
                       SizedBox(
                         height: AppDimensions.contentPadding.h,
                       ),
                       Row(
                         children: [
                           Expanded(
                             child: CustomTextField(
                               levelText: "State",
                               hintText: "State",
                               isRequired: true,
                               validatorText: "Required",
                               controller: controller.stateController,
                             ),
                           ),
                           SizedBox(width: AppDimensions.contentPadding.w,),
                           Expanded(
                             child: CustomTextField(
                               levelText: "City/ Province",
                               hintText: "City/ Province",
                               isRequired: true,
                               validatorText: "Required",
                               controller: controller.cityController,
                             ),
                           ),
                         ],
                       ),


                       SizedBox(
                         height: AppDimensions.contentPadding.h,
                       ),
                       Row(
                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Expanded(
                             child: CustomTextField(
                               levelText: "Road",
                               hintText: "Road",
                               isRequired: true,
                               validatorText: "Required",
                               controller: controller.roadController,
                             ),
                           ),
                           SizedBox(
                             width: AppDimensions.contentPadding.w,
                           ),
                           Expanded(
                             child: CustomTextField(
                               levelText: "Block",
                               hintText: "Block",
                               isRequired: true,
                               validatorText: "Required",
                               controller: controller.blockController,
                             ),
                           ),
                         ],
                       ),
                       SizedBox(
                         height: AppDimensions.contentPadding.h,
                       ),
                       Row(
                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Expanded(
                             child: CustomTextField(
                               levelText: "House",
                               hintText: "House",
                               isRequired: true,
                               validatorText: "Required",
                               controller: controller.houseController,
                             ),
                           ),
                           SizedBox(
                             width: AppDimensions.contentPadding.w,
                           ),
                           Expanded(
                             child: CustomTextField(
                               levelText: "Zip",
                               hintText: "Zip",
                               isRequired: true,
                               validatorText: "Required",
                               controller: controller.zipController,
                             ),
                           ),
                         ],
                       ),
                       SizedBox(height: AppDimensions.contentPadding.h,),
                       CustomTextField(
                         levelText: "Address",
                         hintText: "Address",
                         maxLine: 3,
                         minLine: 2,
                         isRequired: true,
                         validatorText: "Required",
                         controller: controller.addressController,
                       ),
                       SizedBox(
                         height: AppDimensions.sectionPadding.h,
                       ),
                       MaterialButton(
                         onPressed: () {
                           if(_formKey.currentState?.validate()??false){
                             controller.saveAddress();
                           }
                         },
                         color: AppColors.primaryColor,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(6.r),
                         ),
                         child: HeaderText(text: "Add Location",color: Colors.white,),
                       ),
                       SizedBox(height: AppDimensions.sectionPadding.h,)
                     ],
                   ),
                 ),
               ),
             ),
           )
         ],
       ),
     ),
   );
 }*/

}
