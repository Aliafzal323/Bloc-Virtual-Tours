import 'dart:developer';

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
  final ScrollController _controller = ScrollController();

  int totalProducts = 1000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      loadMoreData();
    });
  }

  Future<void> loadMoreData() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent &&
        BlocProvider.of<PaginationCubit>(context).state.listings.length <
            BlocProvider.of<PaginationCubit>(context).state.total) {
      BlocProvider.of<PaginationCubit>(context).getLatestListings(
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pagination Screen'),
        ),
        body: BlocBuilder<PaginationCubit, PaginationState>(
          buildWhen: (previous, current) =>
              previous.latestListingsDataState !=
              current.latestListingsDataState,
          builder: (context, state) {
            // if (state.latestListingsDataState.isLoading) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            final lists = state.latestListingsDataState.data;
            log('${state.latestListingsDataState.data}');

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: false,
              itemCount: lists?.listings?.length ?? 0,
              controller: _controller,
              itemBuilder: (context, index) {
                final listLength = lists?.listings?.length ?? 0;
                return Column(
                  children: [
                    ListTile(
                      leading:
                          Text(lists?.listings?[index].id.toString() ?? ''),
                      title:
                          Text(lists?.listings?[index].title.toString() ?? ''),
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
        ));
  }
}
