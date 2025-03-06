import 'package:flutter/material.dart';
import 'package:growmind_admin/features/home/presentation/widget/animated_gradient_background.dart';
import 'package:growmind_admin/features/home/presentation/widget/line_chart_widget.dart';
import 'package:growmind_admin/features/home/presentation/widget/neo_digital_screen.dart';
import 'package:growmind_admin/features/home/presentation/widget/syncfusion_flutter_charts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('Welcome back Admin,\n Glad to see you',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: NeoDigitalScreen(),
                  )
              ],
            ),
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 250,
                  width: 700,
                child: LineChartGraphWidget(),
                ),
              ),
              SizedBox(width: 20,),
              SizedBox(
                height: 300,
                width: 400,
                child: AnimatedGradientBackground(),
              )
            ],
          ),
          SizedBox(height: 10,),
          
          SizedBox(
            height: 250,
            width: 500,
            child: SyncfusionRadicalChart(),
          )
            
          ],
        ),
      ),
    );
  }
}