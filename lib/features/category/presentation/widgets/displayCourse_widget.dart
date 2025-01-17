import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_category_bloc/fetch_category_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_category_bloc/fetch_category_state.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_subcategory/fetch_subcategory_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_subcategory/fetch_subcategory_event.dart';
import 'package:growmind_admin/features/category/presentation/bloc/subcategory_bloc/subcategory_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/subcategory_bloc/subcategory_event.dart';
import 'package:growmind_admin/features/category/presentation/bloc/subcategory_bloc/subcategory_state.dart';
import 'package:growmind_admin/features/category/presentation/widgets/display_subcourse_widget.dart';

Expanded displayCourse() {
  final TextEditingController subCategoryController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return Expanded(
    child: BlocConsumer<FetchCategoryBloc, FetchCategoryState>(
      listener: (context, categoryState) {
        if (categoryState is FetchCategoryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${categoryState.message}')),
          );
        }
      },
      builder: (context, categoryState) {
        if (categoryState is FetchCategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (categoryState is FetchCategoryLoaded) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 25,
              mainAxisExtent: 100,
              crossAxisSpacing: 50,
            ),
            itemCount: categoryState.fetchCategory.length,
            itemBuilder: (context, index) {
              final category = categoryState.fetchCategory[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.network(category.imageUrl),
                        ),
                        Text(
                          category.category,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.purple,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            context.read<FetchSubcategoryBloc>().add(
                                GetSubcategoryEvent(categoryId: category.id));
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    height: 500,
                                    width: 500,
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Container(
                                              height: 50,
                                              width: 200,
                                             decoration:const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  color: Color.fromRGBO(215, 159, 251, 1.0),
                                            boxShadow: [BoxShadow(
                                              color: Color.fromRGBO(215, 159, 251, 1.0),
                                              blurRadius: 5,
                                              blurStyle: BlurStyle.solid,
                                              offset: Offset(0, 3)
                                            )]
                                             ),
                                              child:const Center(
                                                child:  Text(
                                                  'Add Subcategory',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Divider(
                                              height: 20, color: Colors.grey),
                                          TextFormField(
                                            controller: subCategoryController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please add the name of the subcategory';
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              labelText: 'Subcategory Name',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          BlocConsumer<SubcategoryBloc,
                                              SubcategoryState>(
                                            listener: (context, state) {
                                              if (state is SubCategorySuccess) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Successfully added the subcategory!'),
                                                  ),
                                                );
                                                context
                                                    .read<
                                                        FetchSubcategoryBloc>()
                                                    .add(
                                                      GetSubcategoryEvent(
                                                        categoryId: category.id,
                                                      ),
                                                    );
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is SubCategorySubmitting) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              return SizedBox(
                                                width: double.infinity,
                                                height: 40,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      context
                                                          .read<
                                                              SubcategoryBloc>()
                                                          .add(
                                                            SubmitCategoryEvent(
                                                              name:
                                                                  subCategoryController
                                                                      .text
                                                                      .trim(),
                                                              categoryId:
                                                                  category.id,
                                                            ),
                                                          );
                                                    }
                                                  },
                                                  child: const Text('Submit'),
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          displaySubCourse(id: category.id),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'View',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: Text('No categories available'));
      },
    ),
  );
}
