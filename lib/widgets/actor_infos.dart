import 'package:flutter/material.dart';
import 'package:movies/models/actor.dart';

// Aquest codi defineix el widget `ActorInfos`, que s'utilitza per mostrar informació resumida d'un actor. 
// Les dades inclouen el nom de l'actor, la data de naixement i el lloc de naixement, 
// tot presentat amb un estil senzill i compacte. El disseny està optimitzat per ocupar un espai limitat, 
// amb mecanismes per gestionar textos llargs com l'ús de "ellipsis". Aquest widget es pot integrar fàcilment 
// dins d'altres components o llistes a l'aplicació.

class ActorInfos extends StatelessWidget {
  const ActorInfos({super.key, required this.movie});
  final Actor movie;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              movie.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //SvgPicture.asset('assets/Star.svg'),
                  Icon(Icons.celebration,color: Colors.white),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    movie.birthday,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Color(0xFFFF8700),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  //SvgPicture.asset('assets/Ticket.svg'),
                  Icon(Icons.place_rounded,color: Colors.white),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                     movie.place_of_birth,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
