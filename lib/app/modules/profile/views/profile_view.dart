import 'package:cgp/app/modules/addOrUpdateAddress/controllers/add_or_update_address_controller.dart';
import 'package:cgp/app/modules/profile/views/single_default_address_card.dart';
import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/common_widgets/app_button.dart';
import 'package:cgp/common_widgets/custom_app_bar.dart';
import 'package:cgp/common_widgets/custom_circle_avatar.dart';
import 'package:cgp/common_widgets/custom_loading_screen.dart';
import 'package:cgp/common_widgets/custom_title.dart';
import 'package:cgp/common_widgets/empty_screen.dart';
import 'package:cgp/common_widgets/my_drawer.dart';
import 'package:cgp/constraints/app_colors.dart';
import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/body_text.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:cgp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Stack(
          children: [
            Scaffold(
              key: _scaffoldKey,
              appBar: CustomAppBar(
                minimal: false,
                scaffoldKey: _scaffoldKey,
              ),
              drawer: MyDrawer(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                      profileSection(),
                      SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                      /*defaultAddressSection(),
                      SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                      idVerificationSection(),
                      SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),*/
                    //  paymentMethodSection()
                    ],
                  ),
                ),
              ),
            ),
            if (controller.isLoading.value) const LoadingScreen()
          ],
        ),
      ),
    );
  }

  Widget profileSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CustomCircleAvatar(
              width: 80,
              height: 80,
              image: controller.customer.value.profileImageUrl ?? "",
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: AppDimensions.widgetPadding.h,
            ),
            InkWell(
              onTap: () {},
              child: const BodyText(
                text: "Change Picture",
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
        SizedBox(
          width: AppDimensions.sectionPadding.w,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText(
                text: "${controller.customer.value.firstName ?? ""}"
                    " ${controller.customer.value.lastName ?? ""}",
                size: 20,
                maxLine: 2,
              ),
              SizedBox(
                height: AppDimensions.widgetPadding.h,
              ),
              Row(
                children: [
                  const HeaderText(
                    text: "Customer ID:",
                    size: 12,
                  ),
                  SizedBox(
                    width: AppDimensions.contentPadding.w,
                  ),
                  Expanded(
                    child: BodyText(
                        text: (controller.customer.value.userId ?? 0).toString(),align: TextAlign.start,),
                  )
                ],
              ),
              Row(
                children: [
                  const HeaderText(
                    text: "Email:",
                    size: 12,
                  ),
                  SizedBox(
                    width: AppDimensions.contentPadding.w,
                  ),
                  Expanded(child: BodyText(text: controller.customer.value.email ?? "N/A",align: TextAlign.start,),),
                ],
              ),
              Row(
                children: [
                  const HeaderText(
                    text: "Phone:",
                    size: 12,
                  ),
                  SizedBox(
                    width: AppDimensions.contentPadding.w,
                  ),
                  BodyText(text: controller.customer.value.phone ?? "N/A"),
                ],
              ),
              Row(
                children: [
                  const HeaderText(
                    text: "Gender:",
                    size: 12,
                  ),
                  SizedBox(
                    width: AppDimensions.contentPadding.w,
                  ),
                  BodyText(text: controller.customer.value.gender ?? "N/A")
                ],
              ),
              Row(
                children: [
                  const HeaderText(
                    text: "Age:",
                    size: 12,
                  ),
                  SizedBox(
                    width: AppDimensions.contentPadding.w,
                  ),
                  (controller.customer.value.dateOfBirth != null)
                      ? BodyText(
                          text: calculateAge(
                                  controller.customer.value.dateOfBirth)
                              .toString(),
                        )
                      : const BodyText(text: "N/A"),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed(Routes.EDIT_PROFILE);
          },
          icon: Image.asset(
            AppImagePath.editIcon,
            scale: 2,
          ),
        ),
      ],
    );
  }

  Widget defaultAddressSection() {
    return Column(
      children: [
        const CustomTitle(title: "Default Addresses "),
        (controller.defaultAddresses.isNotEmpty)
            ? ListView.separated(
                itemCount: controller.defaultAddresses.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (buildContext, index) {
                  return SingleDefaultAddressCard(
                    address: controller.defaultAddresses[index],
                    onTap: () async {
                      Get.put(AddOrUpdateAddressController());
                      Get.find<AddOrUpdateAddressController>()
                          .addressesModel
                          .value = controller.addressesModel.value;
                      Get.find<AddOrUpdateAddressController>()
                              .selectedAddressType
                              .value =
                          controller.defaultAddresses[index].addressType ?? "";
                      Get.find<AddOrUpdateAddressController>()
                          .getMySelectedAddress();
                      Get.toNamed(Routes.ADD_OR_UPDATE_ADDRESS);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              )
            : EmptyScreen(
                title: "You have not added any address yet!",
                scaleFactor: 2,
                button: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.verticalPadding.h,
                  ),
                  child: AppButton(
                    text: "Add New Address",
                    onTap: () {},
                    bgColor: AppColors.primaryColor,
                  ),
                ),
              ),
      ],
    );
  }

  Widget idVerificationSection() {
    return Column(
      children: [
        const Divider(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderText(text: "ID Verifications"),
            BodyText(
              text: "Not Verified",
              color: AppColors.primaryColor,
            )
          ],
        ),
        const Divider(),
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        ),
        const Row(
          children: [
            HeaderText(text: "Verify with your NID"),
            Icon(Icons.expand_more_outlined)
          ],
        ),
        const Row(
          children: [
            HeaderText(text: "Verify with your Passport"),
            Icon(Icons.expand_more_outlined)
          ],
        ),
      ],
    );
  }

  Widget paymentMethodSection() {
    return Column(
      children: [
        const Divider(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderText(text: "Payment Method"),
            BodyText(
              text: "Not Added",
              color: AppColors.primaryColor,
            )
          ],
        ),
        Divider(),
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BodyText(
              text: "Add an Account or Card",
              size: 14,
              color: AppColors.secondaryColor,
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(AppImagePath.arrowRightCircle),
            )
          ],
        ),
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        ),
      ],
    );
  }
}
