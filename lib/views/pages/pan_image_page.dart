import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_panning_assignment/views/utils/colors.dart';
import 'package:image_panning_assignment/views/utils/helper_widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/local_image_viewmodel.dart';
import '../../viewmodels/network_image_viewmodel.dart';
import '../utils/image_picker_bottom_sheet.dart';

class PanImagePage extends StatefulWidget {
  const PanImagePage({Key? key}) : super(key: key);

  @override
  State<PanImagePage> createState() => _PanImagePageState();
}

class _PanImagePageState extends State<PanImagePage> {
  GlobalKey repaintKey = GlobalKey();
  TransformationController zoomController = TransformationController();
  late final String? initialLocalPath;

  @override
  void initState() {
    initialLocalPath = context.read<LocalImageViewModel>().imgPath;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customizeYourCardAppBar(),
      body: Consumer<LocalImageViewModel>(builder:
          (BuildContext context, LocalImageViewModel providerRef, child) {
        // zooming out to default size
        zoomController.value = Matrix4.identity();
        return Column(
          children: [
            changeImageButton(),
            HelperWidgets.imageViewContainer(
              child: Stack(
                children: [
                  // panning widget
                  Positioned.fill(
                    child: RepaintBoundary(
                      key: repaintKey,
                      child: InteractiveViewer(
                        constrained: true,
                        minScale: 0.1,
                        maxScale: 5.0,
                        transformationController: zoomController,
                        child: Image.file(
                          File(providerRef.imgPath!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  dummyData(),
                ],
              ),
            ),
            HelperWidgets.customButton("Save", () => updateImage(providerRef)),
          ],
        );
      }),
    );
  }

  updateImage(LocalImageViewModel providerRef) async {
    final networkImgProvider = context.read<NetworkImageViewModel>();
    context.loaderOverlay.show();
    String filePath = await providerRef.savePannedImage(repaintKey);
    final isUploaded = await networkImgProvider.uploadImage(filePath);

    if (!isUploaded) {
      context.loaderOverlay.hide();
      Fluttertoast.showToast(msg: "Error: could not upload image");
      return;
    }

    Fluttertoast.showToast(msg: "Image uploaded successfully!");
    networkImgProvider.fetchImage().then((_) {
      providerRef.setImagePath(filePath);
      context.loaderOverlay.hide();
      Navigator.pop(context);
    });
  }

  changeImageButton() => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: InkWell(
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (c) => const ImagePickerBottomSheet(changeScreen: false),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.blueButtonColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.photo,
                  color: AppColors.blue,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
                  child: Text(
                    "Change picture here and adjust",
                    style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  dummyData() => Align(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: HelperWidgets.dummyDataHeader(context)),
      );

  @override
  void dispose() {
    zoomController.dispose();
    super.dispose();
  }

  PreferredSizeWidget customizeYourCardAppBar() => AppBar(
        title: const Text("Customize Your Card",
            style: TextStyle(
              fontWeight: FontWeight.w400,
            )),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              final ref = context.read<LocalImageViewModel>();
              // reset the local image path as we are not saving changes
              if (ref.imgPath != initialLocalPath) {
                ref.setImagePath(initialLocalPath!);
              }
              Navigator.pop(context);
            },
            padding: const EdgeInsets.only(right: 20),
            icon: const Icon(
              Icons.close,
              size: 24,
            ),
          ),
        ],
      );
}
