part of 'view.dart';

class VirtualToursScreen extends StatelessWidget {
  const VirtualToursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isToursEnabled = context.select(
      (VirtualToursCubit value) => value.state.isTourEnabled,
    );
    return BlocBuilder<VirtualToursCubit, VirtualToursState>(
      buildWhen: (previous, current) =>
          previous.isTourEnabled != current.isTourEnabled ||
          previous.virtualTours != current.virtualTours,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Virtual Tours',
              style: context.twenty700,
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Virtual Tours',
                        style: context.twenty600,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      if (isToursEnabled && state.virtualTours.isNotEmpty)
                        CustomCircleContainer(
                          text: '${state.virtualTours.length}',
                        )
                      else
                        const SizedBox.shrink(),
                      const Spacer(),
                      if (isToursEnabled && state.virtualTours.isNotEmpty)
                        const AddMoreToursWidget(),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      if (isToursEnabled && state.virtualTours.isNotEmpty)
                        _buildToursView(context, state)
                      else
                        _buildDottedBorder(context, state),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildDottedBorder(BuildContext context, VirtualToursState state) {
  return DottedBorderWidget(
    onTap: () {
      context.read<VirtualToursCubit>().propertyVirtualTours();
    },
    title: 'Add Virtual Tours',
    isFullWidth: true,
    isSubtitleTrue: true,
    subtitle: '360 Image , Max size 5MBs',
  );
}

Widget _buildToursView(BuildContext context, VirtualToursState state) {
  return BlocBuilder<VirtualToursCubit, VirtualToursState>(
    buildWhen: (previous, current) =>
        previous.virtualTours != current.virtualTours,
    builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 190,
            child: ListView.builder(
              shrinkWrap: true,
              primary: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.virtualTours.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<VirtualToursCubit>()
                              .removePropertyVirtualTour(index);
                        },
                        child: const Icon(Icons.delete),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<PanoramaView>(
                              builder: (context) => PanoramaView(
                                tourPaths: state.virtualTours[index],
                              ),
                            ),
                          );
                        },
                        child: VirtualTourThumbnail(
                          virtualTourPath: state.virtualTours[index],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}

class PanoramaView extends StatelessWidget {
  const PanoramaView({super.key, required this.tourPaths});
  final String tourPaths;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PanoramaViewer(
        child: Image.file(File(tourPaths)),
      ),
    );
  }
}
