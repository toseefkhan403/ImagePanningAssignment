import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_panning_assignment/viewmodels/local_image_viewmodel.dart';
import 'package:image_panning_assignment/viewmodels/network_image_viewmodel.dart';
import 'package:image_panning_assignment/views/pages/edit_image_page.dart';
import 'package:image_panning_assignment/views/pages/final_image_view_page.dart';
import 'package:image_panning_assignment/views/pages/home_page.dart';
import 'package:image_panning_assignment/views/pages/pan_image_page.dart';
import 'package:image_panning_assignment/views/pages/upload_page.dart';
import 'package:image_panning_assignment/views/utils/colors.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ImagePanningApp());
}

class ImagePanningApp extends StatelessWidget {
  const ImagePanningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalImageViewModel()),
        ChangeNotifierProvider(create: (_) => NetworkImageViewModel()),
      ],
      child: GlobalLoaderOverlay(
        overlayColor: AppColors.overlayColor,
        useDefaultLoading: false,
        overlayWidget: const Center(
            child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        )),
        child: MaterialApp(
          title: 'Image Panning Assignment',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            primaryColor: AppColors.primaryColor,
            useMaterial3: true,
            textTheme: GoogleFonts.workSansTextTheme(),
          ),
          debugShowCheckedModeBanner: false,
          builder: FToastBuilder(),
          initialRoute: '/',
          routes: {
            '/': (_) => const HomePage(),
            '/uploadPage': (_) => const UploadPage(),
            '/finalImagePreview': (_) => const FinalImageViewPage(),
            '/editImagePage': (_) => const EditImagePage(),
            '/panImagePage': (_) => const PanImagePage(),
          },
        ),
      ),
    );
  }
}
