import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:virtual_tours_bloc/pagination/cubit/pagination_cubit.dart';
import 'package:virtual_tours_bloc/widgets/network_image_widget.dart';

class PaginationScreen extends StatelessWidget {
  const PaginationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination Screen'),
      ),
      body: BlocBuilder<PaginationCubit, PaginationState>(
        buildWhen: (previous, current) =>
            previous.latestListingsDataState !=
                current.latestListingsDataState ||
            previous.isScrollLoading != current.isScrollLoading,
        builder: (context, state) {
          final listings = state.listings;
          final isScrollLoading = state.isScrollLoading;
          return Stack(
            children: [
              if (state.latestListingsDataState.isLoading && listings.isEmpty)
                const LoadingIndicatorWidget()
              else
                ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: context.read<PaginationCubit>().scrollController,
                  itemCount: listings.length + (isScrollLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == listings.length) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SpinKitChasingDots(
                          size: 30,
                          color: Colors.green,
                        ),
                      );
                    }
                    return ListTile(
                      leading: Text(listings[index].id.toString()),
                      title: Text(listings[index].title.toString()),
                      subtitle: Text(
                        '\$${listings[index].price.toString()}',
                      ),
                      trailing: NetworkImageWidget(
                        imageUrl: listings[index].thumbnail.toString(),
                        width: 100,
                      ),
                    );
                  },
                ),
              TotalProductsWidget(totalProducts: state.total),
            ],
          );
        },
      ),
    );
  }
}

class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitChasingDots(
        size: 50,
        color: Colors.green,
      ),
    );
  }
}

class TotalProductsWidget extends StatelessWidget {
  const TotalProductsWidget({
    super.key,
    required this.totalProducts,
  });

  final int totalProducts;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Total Products: $totalProducts',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
