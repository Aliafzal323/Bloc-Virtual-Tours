part of 'view.dart';

class PaginationPage extends StatelessWidget {
  const PaginationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaginationCubit(
          paginationRepository:
              PaginationRepoImpl(httpClient: context.read<HttpClient>()))
        ..fetchInitialListings(limit: 10, skip: 0),
      child: const PaginationScreen(),
    );
  }
}
