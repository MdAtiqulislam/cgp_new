import 'package:cgp/app/modules/support/models/issueListModel.dart';
import 'package:cgp/app/modules/support/models/issue_status_list_model.dart';
import 'package:cgp/common_widgets/custom_snackbar.dart';
import 'package:cgp/models/customer_model.dart';
import 'package:cgp/services/api_endpoints.dart';
import 'package:cgp/services/local_services.dart';
import 'package:cgp/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  var isLoading=false.obs;
  var issueSubjectListModel=IssueSubjectListModel().obs;
  var issueListModel=IssueListModel().obs;

  var customer=CustomerModel().obs;

  var selectedStatus=SingleIssueSubjectModel().obs;

  var descriptionController=TextEditingController();

  @override
  void onInit() async{
    super.onInit();
    await getUserData();
    await fetchIssueList();
    await fetchIssueSubjectList();
  }

  Future<void> addSupport() async{
    isLoading.value=true;
    var link="${APIEndPoints.baseUrlMessaging}${APIEndPoints.createSupportEndPoint}";
    var body={
      "issued_by_id":customer.value.id,
      "issued_by_type_id":"24",
      "subject":selectedStatus.value.name,
      "description":descriptionController.text,
    };
    try {
      var response=await RemoteServices.chatPostRequest(url: link,body: body);
      if(response!=null){
        CustomSnackBar(
          isSuccess: true,
          msg: response["message"]
        ).showSnackBar();
        await fetchIssueList();
      }
    } finally {
      isLoading.value=false;
    }

  }

  Future<void> fetchIssueList() async {
    isLoading.value=true;
    var link="${APIEndPoints.baseUrlMessaging}${APIEndPoints.getSupportList}";
    var parameter={
      "issued_by_id":customer.value.id.toString(),
      "issued_by_type_id":"24"
    };
    try {
      var response=await RemoteServices.chatGetRequest(link: link,parameters: parameter);
      if(response!=null){
        issueListModel.value=IssueListModel.fromJson(response);
      }
    } finally {
      isLoading.value=false;
    }
  }

 Future<void> getUserData() async{
    customer.value=await LocalServices.getUser()??CustomerModel();
 }

 Future<void> fetchIssueSubjectList()async {
    isLoading.value=true;
   var link="${APIEndPoints.baseUrlMessaging}${APIEndPoints.getIssueSubjectList}";
   var parameters={
     "user_type":"customer"
   };

   try {
     var response=await RemoteServices.chatGetRequest(link: link,parameters: parameters);
     if(response!=null){
       issueSubjectListModel.value=IssueSubjectListModel.fromJson(response);
       selectedStatus.value=issueSubjectListModel.value.data?.first??SingleIssueSubjectModel();
     }
   } finally {
     isLoading.value=false;
   }

 }
}
