part of 'view.dart';

class PaginationScreen extends StatelessWidget {
  const PaginationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination Screen'),
      ),
      body: BlocListener<PaginationCubit, PaginationState>(
        listenWhen: (previous, current) =>
            previous.latestListingsDataState != current.latestListingsDataState,
        listener: (context, state) {
          if (state.latestListingsDataState.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomSnackBar(
                  message: state.latestListingsDataState.errorMessage ?? '',
                ),
                elevation: 0,
                backgroundColor: const Color(0XFF801336),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: BlocBuilder<PaginationCubit, PaginationState>(
          buildWhen: (previous, current) =>
              previous.latestListingsDataState !=
                  current.latestListingsDataState ||
              previous.isScrollLoading != current.isScrollLoading,
          builder: (context, state) {
            final listings = state.listings;
            final isScrollLoading = state.isScrollLoading;
            return Stack(
              children: [
                if (state.latestListingsDataState.isLoading)
                  const LoadingIndicatorWidget()
                else
                  ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller:
                        context.read<PaginationCubit>().scrollController,
                    itemCount: listings.length + (isScrollLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == listings.length) {
                        return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: LoadingIndicatorWidget());
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
      ),
    );
  }
}
