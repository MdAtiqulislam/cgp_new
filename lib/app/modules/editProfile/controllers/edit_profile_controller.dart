import 'package:cgp/app/modules/editProfile/models/update_profile_model.dart';
import 'package:cgp/app/modules/profile/controllers/profile_controller.dart';
import 'package:cgp/models/customer_model.dart';
import 'package:cgp/services/local_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../other_controllers/appbar_controller.dart';
import '../../../../other_controllers/my_drawer_controller.dart';
import '../../../../services/api_endpoints.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/utils.dart';

class EditProfileController extends GetxController {


  var isLoading=false.obs;
  var isUpdating=false.obs;
  var customer=CustomerModel().obs;

  var dateOfBirthController=TextEditingController();

  var firstNameController=TextEditingController();
  var lastNameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();

  var genders = ["FEMALE","MALE", "OTHER"];
  var selectedGender = "MALE";

  var filePath="";
  var base64Image = "".obs;

  @override
  void onInit() async{
    super.onInit();
    await getUserData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

Future<void>  getUserData() async{
    await LocalServices.getUser().then((value){
      if(value!=null){
        customer.value=value;
        firstNameController.text=customer.value.firstName??"";
        lastNameController.text=customer.value.lastName??"";
        //phoneController.text=customer.value.phone??"";
        phoneController.text = customer.value.phone?.replaceFirst('04', '') ?? '';
        emailController.text=customer.value.email??"";
        selectedGender =
        ((customer.value.gender ?? "").isEmpty ? "MALE" : customer.value.gender)!;
        dateOfBirthController.text = customer.value.dateOfBirth.toString();

      }
    });
}

  void selectDateOfBirth() async {
    final DateTime? picked = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      context: Get.context!,
    );
    if (picked != null) {
      dateOfBirthController.text = DateFormat("yyyy-MM-dd").format(picked);
    }
  }

  Future<void> selectImage(
      {required ImageSource source, CropStyle? cropStyle}) async {
    picImage(source).then((value) async {
      if (value != null) {
        Get.back();
        await cropImage(filePath: value.path, cropStyle: cropStyle)
            .then((value) async {
          if (value != null) {
            filePath = value.path;
            {
              base64Image.value = await getImageAsBase64(value);
            }
          }
        });
      }
    });
  }


  Future<void> updateUser() async {
    isUpdating.value = true;
    var endPoint = APIEndPoints.updateUser;
    var body = {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "phone": phoneController.text.length==8?"04${phoneController.text}":phoneController.text,
      "email": emailController.text,
      "date_of_birth": dateOfBirthController.text,
      "gender": selectedGender,
    };

    try {
      var response = await RemoteServices.multipartRequest(
          endPoint: endPoint,
          body: body,
          filePath: filePath,
          fieldName: 'profile_image',
          requestType: "PATCH");
      if (response != null) {
        CustomerProfileUpdateModel customerProfileUpdateModel =
        CustomerProfileUpdateModel.fromJson(response);
        await LocalServices()
            .storeUser(customerProfileUpdateModel.data ?? CustomerModel());
        reloadData();
        CustomSnackBar(msg: response["message"], isSuccess: true)
            .showSnackBar();
      } else {
        CustomSnackBar(msg: AppStrings.httpErrorMSG.value, isSuccess: false)
            .showSnackBar();
      }
    } finally {
      isUpdating.value = false;
    }
  }

  void reloadData() {
    base64Image.value = "";
    getUserData();
    Get.put(AppbarController());
    Get.find<AppbarController>().getUserData();
    Get.put(MyDrawerController());
    Get.find<MyDrawerController>().getUserData();
    Get.put(ProfileController());
    Get.find<ProfileController>().getUserData();
  }
}
