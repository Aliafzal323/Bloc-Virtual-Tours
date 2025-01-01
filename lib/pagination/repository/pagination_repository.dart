import 'package:common/common.dart';
import 'package:common/http/http_client.dart';
import 'package:virtual_tours_bloc/api_end_points/endpoints.dart';
import 'package:virtual_tours_bloc/pagination/repository/Model/data_list_model.dart';

part 'pagination_repo_impl.dart';

abstract class PaginationRepository {
  Future<ListingsModel> getLatestListings(int limit, int skip);
}
