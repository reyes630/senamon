// dart pub add dart_console -----> Instalar dart_console
class Jugador {
  String nombre;
  String email;
  int puntos;
  int victorias = 0;


  Jugador(this.nombre, this.email, this.puntos, this.victorias);

  @override
  String toString() {
    return 'Nombre: $nombre, Email: $email, Puntos: $puntos, victorias $victorias';
  }

  Jugador jugadorConMasVictorias(List<Jugador> jugadores) {
    if (jugadores.isEmpty) {
      throw Exception("La lista de jugadores está vacía.");
    }

    // Encontrar el jugador con más victorias
    Jugador jugadorTop = jugadores[0];
    for (Jugador jugador in jugadores) {
      if (jugador.victorias > jugadorTop.victorias) {
        jugadorTop = jugador;
      }
    }

    return jugadorTop;
  }

  void setPuntos (int puntosDisponibles) {
    puntos = puntosDisponibles;
  }
  int getPuntos(){
    return puntos;
  }

  
}
 
  

  
  
 

   
