import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Models/launch_model.dart';

class SpaceXDetailScreen extends StatelessWidget {
  const SpaceXDetailScreen({Key? key, required this.model}) : super(key: key);

  final LaunchModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: CircularProgressIndicator.adaptive(),
                ),
                imageUrl: model.links?.patch?.large != null
                    ? model.links!.patch!.large!
                    : "https://icon-library.com/images/no-image-icon/no-image-icon-0.jpg",
                useOldImageOnUrlChange: false,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          BackButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Spacer(),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: model.success != null &&
                                              model.success!
                                          ? Colors.green.shade700
                                          : model.upcoming != null &&
                                                  model.upcoming == true
                                              ? Colors.yellow
                                              : Colors.red,
                                      width: 3)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              child: Text(
                                model.success != null && model.success!
                                    ? "Success"
                                    : model.upcoming != null &&
                                            model.upcoming == true
                                        ? "Upcoming"
                                        : "Failure",
                                style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        model.success != null && model.success!
                                            ? Colors.green.shade700
                                            : model.upcoming != null &&
                                                    model.upcoming == true
                                                ? Colors.yellow
                                                : Colors.red,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () async {
                          await detailSheet(context, model);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            elevation: 10,
                            shadowColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            backgroundColor: Colors.white),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "See more detail",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future detailSheet(BuildContext context, LaunchModel model) async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        useRootNavigator: false,
        isDismissible: false,
        builder: ((context) {
          return makeDismissable(
            context: context,
            child: DraggableScrollableSheet(
                initialChildSize: .5,
                maxChildSize: .8,
                minChildSize: .3,
                builder: ((context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            "Operation Name",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              model.name ?? "not found",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            "Operation Time",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              model.dateUtc ?? "not found",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            "Rocket",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              model.rocket ?? "not found",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            "Flight Number",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              model.flightNumber?.toString() ?? "not found",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        if (model.success != null &&
                            model.details != null &&
                            model.details!.isNotEmpty)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              "Operation Detail",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            subtitle: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                model.details ?? "not found",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                })),
          );
        }));
  }

  Widget makeDismissable(
      {required BuildContext context, required Widget child}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
  }
}
