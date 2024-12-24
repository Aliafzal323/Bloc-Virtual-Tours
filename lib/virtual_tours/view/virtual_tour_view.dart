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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Virtual Tours',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  if (isToursEnabled && state.virtualTours.isNotEmpty)
                    CustomCircleContainer(
                      text: '${state.virtualTours.length}',
                    )
                  else
                    const SizedBox.shrink(),
                  const Spacer(),
                  if (isToursEnabled && state.virtualTours.isNotEmpty)
                    const _AddMoreToursWidget(),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  if (isToursEnabled && state.virtualTours.isNotEmpty)
                    _buildToursView(context, state)
                  // else
                  //   _buildDottedBorder(context, state),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AddMoreToursWidget extends StatelessWidget {
  const _AddMoreToursWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VirtualToursCubit, VirtualToursState>(
      buildWhen: (previous, current) =>
          previous.virtualTours != current.virtualTours ||
          previous.isTourEnabled != current.isTourEnabled,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<VirtualToursCubit>().propertyVirtualTours();
          },
          child: const Text(
            '+ Add More',
            style: TextStyle(
              color: Colors.greenAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}

// Widget _buildDottedBorder(BuildContext context, VirtualToursState state) {
//   return DottedBorderWidget(
//     onTap: () {
//       context.read<VirtualToursCubit>().propertyVirtualTours();
//     },
//     title: 'Add Virtual Tours',
//     icon: Icons.ac_unit_outlined, // AssetIcons.virtual_tour,
//     isFullWidth: true,
//     isSubtitleTrue: true,
//     subtitle: '360 Image , Max size 5MBs',
//   );
// }

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

class VirtualTourThumbnail extends StatelessWidget {
  const VirtualTourThumbnail({super.key, required this.virtualTourPath});
  final String virtualTourPath;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -6),
            blurRadius: 15,
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
        child: Image.file(
          File(virtualTourPath),
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
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
