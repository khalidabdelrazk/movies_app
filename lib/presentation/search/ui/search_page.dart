import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/utils/network_error_widget.dart';
import 'package:movies/presentation/search/ui/cubit/search_states.dart';
import 'package:movies/presentation/search/ui/cubit/search_view_model.dart';

import '../../../core/utils/custom_text_field.dart';
import '../../../core/utils/movie_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final SearchViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<SearchViewModel>();
    viewModel.scrollController.addListener(viewModel.onScroll);
  }

  @override
  void dispose() {
    viewModel.scrollController.removeListener(viewModel.onScroll);
    viewModel.searchController.dispose();
    super.dispose();
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
              controller: viewModel.searchController,
              prefixIcon: Icon(Icons.search, color: AppColors.light),
              backgroundColor: AppColors.darkGray,
              labelColor: AppColors.light,
              inputColor: AppColors.light,
              borderColor: AppColors.transparent,
              onChanged: (value) => viewModel.onSearch(value),
              suffixIcon: GestureDetector(onTap: () {
                FocusScope.of(context).unfocus();
                viewModel.searchController.clear();
                viewModel.onSearch("");
              },child: Icon(Icons.clear,color: AppColors.light,),),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BlocBuilder<SearchViewModel, SearchStates>(
                builder: (context, state) {
                  if (state is SearchLoadingState &&
                      viewModel.currentPage == 1) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchErrorState) {
                    return NetworkErrorWidget(
                      errorMsg: state.message,
                      large: true,
                      onTap: () async => viewModel.getMoviesByQuery(
                        queryTerm: viewModel.lastQuery,
                        limit: viewModel.limit,
                        page: viewModel.currentPage,
                      ),
                    );
                  } else if (state is SearchSuccessState) {
                    final movies =
                        state.searchResponseEntity.data?.movies ?? [];

                    if (viewModel.searchController.text.isEmpty ||
                        movies.isEmpty) {
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
                      controller: viewModel.scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.sp,
                        crossAxisSpacing: 12.sp,
                        childAspectRatio: 198 / 279,
                      ),
                      itemCount:
                          movies.length + (viewModel.isFetchingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == movies.length &&
                            viewModel.isFetchingMore) {
                          return SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: const CircularProgressIndicator(),
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
