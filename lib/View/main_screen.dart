import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/SpaceXBloc/spacex_bloc.dart';
import '../Bloc/SpaceXBloc/spacex_bloc_state.dart';
import '../Bloc/SpaceXBloc/spacex_event.dart';
import '../Models/launch_model.dart';
import 'Widgets/error_widget.dart';
import 'Widgets/my_progressbar.dart';
import 'detail_screen.dart';

class SpaceXMainScreen extends StatelessWidget {
  const SpaceXMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spacexBloc = BlocProvider.of<SpaceXBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        centerTitle: true,
        title: const Text("Space X Launches"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<SpaceXBloc, SpaceXBlocState>(
          bloc: spacexBloc..add(const GetAllLaunchs()),
          builder: (context, state) {
            if (state is LoadingState) {
              return const MyCircularProgressBar();
            }

            if (state is SuccessState) {
              List<LaunchModel> models =
                  state.response.response as List<LaunchModel>;
              return Column(
                children: [Expanded(child: MainBodyWidget(models: models))],
              );
            } else {
              state as FailureState;
              return Center(
                  child: MyErrorWidget(
                errorMessage: state.failure.errorMessage.toString(),
              ));
            }
          },
        ),
      ),
    );
  }
}

class MainBodyWidget extends StatelessWidget {
  final List<LaunchModel> models;
  const MainBodyWidget({Key? key, required this.models}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, index) {
          LaunchModel model = models[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SpaceXDetailScreen(
                      model: model,
                    );
                  },
                ));
              },
              color: Colors.white,
              elevation: 2,
              padding: EdgeInsets.zero,
              child: LayoutBuilder(
                builder: (p0, p1) => Container(
                  height: (p1.maxWidth -
                          const EdgeInsets.symmetric(horizontal: 4)
                              .horizontal) /
                      4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                  child: Row(
                    children: [
                      Expanded(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: model.links?.patch?.small != null
                                  ? Image.network(
                                      model.links!.patch!.small!,
                                      fit: BoxFit.cover,
                                    )
                                  : const SizedBox())),
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 5) +
                                const EdgeInsets.only(left: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  model.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const Spacer(),
                                Text(
                                  "${model.dateUtc?.split("T")[0] ?? "not found"}\t${model.dateUtc?.split("T")[1].substring(0, 5).toString() ?? "not found"}",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600),
                                ),
                                const Spacer(),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: model.success != null &&
                                                    model.success!
                                                ? Colors.green.shade700
                                                : model.upcoming != null &&
                                                        model.upcoming == true
                                                    ? Colors.orange.shade600
                                                    : Colors.red,
                                            width: 2)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    child: Text(
                                      model.success != null && model.success!
                                          ? "Success"
                                          : model.upcoming != null &&
                                                  model.upcoming == true
                                              ? "Upcoming"
                                              : "Failure",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: model.success != null &&
                                                  model.success!
                                              ? Colors.green.shade700
                                              : model.upcoming != null &&
                                                      model.upcoming == true
                                                  ? Colors.orange.shade600
                                                  : Colors.red,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          )),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.adaptive.arrow_forward_rounded))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
