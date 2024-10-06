import 'package:cgp/app/modules/categorySearch/controllers/category_search_controller.dart';
import 'package:cgp/app/modules/home/models/home_data_model.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryDropdown extends StatelessWidget {
  final TextEditingController dropdownSearchFieldController;
  final List<Category> data;
  final double? borderRadius;
  final String? hintText;
//  final Function(String)? onChange;
   CategoryDropdown({
    required this.data,
    this.borderRadius,
    required this.dropdownSearchFieldController,
  // this.onChange,
     this.hintText,
    super.key});

  final SuggestionsBoxController suggestionsBoxController=SuggestionsBoxController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius??AppDimensions.borderRadius.r),
          color: AppColors.iconColor
      ),
      child: DropdownMenu<Category>(
        hintText: "Chose Category",

        onSelected: (value){
          dropdownSearchFieldController.text=value?.name??"";
          Get.put(CategorySearchController());
          Get.find<CategorySearchController>().loadData(categoryId: value?.id??"");
          Get.find<CategorySearchController>().dropDownController.text=value?.name??"";
          Get.toNamed(Routes.CATEGORY_SEARCH);
        },
        menuHeight: 300.h,
      //  enableSearch: false,
        trailingIcon: const Icon(Icons.arrow_drop_down_sharp,color: Colors.white,),
        selectedTrailingIcon: const Icon(Icons.arrow_drop_up_sharp,color: Colors.white,),
        width: Get.width-(AppDimensions.horizontalPadding.w*2),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          iconColor: Colors.white,
          contentPadding: EdgeInsets.only(left: AppDimensions.horizontalPadding.w),
          hintStyle: const TextStyle(color: Colors.white)
        ),
        requestFocusOnTap: true,
      ///  enableFilter: true,
        controller: dropdownSearchFieldController,
        dropdownMenuEntries: data.map<DropdownMenuEntry<Category>>(
                (Category data) {
              return DropdownMenuEntry<Category>(
                value: data,
                label: data.name??"",
                enabled: true,
                style: MenuItemButton.styleFrom(
                  //  foregroundColor: color.color,
                ),
              );
            }).toList(),
        textStyle: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w600),

      ),



    );
  }

  List<Category> getSuggestions(String query) {
    List<Category> matches = <Category>[];
    matches.addAll(data);
    matches.retainWhere((s) {
      return ((s.name ?? "").toLowerCase()).contains(query.toLowerCase());
    });
    return matches;

  }
}
