part of 'pagination_repository.dart';

class PaginationRepoImpl implements PaginationRepository {
  PaginationRepoImpl({required this.httpClient});

  final HttpClient httpClient;

  @override
  Future<ListingsModel> getLatestListings() {
    return httpClient
        .get<JsonObject>(
      path: ApiEndPoints.fetchListings,
    )
        .then(
      (json) {
        return ListingsModel.fromJson(json);
      },
    );
  }
}
