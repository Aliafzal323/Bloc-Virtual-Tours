import 'package:bloc/bloc.dart';
import 'package:common/http/data_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:virtual_tours_bloc/pagination/repository/Model/data_list_model.dart';
import 'package:virtual_tours_bloc/pagination/repository/pagination_repository.dart';

part 'pagination_state.dart';

class PaginationCubit extends Cubit<PaginationState> {
  PaginationCubit({
    required this.paginationRepository,
  }) : super(const PaginationState());

  final PaginationRepository paginationRepository;
  Future<ListingsModel> getLatestListings(BuildContext context) async {
    emit(
      state.copyWith(
        latestListingsDataState: state.latestListingsDataState.toLoading(),
      ),
    );

    try {
      final listings = await paginationRepository.getLatestListings();
      emit(
        state.copyWith(
          total: listings.total,
          latestListingsDataState:
              state.latestListingsDataState.toLoaded(data: listings),
        ),
      );
      return listings;
    } catch (error) {
      emit(
        state.copyWith(
          latestListingsDataState:
              state.latestListingsDataState.toFailure(error: error),
        ),
      );
      rethrow;
    }
  }
}
