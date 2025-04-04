import 'package:flutter/material.dart';
import 'package:tmdb/core/entities/common/genre_entity.dart';

class DetailsGenresWidget extends StatelessWidget {
  final List<GenreEntity> genres;

  const DetailsGenresWidget({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Text(genres[index].name,
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 10,
            );
          },
          itemCount: genres.length),
    );
  }
}
