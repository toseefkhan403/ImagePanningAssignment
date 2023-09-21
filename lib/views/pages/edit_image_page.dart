import 'package:flutter/material.dart';
import 'package:image_panning_assignment/views/utils/helper_widgets.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/network_image_viewmodel.dart';
import '../utils/colors.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  State<EditImagePage> createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  @override
  Widget build(BuildContext context) {
    final imageProvider = context.watch<NetworkImageViewModel>();

    return Scaffold(
      appBar: HelperWidgets.customAppBar(context, "Custom Image Card"),
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            imageProvider.image == null
                ? const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )),
                  )
                : HelperWidgets.imageViewContainer(
                    child: Column(
                      children: [
                        customizeButton(),
                        HelperWidgets.dummyDataHeader(context),
                      ],
                    ),
                    backgroundImage: DecorationImage(
                        image: NetworkImage(imageProvider.image!.imageUrl),
                        fit: BoxFit.cover),
                  ),
            HelperWidgets.customButton("Save", () {
              Navigator.of(context).pop();
            }),
          ],
        ),
      ),
    );
  }

  customizeButton() => GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/panImagePage');
        },
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.all(6),
            margin: const EdgeInsets.only(top: 15, right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.red,
                  size: 18,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'Customize',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      );
}
