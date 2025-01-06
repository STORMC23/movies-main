class ApiEndPoints {
  // Ruta per obtenir una llista de productes (context no clar, potser d'una altra funcionalitat)
  static const products = "products";

  // Rutes de pel·lícules
  static const popularMovies = "movie/popular";
  static const upcomingMovies = "movie/upcoming";
  static const getGenreList = "genre/movie/list";

  // Rutes de cerca i detalls de persones (actors/actrius)
  static const personDetails = "person/{person_id}"; // Detalls d'una persona específica
  static const popularPeople = "person/popular"; // Llista de persones populars (actors/actrius)
  static const popularTrending = "trending/person/day";
}
