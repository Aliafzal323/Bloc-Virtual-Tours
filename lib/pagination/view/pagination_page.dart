import 'package:common/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_tours_bloc/pagination/cubit/pagination_cubit.dart';
import 'package:virtual_tours_bloc/pagination/repository/pagination_repository.dart';
import 'package:virtual_tours_bloc/pagination/view/pagination_view.dart';

class PaginationPage extends StatelessWidget {
  const PaginationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => PaginationCubit(
        paginationRepository: PaginationRepoImpl(
          httpClient: context.read<HttpClient>(),
        ),
      )..getLatestListings(
          context,
        ),
      child: const PaginationScreen(),
    );
  }
}