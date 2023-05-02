import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../API/fetch_movie_detail.dart';
import '../Constant/constant.dart';
import '../Utils/language_code.dart';

class MovieDetailScreen extends StatelessWidget {
  String movieId;
  MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder(
        future: fetchMovieDetail(movieId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var movieData = snapshot.data;
            return Column(
              children: [
                Image.network(
                  '$imagePath${movieData['backdrop_path']}',
                  height: height * 0.44,
                  width: width,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              '$imagePath${movieData['poster_path']}',
                              height: height * 0.17,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          SizedBox(
                            width: width * 0.6,
                            // color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieData['title'] ?? 'N/A',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: 'Release date: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text:
                                            '${movieData['release_date'] ?? 'N/A'}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: 'Language: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: getLanguage(
                                            movieData['original_language'] ??
                                                'N/A'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating:
                                          movieData['vote_average'] ?? 0 / 2,
                                      minRating: 0,
                                      maxRating: 10,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 13,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 13,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    Text(
                                      ' ${movieData['vote_average'] ?? ''}/10',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Colors.amber,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Wrap(
                                  children: movieData['genres']
                                      .map<Widget>((f) => GestureDetector(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8.0),
                                              margin: const EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                //color: Colors.pinkAccent.shade200.withOpacity(0.6),
                                                color: Colors.white10,
                                                //border: Border.all(color: Color(0xFF282f61), width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Text(
                                                f['name'] ?? 'N/A',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 12.0,
                                                    ),
                                              ),
                                            ),
                                            onTap: () {},
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        'Tagline:',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        movieData['tagline'] ?? 'N/A',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        'Overview:',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        movieData['overview'] ?? 'N/A',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
