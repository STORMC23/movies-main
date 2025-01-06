import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

// Aquest codi defineix el controlador `ActorController` utilitzant GetX, una eina de gestió d'estat a Flutter. 
// Aquest controlador s'encarrega de gestionar l'estat relacionat amb actors populars i la llista de seguiment (watch list).
// Conté funcionalitats per carregar la llista d'actors populars, verificar si un actor està en la watch list, 
// i afegir o eliminar actors de la watch list. També mostra notificacions (snackbars) per confirmar aquestes accions.

class ActorController extends GetxController {
  var isLoading = false.obs;
  var popularPeople = <Actor>[].obs;
  var watchListActor = <Actor>[].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    popularPeople.value = (await ApiService.getPopularActors(true))!;
    isLoading.value = false;
    super.onInit();
  }

  bool isInWatchList(Actor movie) {
    return watchListActor.any((m) => m.id == movie.id);
  }

  void addToWatchList(Actor movie) {
    if (watchListActor.any((m) => m.id == movie.id)) {
      watchListActor.remove(movie);
      Get.snackbar('Success', 'removed from watch list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    } else {
      watchListActor.add(movie);
      Get.snackbar('Success', 'added to watch list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    }
  }
}

