import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'login_view.dart';
import '../../../common/common.dart';
import '../../../constants/constants.dart';
import '../../../theme/pallete.dart';
import '../widgets/auth_field.dart';


class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                //login textfield
                AuthField(controller: emailController, hintText: 'Email',),
                const SizedBox(height: 25,),
                //password textfield
                AuthField(controller:passwordController, hintText: 'Password',),
                const SizedBox(height: 40,),
                //button
                Align(
                    alignment: Alignment.topRight,
                    child: smallButton(onTap: (){}, label: 'Done', backgroundColor: Pallete.whiteColor, fontColor: Pallete.backgroundColor,)),
                const SizedBox(height: 40,),

                //textspan
                RichText(text: TextSpan(
                    text: 'Already have an account?',
                    style: const TextStyle(color: Pallete.greyColor, fontSize: 16),
                    children: [
                      TextSpan(
                          text: ' Login',
                          style: const TextStyle(
                              color: Pallete.blueColor,
                              fontSize: 16
                          ),
                        recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView()));
                        }
                      )
                    ]
                ),
                )
              ],

            ),

          ),
        ),
      ),
    );
  }
}
