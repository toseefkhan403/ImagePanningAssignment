import 'package:flutter/material.dart';
import 'package:image_panning_assignment/views/utils/helper_widgets.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/network_image_viewmodel.dart';
import '../utils/colors.dart';

class EditImagePage extends StatelessWidget {
  const EditImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperWidgets.customAppBar(context, "Custom Image Card"),
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            Consumer<NetworkImageViewModel>(
              builder: (BuildContext context, NetworkImageViewModel value,
                  Widget? child) {
                return value.image == null
                    ? const Expanded(
                        child: Center(
                            child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )),
                      )
                    : HelperWidgets.imageViewContainer(
                        child: Column(
                          children: [
                            customizeButton(context),
                            HelperWidgets.dummyDataHeader(context),
                          ],
                        ),
                        backgroundImage: DecorationImage(
                            image: NetworkImage(value.image!.imageUrl),
                            fit: BoxFit.cover),
                      );
              },
            ),
            HelperWidgets.customButton("Save", () {
              Navigator.of(context).pop();
            }),
          ],
        ),
      ),
    );
  }

  customizeButton(BuildContext context) => GestureDetector(
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
              borderRadius: BorderRadius.circular(6),
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
