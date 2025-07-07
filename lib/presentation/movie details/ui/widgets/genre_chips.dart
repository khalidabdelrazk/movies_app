import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_styles.dart';

class GenresChips extends StatelessWidget {
  final List<String> genres;

  const GenresChips({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: genres
              .map(
                (genre) => Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF2B2B2B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                genre,
                style: AppStyles.lightRegular16.copyWith(fontSize: 14),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}
