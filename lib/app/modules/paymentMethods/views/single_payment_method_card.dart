import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/constraints/dimensions.dart';
import 'package:cgp/constraints/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SinglePaymentMethodCard extends StatelessWidget {
  final String cardBrand;
  final String last4Digits;
  final String expMonth;
  final String expYear;
  final bool isDefault;
  final VoidCallback onDelete;
  final VoidCallback makeDefault;

  const SinglePaymentMethodCard({
    super.key,
    required this.cardBrand,
    required this.last4Digits,
    required this.expMonth,
    required this.expYear,
    required this.isDefault,
    required this.onDelete,
    required this.makeDefault,
  });

  @override
  Widget build(BuildContext context) {
    String cardTypeImage;
    switch (cardBrand.toLowerCase()) {
      case 'visa':
        cardTypeImage = AppImagePath.visaCard; // Adjust path accordingly
        break;
      case 'mastercard':
        cardTypeImage = AppImagePath.masterCard; // Adjust path accordingly
        break;
      default:
        cardTypeImage = AppImagePath.creditCard; // Adjust path accordingly
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: AppDimensions.contentPadding.h),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: isDefault
            ? LinearGradient(
                colors: [Colors.green, Colors.greenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImagePath.chipIcon, // Adjust path accordingly
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: AppDimensions.sectionPadding.w),
                  Image.asset(
                    AppImagePath.contactLessIcon, // Adjust path accordingly
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    cardTypeImage,
                    width: 60.0,
                    height: 40.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppDimensions.widgetPadding.h),
          Text(
            '**** **** **** $last4Digits',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppDimensions.widgetPadding.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Expiry Date',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    '${expMonth.padLeft(2, '0')}/$expYear',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Card Holder',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'N/A', // Assuming card holder name is not available
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isDefault
                  ? HeaderText(
                      text: "Default",
                      color: Colors.yellowAccent,
                    )
                  : MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: makeDefault,
                    child: HeaderText(
                      text: "Make Default",
                      color:Colors.white,
                    ),
                  ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
