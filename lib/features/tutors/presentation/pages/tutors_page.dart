import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/core/utils/constants.dart';
import 'package:growmind_admin/features/tutors/presentation/bloc/tutor_bloc.dart';
import 'package:growmind_admin/features/tutors/presentation/bloc/tutor_event.dart';
import 'package:growmind_admin/features/tutors/presentation/bloc/tutor_state.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorsPage extends StatelessWidget {
  const TutorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tutorBloc = BlocProvider.of<TutorBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppHeight().kheight1,
              Center(
                child: Container(
                  height: 150,
                  width: 500,
                  decoration: const BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            spreadRadius: 5)
                      ]),
                  child:const Stack(
                    children: [                     
                      Center(
                        child: Text(
                          'Tutor Details',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppHeight().kheight1,
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              AppHeight().kheight1,
              const Text(
                'Provider Request',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder()),
                onPressed: () {
                  tutorBloc.add(FetchTutorEvent());
                },
                child: const Text('Load tutor request'),
              ),
              AppHeight().kheight1,
              Expanded(child:
                  BlocBuilder<TutorBloc, TutorState>(builder: (context, state) {
                if (state is TutorLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TutorLoaded) {
                  return ListView.builder(
                      itemCount: state.tutors.length,
                      itemBuilder: (context, index) {
                        final tutor = state.tutors[index];
                        return Card(
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.person),
                                  Text(' Name : ${tutor.name}'),
                                  Text(' Profession : ${tutor.profession}'),
                                  IconButton(
                                      onPressed: () async {
                                        if (await canLaunchUrl(
                                            Uri.parse(tutor.pdfUrl))) {
                                          await launchUrl(
                                              Uri.parse(tutor.pdfUrl),
                                              mode: LaunchMode
                                                  .externalApplication);
                                        }
                                      },
                                      icon: const Icon(Icons.picture_as_pdf)),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              shape:
                                                  const RoundedRectangleBorder()),
                                          onPressed: () async {
                                            final userDocValues =
                                                FirebaseFirestore.instance
                                                    .collection('kyc')
                                                    .doc(tutor.id);

                                            await userDocValues
                                                .update({'status': 'Accepted'});
                                                     tutorBloc.add(RemoveTutorEvent(tutor.id));
                                          },
                                          child: const Text(
                                            'Accept',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      AppWidth().kwidth,
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape:
                                                  const RoundedRectangleBorder(),
                                              backgroundColor: Colors.red),
                                          onPressed: () async {
                                            final tutorDocRef =
                                                FirebaseFirestore.instance
                                                    .collection('kyc')
                                                    .doc(tutor.id);
                                            await tutorDocRef
                                                .update({'status': 'rejected'});
                                            tutorBloc.add(RemoveTutorEvent(tutor.id));
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Tutor Kyc has been blocked')));
                                          },
                                          child: const Text(
                                            'Block',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else if (state is TutorError) {
                  return Center(
                    child: Text(
                      '${state.error}',
                      style:const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const Center(
                  child: Text('No tutor available'),
                );
              })),
             
            
            ],

          ),
          
        ),
      ),
    );
  }
}
