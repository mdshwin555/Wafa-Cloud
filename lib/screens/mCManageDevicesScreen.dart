import 'package:mcloud/screens/mCUpgradeAccountScreen.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ManageDevicesScreen extends StatelessWidget {
  const ManageDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Manage devices"),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              createRichText(
                list: [
                  TextSpan(text: "You can only have ", style: primaryTextStyle(size: 16)),
                  TextSpan(text: "3 linked devices.", style: boldTextStyle(size: 16)),
                  TextSpan(
                    text: " When you unlink a device, Syncing will no longer be available.",
                    style: primaryTextStyle(size: 16),
                  ),
                ],
                overflow: TextOverflow.visible,
              ),
              8.height,
              buildDivider(isFull: true),
              8.height,
              SizedBox(
                height: 250,
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                  leading: const Icon(
                    Icons.android_outlined,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Android LLD-AL10",
                    style: boldTextStyle(size: 16),
                  ),
                  subtitle: Text(
                    "This device",
                    style: primaryTextStyle(color: Colors.black),
                  ),
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                ),
              ),
              8.height,
              buildDivider(isFull: true),
              8.height,
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                color: Colors.grey,
                child: Text(
                  "Unlink",
                  style: boldTextStyle(),
                ),
              ).onTap(() {
                buildShowDialog(context);
              }),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDivider(isFull: true),
                  const Text("OR"),
                  buildDivider(isFull: true),
                ],
              ),
              8.height,
              Text(
                "Link more devices with Plus",
                style: boldTextStyle(size: 16),
              ),
              8.height,
              Text(
                "Want more storage space, offline folders, "
                "automatic camera uploads, and more?",
                textAlign: TextAlign.center,
                style: primaryTextStyle(color: Colors.black, size: 16),
              ).paddingOnly(left: 16, right: 16),
              8.height,
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                alignment: Alignment.center,
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    child: Text(
                      "Try Plus for free",
                      style: boldTextStyle(),
                    ),
                    onPressed: () {
                      const UpgradeAccountScreen().launch(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          buttonPadding: const EdgeInsets.all(8),
          contentPadding: const EdgeInsets.fromLTRB(25, 16, 32, 8),
          insetPadding: const EdgeInsets.all(16),
          title: Text("Choose devices", style: boldTextStyle(size: 24)),
          content: Wrap(
            children: [
              Text("To continue, you need to unlink 1 device.", style: primaryTextStyle(size: 20)),
            ],
          ),
          actions: [
            TextButton(
              child: Text("OK", style: boldTextStyle(size: 16, color: CSDarkBlueColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
