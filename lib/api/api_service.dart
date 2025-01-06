import 'dart:convert';
import 'package:movies/api/api.dart';
import 'package:movies/api/api_end_points.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/review.dart';

class ApiService {
  // Obté una llista de les pel·lícules millor valorades (top rated) des de l'API.
  static Future<List<Movie>?> getTopRatedMovies() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse('${Api.baseUrl}movie/top_rated?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].skip(6).take(5).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  // Obté una llista dels actors més populars de l'API. Si `principal` és cert, agafa els primers 9, sinó els següents 9.
  static Future<List<Actor>?> getPopularActors(bool principal) async {
    List<Actor> actors = [];
    List<Actor> infoAc = [];
    try {
      http.Response response = await http.get(Uri.parse('${Api.baseUrl}${ApiEndPoints.popularPeople}?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      if (principal) {
        res['results'].take(9).forEach(
          (m) => actors.add(
            Actor.fromMap(m),
          ),
        );
      } else {
        res['results'].skip(9).take(9).forEach(
          (m) => actors.add(
            Actor.fromMap(m),
          ),
        );
      }
      for (var actor in actors) {
        try {
          Actor? actorInfo = await getActors(actor.id.toString());
          infoAc.add(actorInfo!);
        } catch (e) {}
      }
      return infoAc;
    } catch (e) {
      return null;
    }
  }

  // Obté una llista d'actors que estan actualment en tendència (trending actors).
  static Future<List<Actor>?> getTrendingActors() async {
    List<Actor> actors = [];
    List<Actor> infoAc = [];
    try {
      http.Response response = await http.get(Uri.parse('${Api.baseUrl}${ApiEndPoints.popularTrending}?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].take(9).forEach(
        (m) => actors.add(
          Actor.fromMap(m),
        ),
      );
      for (var actor in actors) {
        try {
          Actor? actorInfo = await getActors(actor.id.toString());
          infoAc.add(actorInfo!);
        } catch (e) {}
      }
      return infoAc;
    } catch (e) {
      return null;
    }
  }

  // Obté la informació detallada d'un actor a partir del seu ID.
  static Future<Actor?> getActors(String id) async {
    Actor actor;
    try {
      http.Response response = await http.get(Uri.parse('${Api.baseUrl}${getPersonDetailsUrl(id)}?api_key=${Api.apiKey}&language=en-US&page=1'));
      actor = Actor.fromJson(response.body);
      return actor;
    } catch (e) {
      return null;
    }
  }

  // Obté una llista de pel·lícules personalitzades basades en un URL específic.
  static Future<List<Movie>?> getCustomMovies(String url) async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse('${Api.baseUrl}movie/$url'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  // Busca pel·lícules a partir d'una consulta de text.
  static Future<List<Movie>?> getSearchedMovies(String query) async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=${Api.apiKey}&language=en-US&query=$query&page=1&include_adult=false'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  // Busca actors a partir d'una consulta de text.
  static Future<List<Actor>?> getSearchedActors(String query) async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/person?language=en-US&api_key=${Api.apiKey}&include_adult=false&query=$query'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (m) => actors.add(
          Actor.fromMap(m),
        ),
      );
      return actors;
    } catch (e) {
      return null;
    }
  }

  // Obté una llista de pel·lícules en les quals un actor ha participat, donat el seu ID.
  static Future<List<Movie>?> getActorMoviesId(String id) async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}${getPersonDetailsUrl(id)}/movie_credits?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['cast'].forEach(
        (m) {
          movies.add(
            Movie.fromMap(m),
          );
        },
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  // Obté una llista de ressenyes d'una pel·lícula donat el seu ID.
  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (r) {
          reviews.add(
            Review(
                author: r['author'],
                comment: r['content'],
                rating: r['author_details']['rating']),
          );
        },
      );
      return reviews;
    } catch (e) {
      return null;
    }
  }

  // Genera la URL per obtenir detalls d'una persona a partir del seu ID.
  static getPersonDetailsUrl(String personId) {
    return ApiEndPoints.personDetails.replaceAll("{person_id}", personId);
  }
}
