import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/controllers/actor_controller.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/controllers/search_controller.dart';
import 'package:movies/widgets/search_box.dart';
import 'package:movies/widgets/tab_builderActo.dart';
import 'package:movies/widgets/top_rated_actor.dart';

// Aquest codi defineix el widget `HomeScreen`, que serveix com a pantalla principal de l'aplicació. 
// Aquí es combinen diversos elements per oferir una experiència rica i interactiva:
// - Barra de cerca: Permet als usuaris cercar pel·lícules o actors amb una funcionalitat personalitzada.
// - Actors més populars: Es mostra una llista horitzontal amb els actors més populars, generada dinàmicament amb dades del servidor.
// - Pestanyes (Tabs): Organitza contingut entre actors tendència i populars amb vista en graella. 

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final MoviesController moviesController = Get.put(MoviesController());
  final ActorController actorController = Get.put(ActorController());
  final SearchController1 searchController = Get.put(SearchController1());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 42,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'What do you want to watch?',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SearchBox(
              onSumbit: () {
                String search =
                    Get.find<SearchController1>().searchController.text;
                Get.find<SearchController1>().searchController.text = '';
                Get.find<SearchController1>().search(search);
                Get.find<BottomNavigatorController>().setIndex(1);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            const SizedBox(
              height: 34,
            ),
            Obx(
              (() => actorController.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 300,
                      child: ListView.separated(
                        itemCount: actorController.popularPeople.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(width: 24),
                        itemBuilder: (_, index) => TopRatedActor(
                            actor: actorController.popularPeople[index],
                            index: index + 1),
                      ),
                    )),
            ),
            DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TabBar(
                      indicatorWeight: 3,
                      indicatorColor: Color(
                        0xFF3A3F47,
                      ),
                      labelStyle: TextStyle(fontSize: 11.0), 
                      tabs: [
                        Tab(text: 'Trending'),
                        Tab(text: 'Popular'),
                      ]),
                  SizedBox(
                    height: 400,
                    child: TabBarView(children: [
                      TabBuilderActor(
                        future: ApiService.getTrendingActors(),
                      ),
                      TabBuilderActor(
                        future: ApiService.getPopularActors(false),
                      ),
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
