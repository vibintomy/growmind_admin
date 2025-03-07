import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/core/utils/service_locator.dart';
import 'package:growmind_admin/features/category/domain/usecases/category_usecases.dart';
import 'package:growmind_admin/features/category/domain/usecases/fetch_category_usecases.dart';
import 'package:growmind_admin/features/category/domain/usecases/fetch_subcategory_usecases.dart';
import 'package:growmind_admin/features/category/domain/usecases/subcategory_usecases.dart';
import 'package:growmind_admin/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_category_bloc/fetch_category_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_subcategory/fetch_subcategory_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/subcategory_bloc/subcategory_bloc.dart';
import 'package:growmind_admin/features/category/presentation/pages/category_page.dart';
import 'package:growmind_admin/features/category/presentation/widgets/displayCourse_widget.dart';
import 'package:growmind_admin/features/home/domain/usecases/get_admin_usecases.dart';
import 'package:growmind_admin/features/home/presentation/bloc/admin_bloc/admin_bloc.dart';
import 'package:growmind_admin/features/navigation/presentaion/pages/tab_bar_pages.dart';
import 'package:growmind_admin/features/tutors/data/datasource/tutor_remote_datasource.dart';
import 'package:growmind_admin/features/tutors/data/repo/tutor_repositories_impl.dart';
import 'package:growmind_admin/features/tutors/domain/usecases/get_tutors.dart';
import 'package:growmind_admin/features/tutors/presentation/bloc/tutor_bloc.dart';
import 'package:growmind_admin/features/tutors/presentation/bloc/tutor_event.dart';
import 'package:growmind_admin/firebase_options.dart';
import 'package:growmind_admin/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final tutorRepository = TutorRepositoryimpl(
      TutorRemoteDatasource(FirebaseFirestore.instance),
      FirebaseFirestore.instance);
  final getTutors = GetTutors(tutorRepository);
  setUp();
  runApp(MyWebApp(
    getTutors: getTutors,
  ));
}

class MyWebApp extends StatelessWidget {
  final GetTutors getTutors;
  const MyWebApp({super.key, required this.getTutors});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TutorBloc(getTutors)..add(FetchTutorEvent()),
          ),
          BlocProvider(
            create: (context) => CategoryBloc(
                uploadImageUsecase: getIt<UploadImageUsecase>(),
                submitCategoryUsecase: getIt<SubmitCategoryUsecase>()),
            child: const CategoryPage(),
          ),
         BlocProvider(create: (context)=> FetchCategoryBloc(getIt<GetCategory>()),
         child: const CategoryPage(),),
         BlocProvider(create: (context)=> SubcategoryBloc(getIt<SubcategoryUsecases>()),
         child: displayCourse(),),
         BlocProvider(create: (context)=> FetchSubcategoryBloc(getIt<GetSubcategory>()),child: displayCourse(),),
         BlocProvider(create: (context)=> AdminBloc(getIt<GetAdminUsecases>()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ));
  }
}
