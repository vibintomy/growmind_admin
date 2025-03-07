import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:growmind_admin/features/navigation/presentaion/pages/tab_bar_pages.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final String adminId = 'vibin';
  final String password = '12345';
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 600,
          width: 600,
        
          child: Form(
            key: formKey,
            child: Column(
              children: [
             const   Text(
                  'Admin Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(height: 300, child: Image.asset("assets/50426.jpg")),
              const    SizedBox(height: 20,),
                TextFormField(
                    controller: idController,
                    decoration:const InputDecoration(
                      hintText: 'Admin Id',
                      border: OutlineInputBorder()
                    
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Add the specific id';
                      }
                      if (value != adminId) {
                        return 'You id is incorrect';
                      }
                      
                    }),
                 const   SizedBox(height: 20,),
                TextFormField(
                  controller: passwordController,
                   decoration:const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder()
                    
                    ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Give the correct password';
                    }
                    if (value != password) {
                      return 'Your password is incorrect';
                    }
                  },
                ),
                const  SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 239, 13, 88),
                    
                  ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (idController.text == adminId &&
                            passwordController.text == password) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TabBarPagesAdmin()));
                        }
                      }
                    },
                    child: const Text('Next',style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
