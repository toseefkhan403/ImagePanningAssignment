import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    return Scaffold(
      appBar: HelperWidgets.customAppBar(context, "Upload Picture"),
      body: Consumer<LocalImageViewModel>(builder: (context, value, child) {
        return Column(
          children: [
            HelperWidgets.imageViewContainer(
              child: Image.file(
                File(value.imgPath!),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Picture ready to be saved',
              style: GoogleFonts.mulish(),
            ),
            HelperWidgets.customButton(
                "Save & Continue", () => onButtonPressed(value.imgPath!))
          ],
        );
      }),
    );
  }

  onButtonPressed(String imgPath) async {
    context.loaderOverlay.show();
    final networkImgProvider = context.read<NetworkImageViewModel>();
    final isUploaded = await networkImgProvider.uploadImage(imgPath);
    context.loaderOverlay.hide();

    if (!isUploaded) {
      Fluttertoast.showToast(msg: "Error: could not upload image");
      return;
    }

    Fluttertoast.showToast(msg: "Image uploaded successfully!");
    Navigator.of(context).pushReplacementNamed('/finalImagePreview');
  }
}
