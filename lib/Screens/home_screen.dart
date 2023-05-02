import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/Color/theme_manager.dart';
import 'package:flutter_movies/Constant/constant.dart';
import 'package:flutter_movies/Screens/movie_detail_screen.dart';
import 'package:flutter_movies/Utils/text_form_field_decoration.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../API/fetch_movies.dart';
import '../API/fetch_searched_movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  final TextEditingController _searchController = TextEditingController();
  final focusNode = FocusNode();

  List moviesList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          child: isSearch
              ? TextFormField(
                  controller: _searchController,
                  focusNode: focusNode,
                  autofocus: true,
                  decoration:
                      textFormFieldInputDecoration(context: context).copyWith(
                    hintText: 'Search movies..',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white70,
                        ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                )
              : Text(
                  'Movies',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
                if (!isSearch) {
                  FocusScope.of(context).requestFocus(focusNode);
                } else {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              });
            },
            icon: Icon(
              isSearch ? Icons.close : Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<ThemeNotifier>().changeTheme();
            },
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.sunny
                  : Icons.dark_mode,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            !isSearch ? fetchMovies() : searchMovies(_searchController.text),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            moviesList = snapshot.data;
            return SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: moviesList.length,
                itemBuilder: (context, index) {
                  return itemCard(moviesList[index]);
                },
              ),
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

  Widget itemCard(movieData) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailScreen(
                      movieId: movieData['id'].toString(),
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '$imagePath${movieData['poster_path']}',
                height: height * 0.17,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: height * 0.17,
                    width: width * 0.23,
                    color: Colors.white10,
                  );
                },
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            SizedBox(
              width: width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieData['title'] ?? 'N/A',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text.rich(TextSpan(
                      text: 'Release date: ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '${movieData['release_date'] ?? 'N/A'}',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                        )
                      ])),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: (movieData['vote_average'] ?? 0 / 2),
                        minRating: 0,
                        maxRating: 5,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 13,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 13,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Text(
                        ' ${movieData['vote_average'] ?? 'N/A'}/10',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.amber,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
