import 'package:e_commerce/authentication/login_screen/login_screen_controller.dart';
import 'package:e_commerce/const/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    LoginScreenController controller = Get.find();

    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
          child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: size.height / 7,
                  width: size.width / 3,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(230, 233, 250, 1),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(1000))),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: size.width / 12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 22,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Verify your\n Phone Number\n",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width / 12,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: "Enter OTP",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: size.width / 22,
                              fontWeight: FontWeight.bold))
                    ]),
              ),
              SizedBox(
                height: size.height / 15,
              ),
              SizedBox(
                height: size.height / 18,
                width: size.width / 1.05,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: controller.otp,
                  onChanged: (val) {},
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      fieldHeight: size.height / 18,
                      fieldWidth: size.width / 8),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: size.height / 10,
              ),
              CustomButtton(
                  text: "Submit",
                  function: () {
                    controller.signInwithPhoneNumber();
                  },
                  buttonWidth: 2.5)
            ]),
          ),
        ),
      )),
    );
  }
}
