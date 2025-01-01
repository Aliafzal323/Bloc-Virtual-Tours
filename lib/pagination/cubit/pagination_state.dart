// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pagination_cubit.dart';

typedef LatestListingsDataState = DataState<ListingsModel>;

class PaginationState extends Equatable {
  const PaginationState({
    this.latestListingsDataState = const DataState(),
    this.total = 0,
    this.isScrollLoading = false,
  });

  final LatestListingsDataState latestListingsDataState;
  final int total;
  final bool isScrollLoading;

  @override
  List<Object> get props => [
        latestListingsDataState,
        total,
        isScrollLoading,
      ];

  List<DataListModel> get listings =>
      latestListingsDataState.data?.listings ?? [];
  int get skip => latestListingsDataState.data?.listings?.length ?? 0;

  PaginationState copyWith({
    LatestListingsDataState? latestListingsDataState,
    int? total,
    bool? isScrollLoading,
  }) {
    return PaginationState(
      latestListingsDataState:
          latestListingsDataState ?? this.latestListingsDataState,
      total: total ?? this.total,
      isScrollLoading: isScrollLoading ?? this.isScrollLoading,
    );
  }
}
