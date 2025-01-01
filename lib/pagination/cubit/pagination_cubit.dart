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
  }) : super(const PaginationState()) {
    initializeScrollListener();
  }

  final PaginationRepository paginationRepository;
  final ScrollController scrollController = ScrollController();

  void initializeScrollListener() {
    scrollController.addListener(() {
      if (_isAtBottom() &&
          !_isLoadingMore() &&
          state.listings.length < state.total) {
        _loadMoreData(limit: 10, skip: state.listings.length);
      }
    });
  }

  bool _isAtBottom() {
    return scrollController.position.pixels ==
        scrollController.position.maxScrollExtent;
  }

  bool _isLoadingMore() {
    return state.isScrollLoading || state.latestListingsDataState.isLoading;
  }

  Future<void> fetchInitialListings({
    required int limit,
    required int skip,
  }) async {
    emit(state.copyWith(latestListingsDataState: const DataState.loading()));
    try {
      final listings =
          await paginationRepository.getLatestListings(limit, skip);
      emit(
        state.copyWith(
          total: listings.total,
          latestListingsDataState:
              state.latestListingsDataState.toLoaded(data: listings),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          latestListingsDataState:
              state.latestListingsDataState.toFailure(error: error.toString()),
        ),
      );
    }
  }

  Future<void> _loadMoreData({required int limit, required int skip}) async {
    emit(state.copyWith(isScrollLoading: true));
    try {
      final newData = await paginationRepository.getLatestListings(
          limit, state.listings.length);

      final mergedListings = ListingsModel(
        listings: [...state.listings, ...newData.listings ?? []],
        total: state.total,
      );

      emit(
        state.copyWith(
          latestListingsDataState:
              state.latestListingsDataState.toLoaded(data: mergedListings),
          isScrollLoading: false,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isScrollLoading: false,
          latestListingsDataState: state.latestListingsDataState.toFailure(
            error: error.toString(),
          ),
        ),
      );
    }
  }
}
