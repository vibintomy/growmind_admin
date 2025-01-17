import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_subcategory/fetch_subcategory_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_subcategory/fetch_subcategory_event.dart';

void showUpdateDialog(BuildContext context, String categoryId,
    String subcategoryId, String name) {
  final TextEditingController controller = TextEditingController(text: name);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update SubCourse'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(label: Text('Course Name')),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  context.read<FetchSubcategoryBloc>().add(
                      UpdateSubcategoryEvent(
                          categoryId: categoryId,
                          subcategoryId: subcategoryId,
                          name: controller.text.trim()));
                  Navigator.pop(context);
                },
                child: const Text('Update'))
          ],
        );
      });
}
