import 'package:dash/base/custom_loader.dart';
import 'package:dash/base/show_custom_snackbar.dart';
import 'package:dash/controllers/auth_controller.dart';
import 'package:dash/models/sign_up_body_model.dart';
import 'package:dash/utils/colors.dart';
import 'package:dash/utils/dimensions.dart';
import 'package:dash/widgets/app_text_field.dart';
import 'package:dash/widgets/bit_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    void _registeration(AuthController authController) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      if (name.isEmpty) {
        showCustomSnackBar("Type Your Name", title: "Name");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type Your Email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type a valid email address", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type Your Password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six chracters ",
            title: "Password");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type Your Phone", title: "Phone");
      } else {
        showCustomSnackBar("All Went Well",
            title: "Perfect", color: AppColors.mainColor);
        SignUpBody signUpBody = SignUpBody(
          email: email,
          name: name,
          password: password,
          phone: phone,
        );
        authController.registeration(signUpBody).then((status) {
          if (status.isSuccess) {
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    var signUpImages = [
      'assets/img/twitter.png',
      'assets/img/facebook.png',
      'assets/img/google.png'
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.height30),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: Dimensions.radius20 * 4,
                            backgroundImage: const NetworkImage(
                                'https://img.freepik.com/premium-vector/good-food-logo-template_79169-17.jpg'),
                          ),
                        ),
                      ),
                      AppTextField(
                        textController: nameController,
                        hintText: "Name",
                        icon: Icons.person_pin_rounded,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                        textController: emailController,
                        hintText: "Email",
                        icon: Icons.email,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                          obsecure: true,
                          textController: passwordController,
                          hintText: "Password",
                          icon: Icons.lock),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                          textController: phoneController,
                          hintText: "Phone",
                          icon: Icons.phone),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _registeration(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              text: "Sign Up",
                              color: Colors.white,
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: "Have an account already?",
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: Dimensions.font20),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.02,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Sign up using one of the following methods",
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: Dimensions.font26 / 2),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.02,
                      ),
                      Wrap(
                          children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: Dimensions.radius30,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(signUpImages[index]),
                          ),
                        ),
                      ))
                    ],
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
