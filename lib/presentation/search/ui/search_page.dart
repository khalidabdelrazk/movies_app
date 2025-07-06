import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/presentation/search/ui/cubit/search_view_model.dart';
import 'package:movies/presentation/search/ui/cubit/search_states.dart';
import '../../../core/utils/custom_text_field.dart';
import '../../../core/utils/movie_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _limit = 10;
  String _lastQuery = '';
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300 &&
        !_isFetchingMore &&
        context.read<SearchViewModel>().state is SearchSuccessState) {
      final state = context.read<SearchViewModel>().state as SearchSuccessState;
      if (state.searchResponseEntity.data!.movies!.length >= _limit) {
        _isFetchingMore = true;
        _currentPage++;
        context.read<SearchViewModel>().getMoviesByQuery(
          queryTerm: _lastQuery,
          limit: _limit,
          page: _currentPage,
        );
      }
    }
  }

  void _onSearch(String query) {
    _lastQuery = query;
    _currentPage = 1;
    context.read<SearchViewModel>().getMoviesByQuery(
      queryTerm: query,
      limit: _limit,
      page: _currentPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        child: Column(
          children: [
            CustomTextField(
              label: 'Search',
              controller: _searchController,
              prefixIcon: Icon(Icons.search, color: AppColors.light),
              backgroundColor: AppColors.darkGray,
              labelColor: AppColors.light,
              inputColor: AppColors.light,
              borderColor: AppColors.transparent,
              onChanged: (value) => _onSearch(value),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BlocConsumer<SearchViewModel, SearchStates>(
                listener: (context, state) {
                  if (state is SearchSuccessState) {
                    _isFetchingMore = false;
                  }
                },
                builder: (context, state) {
                  if (state is SearchLoadingState && _currentPage == 1) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchErrorState) {
                    return Center(child: Text(state.message));
                  } else if (state is SearchSuccessState) {
                    final movies = state.searchResponseEntity.data?.movies ?? [];

                    if (_searchController.text.isEmpty || movies.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.empty,
                              height: 200.h,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'No results found',
                              style: TextStyle(
                                color: AppColors.light,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.sp,
                        crossAxisSpacing: 12.sp,
                        childAspectRatio: 198 / 279,
                      ),
                      itemCount: movies.length + (_isFetchingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == movies.length) {
                          return SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        }
                        return MoviePosterCard(movie: movies[index]);
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
