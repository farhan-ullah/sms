import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/class_name_provider.dart';
import 'package:school/businessLogic/providers/expansion_tile_provider.dart';
import 'package:school/businessLogic/providers/fee_provider.dart';
import 'package:school/businessLogic/providers/parent_provider.dart';
import 'package:school/businessLogic/providers/salary_provider.dart';
import 'package:school/businessLogic/providers/setting_provider.dart';
import 'package:school/businessLogic/providers/staff_provider.dart';
import 'package:school/businessLogic/providers/student_provider.dart';
import 'package:school/businessLogic/providers/subject_provider.dart';
import 'package:school/businessLogic/providers/teacher_provider.dart';
import 'package:school/businessLogic/providers/accounting_provider.dart';
import 'package:school/services/id_service/id_service.dart';
import 'package:school/ui/presentation/navigation_screen.dart';
import 'businessLogic/providers/id_provider.dart';
import 'businessLogic/providers/inventory_provider.dart';
import 'constants/common_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path);

  await Hive.openBox(CommonKeys.UNIQQUE_ID_BOX_KEY);
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //       apiKey: "AIzaSyBSp_3VmacZ3w1L4kZTuUNmM6AAXJOIIHA",
  //       appId: ConstantResources.APP_ID,
  //       messagingSenderId: ConstantResources.MESSAGING_ID,
  //       projectId: "school-b3300")
  // );

  // WidgetsFlutterBinding.ensureInitialized();
  await IDService.initialize();
  // Directory dir = await getApplicationDocumentsDirectory();
  //
  // try{
  //   dir.deleteSync(recursive: true);
  //
  // }catch(e){
  //   print(e.toString());
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StudentProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => StaffProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => AccountingProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => SalaryProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => InventoryProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => SubjectProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => ClassNameProvider(),

        ),

        ChangeNotifierProvider(
          create: (context) => FeeProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => TeacherProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => IdProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => ParentProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => ExpansionTileProvider(),

        ),
    // ChangeNotifierProvider(
    // create: (context) => AttendanceProvider(),
    //
    // ),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
    // home: FeeGenerationScreen(),
      home: NavigationScreen(),
    ),
    );
  }

}

// Get the application's document directory
Future<String> getAppDocumentsPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

// Get the application's temporary directory (for cache)
Future<String> getAppTempPath() async {
  final tempDirectory = await getTemporaryDirectory();
  return tempDirectory.path;
}


void clearAppFiles() async {
  try {
    // Get the application's documents directory
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    // Delete files within that directory (recursive if needed)
    appDocDirectory.deleteSync(recursive: true);
    print("App data cleared successfully.");
  } catch (e) {
    print("Failed to clear app files: $e");
  }
}
