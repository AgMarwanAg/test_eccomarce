import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_eccomarce/core/logging/logger.dart';
import 'package:test_eccomarce/core/utls/execute_with_retry.dart';
import 'package:test_eccomarce/features/search/data/repo/search_repo.dart';
import 'package:test_eccomarce/shared/dio_client/api_exception.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _repo;
  SearchCubit(this._repo) : super(SearchInitial());

  String? _query;
  int _currentPage = 0;
  bool _isLastPage = false;
  bool _isLoading = false;
  final List<ProductModel> _allResults = [];

  Future<void> search(String? query, {bool reset = true}) async {
    if (_isLoading) return;

    _isLoading = true;
    if (reset) {
      _query = query;
      _currentPage = 0;
      _isLastPage = false;
      _allResults.clear();
      emit(SearchLoading());
    }
    Logger.debug('Search page: $_currentPage, query: $_query');

    await executeWithRetry(
      action: () => _repo.search(_query, _currentPage * 15),
      onFailure: (error) {
        emit(SearchFailure(error));
      },
      onSuccess: (data) {
        _isLastPage = data.length < 15;
        if (data.isEmpty && !_isLastPage) {
          _currentPage++;
          _isLoading = false;
          search(_query, reset: false);
          return;
        }

        _allResults.addAll(data);
        emit(SearchSuccess(List.of(_allResults), hasReachedMax: _isLastPage));
        // if (!_isLastPage ) {
        //   _currentPage++;
        //   _isLoading = false;
        //   search(_query, reset: false);
        //   return;
        // }

        if (!_isLastPage) _currentPage++;
      },
    );
    _isLoading = false;
  }

  // bool _shouldLoadMore() {
  //   return _allResults.length < 12;
  // }

  Future<void> loadMore() async {
    if (_isLastPage || _isLoading) return;
    Logger.debug('Loading more search results');
    await search(_query, reset: false);
  }
}
