import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/features/home/domain/entities/admin_entites.dart';
import 'package:growmind_admin/features/home/presentation/bloc/admin_bloc/admin_bloc.dart';
import 'package:growmind_admin/features/home/presentation/bloc/admin_bloc/admin_event.dart';
import 'package:growmind_admin/features/home/presentation/bloc/admin_bloc/admin_state.dart';
import 'package:growmind_admin/features/home/presentation/widget/animated_gradient_background.dart';
import 'package:growmind_admin/features/home/presentation/widget/line_chart_widget.dart';
import 'package:growmind_admin/features/home/presentation/widget/syncfusion_flutter_charts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AdminBloc>().add(GetAdminEvent());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
        const    Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome back Admin,\n Glad to see you',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Row(
              children: [
                BlocBuilder<AdminBloc, AdminState>(builder: (context, state) {
                  if (state is AdminLoaded) {
                    final AdminEntities entities = state.adminEntities;
                    return Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 250,
                        width: 700,
                        child: LineChartGraphWidget(
                          statsData: entities.course,
                          metricType: entities.totalRevenue.toString(),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('no data found'),
                    );
                  }
                }),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  height: 300,
                  width: 400,
                  child: const AnimatedGradientBackground(),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text('Top selling courses',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          
                BlocBuilder<AdminBloc, AdminState>(builder: (context, state) {
                  if (state is AdminLoaded) {
                
                    final AdminEntities entities = state.adminEntities;
                    return Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 250,
                        width: 500,
                        child: SyncfusionRadialChart(adminEntities: entities)
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('no data found'),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
