import 'package:flutter/material.dart';
import 'package:image_panning_assignment/views/utils/colors.dart';
import 'package:image_panning_assignment/views/utils/helper_widgets.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/network_image_viewmodel.dart';

class FinalImageViewPage extends StatefulWidget {
  const FinalImageViewPage({Key? key}) : super(key: key);

  @override
  State<FinalImageViewPage> createState() => _FinalImageViewPageState();
}

class _FinalImageViewPageState extends State<FinalImageViewPage> {
  @override
  void initState() {
    context.read<NetworkImageViewModel>().fetchImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = context.watch<NetworkImageViewModel>();

    return Scaffold(
      appBar: HelperWidgets.customAppBar(context, "Artist"),
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
                    child: dummyDataColumn(),
                    backgroundImage: DecorationImage(
                        image: NetworkImage(imageProvider.image!.imageUrl),
                        fit: BoxFit.cover),
                  ),
            HelperWidgets.customButton("Edit Card", () {
              Navigator.of(context).pushNamed('/editImagePage');
            }, isRed: false),
          ],
        ),
      ),
    );
  }

  dummyIcon(IconData iconData) => Container(
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.overlayColor,
            borderRadius: BorderRadius.circular(10)),
        child: Icon(
          iconData,
          color: AppColors.white,
        ),
      );

  dummyDataColumn() => Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          HelperWidgets.dummyDataHeader(context),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Realtor | VP design",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
          ),
          Text(
            "Bangalore, India",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.white,
                ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dummyIcon(Icons.mail),
              dummyIcon(Icons.call),
              dummyIcon(Icons.location_on),
              dummyIcon(Icons.person_outline),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset("assets/images/ElredLogo.png"),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.overlayColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: 18,
                  ),
                ),
                const Text(
                  "Profile",
                  style: TextStyle(color: AppColors.white),
                )
              ],
            ),
          )
        ],
      );
}
