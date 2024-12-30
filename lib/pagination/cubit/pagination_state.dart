// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pagination_cubit.dart';

typedef LatestListingsDataState = DataState<ListingsModel>;

class PaginationState extends Equatable {
  const PaginationState({
    this.latestListingsDataState = const DataState(),
    this.total = 1000,
  });

  final LatestListingsDataState latestListingsDataState;
  final int total;

  @override
  List<Object> get props => [
        latestListingsDataState,
        total,
      ];

  List<DataListModel> get listings =>
      latestListingsDataState.data?.listings ?? [];
  int get skip => latestListingsDataState.data?.listings?.length ?? 0;

  PaginationState copyWith({
    LatestListingsDataState? latestListingsDataState,
    int? total,
  }) {
    return PaginationState(
      latestListingsDataState:
          latestListingsDataState ?? this.latestListingsDataState,
      total: total ?? this.total,
    );
  }
}
