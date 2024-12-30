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

  final ScrollController scrollController = ScrollController();

  void initializeScrollListener() {
    scrollController.addListener(() {
      final isAtBottom = scrollController.position.pixels ==
          scrollController.position.maxScrollExtent;
      if (isAtBottom && state.listings.length < state.total) {
        _loadMoreData();
      }
    });
  }

  Future<void> _loadMoreData() async {
    if (state.listings.length < state.total) {
      emit(state.copyWith(
          latestListingsDataState: state.latestListingsDataState.toLoading()));

      try {
        final newData = await getLatestListings(state.listings.length);

        emit(state.copyWith(
          total: state.total,
          latestListingsDataState: state.latestListingsDataState.toLoaded(
            data: newData,
          ),
        ));
      } catch (error) {
        emit(state.copyWith(
          latestListingsDataState: state.latestListingsDataState.toFailure(
            error: error.toString(),
          ),
        ));
      }
    }
  }

  Future<ListingsModel> getLatestListings(int skip) async {
    emit(
      state.copyWith(
        latestListingsDataState: state.latestListingsDataState.toLoading(),
      ),
    );

    try {
      final listings = await paginationRepository.getLatestListings(skip);
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
