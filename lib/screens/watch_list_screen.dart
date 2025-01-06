import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/actor_controller.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/screens/details_screen.dart';
import 'package:movies/screens/details_screen_actor.dart';
import 'package:movies/widgets/actor_infos.dart';
import 'package:movies/widgets/infos.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(34.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Back to home',
                      onPressed: () =>
                          Get.find<BottomNavigatorController>().setIndex(0),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Watch list',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 33,
                      height: 33,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),

                
                DefaultTabController(
                  length: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TabBar(
                          indicatorWeight: 4,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Color(
                            0xFF3A3F47,
                          ),
                          tabs: [
                            Tab(text: 'Movies'),
                            Tab(text: 'Actors'),
                          ]),
                      SizedBox(
                        height: 800,
                        child: TabBarView(
                          children: [
                            Column(
                              children: [
                                if (Get.find<MoviesController>().watchListMovies.isEmpty)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 200,
                                  ),
                                  Text(
                                    'No movies in your watch list',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ],
                              )
                              else
                            ...Get.find<MoviesController>().watchListMovies.map(
                                  (movie) => Column(
                                    children: [
                                      SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () => Get.to(DetailsScreen(movie: movie)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(16),
                                              child: Image.network(
                                                Api.imageBaseUrl + movie.posterPath,
                                                height: 180,
                                                width: 100,
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) => const Icon(
                                                  Icons.broken_image,
                                                  size: 180,
                                                ),
                                                loadingBuilder: (_, __, ___) {
                                                  // ignore: no_wildcard_variable_uses
                                                  if (___ == null) return __;
                                                  return const FadeShimmer(
                                                    width: 150,
                                                    height: 150,
                                                    highlightColor: Color(0xff22272f),
                                                    baseColor: Color(0xff20252d),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Infos(movie: movie)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                 if (Get.find<ActorController>().watchListActor.isEmpty)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 200,
                                  ),
                                  Text(
                                    'No Actors in your watch list',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ],
                              )
                              else
                            ...Get.find<ActorController>().watchListActor.map(
                                  (actor) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () => Get.to(DetailsScreenActor(actor: actor)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(16),
                                              child: Image.network(
                                                Api.imageBaseUrl + actor.profile_path,
                                                height: 180,
                                                width: 100,
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) => const Icon(
                                                  Icons.broken_image,
                                                  size: 180,
                                                ),
                                                loadingBuilder: (_, __, ___) {
                                                  // ignore: no_wildcard_variable_uses
                                                  if (___ == null) return __;
                                                  return const FadeShimmer(
                                                    width: 150,
                                                    height: 150,
                                                    highlightColor: Color(0xff22272f),
                                                    baseColor: Color(0xff20252d),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            ActorInfos(movie: actor)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            )                          
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
