import 'package:flutter/material.dart';
import 'package:home_services/forget_password/Api/forget_password_api.dart';
import 'package:home_services/forget_password/Screen/forget_password_verification_code_page.dart';


class SendEmail extends StatelessWidget {
  TextEditingController emailController;
  SendEmail({Key? key,required this.emailController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForgetPasswordApi ob = ForgetPasswordApi();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: ob.sendEmailForForgetPassword(emailController),
            builder:(context,AsyncSnapshot<List?> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              } else if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.data!.isEmpty){
                  return ForgetPasswordVerificationCode(
                    email: emailController,
                  );
                } else {
                  return AlertDialog(
                    title: const Text("حدثت مشكلة اثناء الاتصال, الرجاء المحاولة لاحقا"),
                    actions: [
                      ElevatedButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: const Text("تأكيد"))
                    ],
                  );
                }
              } else {
                return AlertDialog(
                  title: const Text("حدثت مشكلة اثناء الاتصال, الرجاء المحاولة لاحقا"),
                  actions: [
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: const Text("تأكيد"))
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
