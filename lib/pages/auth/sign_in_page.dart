import 'package:dash/base/custom_loader.dart';
import 'package:dash/base/show_custom_snackbar.dart';
import 'package:dash/controllers/auth_controller.dart';
import 'package:dash/pages/auth/sign_up_page.dart';
import 'package:dash/routes/route_helper.dart';
import 'package:dash/utils/colors.dart';
import 'package:dash/utils/dimensions.dart';
import 'package:dash/widgets/app_text_field.dart';
import 'package:dash/widgets/bit_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (email.isEmpty) {
        showCustomSnackBar("Type Your Email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type a valid email address", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type Your Password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six chracters ",
            title: "Password");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (controller) {
        return !controller.isLoading
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
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(left: Dimensions.width20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello",
                            style: TextStyle(
                              fontSize: Dimensions.font20 * 5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Feel free to feel anything",
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: Dimensions.font20),
                            ),
                          ),
                        ],
                      ),
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
                    Row(
                      children: [
                        Expanded(child: Container()),
                        RichText(
                          text: TextSpan(
                            text: "Have an account already?",
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: Dimensions.font20),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width20,
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        _login(controller);
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
                            text: "Sign In",
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
                          text: "Don't have an account! ",
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: Dimensions.font20),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(() => const SignUpPage(),
                                    transition: Transition.fade),
                              text: " Create",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font20),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.02,
                    ),
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }
}
