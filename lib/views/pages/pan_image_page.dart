import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_panning_assignment/views/utils/colors.dart';
import 'package:image_panning_assignment/views/utils/helper_widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/local_image_viewmodel.dart';
import '../../viewmodels/network_image_viewmodel.dart';
import '../utils/image_picker_util.dart';

class PanImagePage extends StatefulWidget {
  const PanImagePage({Key? key}) : super(key: key);

  @override
  State<PanImagePage> createState() => _PanImagePageState();
}

class _PanImagePageState extends State<PanImagePage> {
  GlobalKey repaintKey = GlobalKey();
  bool showLocalImg = false;
  String? localPath;

  @override
  void initState() {
    localPath = context.read<LocalImageViewModel>().imgPath;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final networkImageProvider = context.watch<NetworkImageViewModel>();
    final localImageProvider = context.watch<LocalImageViewModel>();
    showLocalImg = localPath != localImageProvider.imgPath;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customize Your Card"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.all(12),
            icon: const Icon(
              Icons.close,
              size: 22,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          changeImageButton(),
          networkImageProvider.image == null
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.grey,
                ))
              : HelperWidgets.imageViewContainer(
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
                            child: showLocalImg
                                ? Image.file(
                                    File(localImageProvider.imgPath!),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    networkImageProvider.image!.imageUrl,
                                    fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      dummyData(),
                    ],
                  ),
                ),

          HelperWidgets.customButton("Save", () async {
            context.loaderOverlay.show();
            String filePath =
                await localImageProvider.savePannedImage(repaintKey);
            await networkImageProvider.uploadImage(filePath);
            await networkImageProvider.fetchImage();
            context.loaderOverlay.hide();
          }),
        ],
      ),
    );
  }

  changeImageButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: InkWell(
          onTap: () => ImagePickerUtil.showPickImageBottomSheet(context,
              changeScreen: false),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.blueButtonColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo,
                  color: AppColors.blue,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 6),
                  child: Text(
                    "Change picture here and adjust",
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
}
