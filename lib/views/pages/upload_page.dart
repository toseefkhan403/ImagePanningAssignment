import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_panning_assignment/views/utils/helper_widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/local_image_viewmodel.dart';
import '../../viewmodels/network_image_viewmodel.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    String? imgPath = context.watch<LocalImageViewModel>().imgPath;

    return Scaffold(
      appBar: HelperWidgets.customAppBar(context, "Upload Picture"),
      body: Column(
        children: [
          HelperWidgets.imageViewContainer(
            child: Image.file(
              File(imgPath!),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'Picture ready to be saved',
            style: GoogleFonts.mulish(),
          ),
          HelperWidgets.customButton("Save & Continue", () async {
            context.loaderOverlay.show();
            await context.read<NetworkImageViewModel>().uploadImage(imgPath);
            context.loaderOverlay.hide();
            Navigator.of(context).pushReplacementNamed('/finalImagePreview');
          })
        ],
      ),
    );
  }
}
