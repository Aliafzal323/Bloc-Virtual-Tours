import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:virtual_tours_bloc/pagination/cubit/pagination_cubit.dart';
import 'package:virtual_tours_bloc/widgets/network_image_widget.dart';

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final paginationCubit = BlocProvider.of<PaginationCubit>(context);

    paginationCubit.initializeScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    final paginationCubit = context.read<PaginationCubit>();
    paginationCubit.initializeScrollListener();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination Screen'),
      ),
      body: BlocBuilder<PaginationCubit, PaginationState>(
        buildWhen: (previous, current) =>
            previous.latestListingsDataState != current.latestListingsDataState,
        builder: (context, state) {
          final lists = state.latestListingsDataState.data;

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: paginationCubit.scrollController,
            itemCount: lists?.listings?.length ?? 0,
            itemBuilder: (context, index) {
              final listLength = lists?.listings?.length ?? 0;
              return Column(
                children: [
                  ListTile(
                    leading: Text(lists?.listings?[index].id.toString() ?? ''),
                    title: Text(lists?.listings?[index].title.toString() ?? ''),
                    subtitle: Text(
                      '\$${lists?.listings?[index].price.toString() ?? ''}',
                    ),
                    trailing: NetworkImageWidget(
                      imageUrl:
                          lists?.listings?[index].thumbnail.toString() ?? '',
                      width: 100,
                    ),
                  ),
                  if (index == listLength - 1 &&
                      state.latestListingsDataState.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SpinKitChasingDots(
                        size: 30,
                        color: Colors.green,
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
