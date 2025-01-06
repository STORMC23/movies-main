import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/details_screen_actor.dart';
import 'package:movies/widgets/index_number.dart';

// Aquest codi defineix el widget `TopRatedActor`, que mostra els actors més ben valorats en una vista en graella.
// El widget conté una imatge de l'actor que es carrega dinàmicament des d'una URL i una animació de càrrega utilitzant `FadeShimmer`.
// Quan l'usuari fa clic en una imatge, es redirigeix a la pantalla de detall de l'actor a través de la funció `Get.to`.
// També es mostra un número d'índex per cada actor, indicant la seva posició en la llista.

class TopRatedActor extends StatelessWidget {
  const TopRatedActor({
    super.key,
    required this.actor,
    required this.index,
  });

  final Actor actor;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.to(
            DetailsScreenActor(actor: actor),
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                Api.imageBaseUrl + actor.profile_path,
                fit: BoxFit.cover,
                height: 250,
                width: 180,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  size: 180,
                ),
                loadingBuilder: (_, __, ___) {
                  // ignore: no_wildcard_variable_uses
                  if (___ == null) return __;
                  return const FadeShimmer(
                    width: 180,
                    height: 250,
                    highlightColor: Color(0xff22272f),
                    baseColor: Color(0xff20252d),
                  );
                },
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: IndexNumber(number: index),
        )
      ],
    );
  }
}
