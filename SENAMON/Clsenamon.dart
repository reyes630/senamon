
class Senamon {
   //Clase con sus atributos
  String nombre;
  int nivel;
  String tipo;
  double peso;
  int puntosSalud;
  int nivelAtaque;
  int nivelEnergia;
  String descripcion;

//Constructor
  Senamon(this.nombre, this.nivel, this.tipo, this.peso, this.puntosSalud, this.nivelAtaque, this.nivelEnergia, this.descripcion);


  @override
  String toString() {
    return '$nombre, Nivel: $nivel, Tipo: $tipo, Peso: $peso, Ataque: $nivelAtaque, Velocidad: $nivelEnergia, Salud: $puntosSalud, Descripción: $descripcion';
  }

  void setNombre (String nombre) {
    this.nombre = nombre;
  }
  String getNombre(){
    return nombre;
  }

  void setnivel (int nivel) {
    this.nivel = nivel;
  }
  int getNivel(){
    return nivel;
  }

  void settipoSenamon (String tipo) {
    this.tipo = tipo;
  }
  String gettipoSenamon(){
    return tipo;
  }

  void setpeso (double peso) {
    this.peso = peso;
  }
  double getpeso(){
    return peso;
  }

  void setpuntosSalud (int puntosSalud) {
    this.puntosSalud = puntosSalud;
  }
  int getpuntosSalud(){
    return puntosSalud;
  }

  void setnivelAtaque (int nivelAtaque) {
    this.nivelAtaque = nivelAtaque;
  }
  int getnivelAtaque(){
    return nivelAtaque;
  }

  void setnivelEnergia (int nivelEnergia) {
    this.nivelEnergia = nivelEnergia;
  }
  int getnivelEnergia(){
    return nivelEnergia;
  }

  void setdescripcion (String descripcion) {
    this.descripcion = descripcion;
  }
  String getdescripcion(){
    return descripcion;
  }

  

  
}

