import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/core/utils/constants.dart';
import 'package:growmind_admin/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/category_bloc/category_event.dart';
import 'package:growmind_admin/features/category/presentation/bloc/category_bloc/category_state.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_category_bloc/fetch_category_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_category_bloc/fetch_category_event.dart';
import 'package:growmind_admin/features/category/presentation/widgets/displayCourse_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String? selectFileName;
  Uint8List? fileBytes;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        selectFileName = file.name;
        fileBytes = file.bytes;
      });
    } else {
      setState(() {
        selectFileName = null;
        fileBytes = null;
      });
    }
  }

  final TextEditingController categoryController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchCategoryBloc>().add(GetCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    final fetchCategories = BlocProvider.of<FetchCategoryBloc>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                width: 500,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(215, 159, 251, 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 3),
                                        blurRadius: 5,
                                        spreadRadius: 5,
                                      )
                                    ]),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Create Course',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'view and list all courses',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppHeight().kheight1,
                        const Divider(
                          color: Color.fromARGB(255, 202, 200, 200),
                          thickness: 2,
                        ),
                        const Text(
                          'General Courses',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        AppHeight().kheight1,
                        Container(
                          height: 200,
                          width: 1000,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 233, 240, 246),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    spreadRadius: 5,
                                    offset: Offset(0, 3))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Add General course',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                AppHeight().kheight1,
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 400,
                                      color: Colors.white,
                                      child: TextFormField(
                                        controller: categoryController,
                                        decoration: const InputDecoration(
                                            hintText: 'Add Course Name',
                                            hoverColor: Colors.red,
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                    AppWidth().kwidth1,
                                    Container(
                                      height: 50,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Color.fromARGB(
                                              255, 189, 221, 245)),
                                      child: GestureDetector(
                                        onTap: pickFile,
                                        child: const Center(
                                            child: Text(
                                          'Choose File',
                                          style: TextStyle(color: Colors.blue),
                                        )),
                                      ),
                                    ),
                                    AppWidth().kwidth1,
                                    Container(
                                        height: 50,
                                        width: 250,
                                        color: Colors.white,
                                        child: Center(
                                            child: Text(
                                                selectFileName.toString()))),
                                    AppWidth().kwidth1,
                                    Container(
                                        height: 50,
                                        width: 100,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          color: Colors.blue,
                                        ),
                                        child: const Center(
                                            child: Text(
                                          'ADD',
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                  ],
                                ),
                                AppHeight().kheight1,
                                BlocConsumer<CategoryBloc, CategoryState>(
                                  listener: (context, state) {
                                    if (state is CategorySucess) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              elevation: 0,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor:
                                                  Colors.transparent,
                                              content: Text(
                                                  'successfully added the data')));
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is CategorySubmitting) {
                                      return const CircularProgressIndicator();
                                    }
                                    return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            minimumSize: const Size(350, 50)),
                                        onPressed: () {
                                          if (formkey.currentState!
                                                  .validate() &&
                                              selectFileName != null &&
                                              categoryController
                                                  .text.isNotEmpty) {
                                            context.read<CategoryBloc>().add(
                                                UploadImageEvent(fileBytes));

                                            context
                                                .read<CategoryBloc>()
                                                .stream
                                                .listen((state) {
                                              if (state is ImageUploaded) {
                                                // ignore: use_build_context_synchronously
                                                context
                                                    .read<CategoryBloc>()
                                                    .add(SubmitCategoryEvent(
                                                        category:
                                                            categoryController
                                                                .text,
                                                        imageUrl:
                                                            state.imageUrl));
                                                fetchCategories
                                                    .add(GetCategoryEvent());
                                              } else if (state
                                                  is CategorySucess) {
                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Category submitted successfully')),
                                                );
                                              } else if (state
                                                  is CategoryError) {
                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content:
                                                          Text(state.message)),
                                                );
                                              }
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'please fill the fields to attach the document')));
                                          }
                                        },
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(color: Colors.white),
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        AppHeight().kheight1,
                        ElevatedButton(
                            onPressed: () {
                              fetchCategories.add(GetCategoryEvent());
                            },
                            child: const Text('Refresh')),
                        displayCourse(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
