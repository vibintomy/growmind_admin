import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_category_bloc/fetch_category_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_subcategory/fetch_subcategory_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_subcategory/fetch_subcategory_event.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_subcategory/fetch_subcategory_state.dart';
import 'package:growmind_admin/features/category/presentation/widgets/show_update_dialog.dart';

Expanded displaySubCourse({required String id}) {
  return Expanded(
    child: BlocConsumer<FetchSubcategoryBloc, FetchSubcategoryState>(
      listener: (context, subcategoryState) {
        if (subcategoryState is FetchSubcategoryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error')),
          );
        }
      },
      builder: (context, subcategoryState) {
        final categoryid = BlocProvider.of<FetchCategoryBloc>(context);
        if (subcategoryState is FetchSubcategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (subcategoryState is FetchSubcategoryLoaded) {
          return ListView.builder(
            itemCount: subcategoryState.fetchSubcategory.length,
            itemBuilder: (context, index) {
              final subcategory = subcategoryState.fetchSubcategory[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Container(
                      width: 500,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 235, 231, 231),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 3),
                              blurRadius: 5,
                              blurStyle: BlurStyle.outer,
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                subcategory.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showUpdateDialog(context, id,
                                        subcategory.id, subcategory.name);
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    context.read<FetchSubcategoryBloc>().add(
                                        DeleteSubcategoryEvent(
                                            categoryId: id,
                                            subcategoryId: subcategory.id));
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
        return const Center(
          child: Text('No subcategories available'),
        );
      },
    ),
  );
}
