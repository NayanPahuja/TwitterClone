import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import '../../../common/loading_page.dart';
import 'login_view.dart';
import '../../../common/common.dart';
import '../../../constants/constants.dart';
import '../../../theme/pallete.dart';
import '../widgets/auth_field.dart';


class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {

    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void onSignUp(){
    //call controller
    final res = ref.read(authControllerProvider.notifier).signUp(
        email: emailController.text,
        password: passwordController.text,
        context: context);

  }
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isLoading ? const Loader() : Center(
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
                    child: smallButton(onTap: onSignUp, label: 'Done', backgroundColor: Pallete.whiteColor, fontColor: Pallete.backgroundColor,)),
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
