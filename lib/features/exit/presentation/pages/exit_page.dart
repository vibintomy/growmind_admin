import 'package:flutter/material.dart';

class ExitPage extends StatelessWidget {
  const ExitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [BoxShadow(
                  offset: Offset(0, 3),
                  color: Colors.grey,
                  blurRadius: 3,
                  spreadRadius: 0
                )],
                color: Colors.white
              ),
              height: 100,
              width: 400,
              child:const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.exit_to_app,size: 70,color: Colors.red,),
                      Text('Exit to the Login Page',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,),)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
