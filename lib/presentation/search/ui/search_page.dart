import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';
import '../../../core/utils/custom_text_field.dart';
import '../../../core/utils/movie_card.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<MoviesEntity> _movies = [];
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasMore = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchMovies();
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
        !_isLoading &&
        _hasMore) {
      _fetchMovies();
    }
  }

  Future<void> _fetchMovies() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    // Dummy data
    List<MoviesEntity> fetched = List.generate(
      6,
          (index) => MoviesEntity(
        title: 'Movie ${_currentPage * 6 + index}',
        mediumCoverImage: 'https://image.tmdb.org/t/p/w500/example.jpg',
        rating: 7.7,
        imdbCode: 'tt${_currentPage * 6 + index}',
      ),
    );

    setState(() {
      _currentPage++;
      _movies.addAll(fetched);
      _isLoading = false;
      if (fetched.isEmpty) _hasMore = false;
    });
  }

  void _onSearch(String query) {
    // Implement actual search logic with API or state management
    setState(() {
      _movies.clear();
      _currentPage = 1;
      _hasMore = true;
    });
    _fetchMovies();
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
              labelColor: Colors.white60,
              borderColor: AppColors.transparent,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.sp,
                  crossAxisSpacing: 12.sp,
                  childAspectRatio: 198 / 279,
                ),
                itemCount: _hasMore ? _movies.length + 1 : _movies.length,
                itemBuilder: (context, index) {
                  if (index == _movies.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return MoviePosterCard(movie: _movies[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
