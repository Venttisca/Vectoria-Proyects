import ddf.minim.*; //<>//
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
AudioPlayer temaBatalla;

  import cc.arduino.*;
  import org.firmata.*;
  import processing.serial.*;
  
  //Aqui se configura la carga de archivos
    //Carga de imagenes
    PImage imagenMenu;
    
    
    
  //Aqui se configuran los inputs 
  int entradaDerecha;
  int entradaIzquierda;
  int entradaArriba;
  int entradaAbajo;
  int entradaAceptar;
  int entradaRechazar;
  
//Configuraci[on de ejecuci[on
  int intervalo = 16;//milisegundos
  int tiempoAnterior = 0;
  int selectorEscena = 0; // 0 menu, 1 Juego, 2 muerte
  int ajusteTime = 0;// Esto es para corregir timing en general
  //Ajuste de timing para Thinkpad: 80
//Configuracion de escenas
  boolean primeraAccionJuego = true;
  boolean primeraAccionMenu  = true;
  int tiempoJuego = 0;// esto cuenta los fotogramas que han pasado
  
//Aqui van los dialogos que se van a mostrar
  String[] Dialogos1 = {
  "Usa WASD para moverte" , 
  "Mision final: Mata a Dios", 
  "Sin lectura",
  "Colision",
  "Game Over",
};

//Datos para el juego
  int numDialogo1 = 0; //Esto controla el dialogo que se nuestra
  int numDialogo2 =2;
  int JugadorX = 500, JugadorY = 500; //Estas son las cordenadas del jugador
  int velocidadJugador = 4;
  int velocidadProyectil1 = 2;
  
  // Barra de vida
  int salud = 1000;
  boolean impactoJugador;
  int coldownDanioRecibido = 1; // esta variable se encarga de almacenar el coldown
  int coldown = 5; //el tiempo q se le asigna al coldown de danio cada vez q se reincia
  int ultimoAtaque = 100;// Esto es para las pruebas
  
  //Datos de enemigo
  ArrayList<Proyectil> proyectiles;
  //int posX=0 , posY=0;
  int posXEnemy1 = 0, posYEnemy1 = 0;
  int posXEnemy2 = 0, posYEnemy2 = 0;  //Hay que hacer una variable de estas para cada enemigo, si no todos los proyectiles siguen la misma trayectoria
  Proyectil proyectilDePrueba;//Esto crea el objeto de proyectil
  int prueba1 = 50, prueba2 = 250;
//Datos de lectura
  String movDerecha = "Sin leer", movIzquierda = "Sin leer", movArriba = "Sin leer", movAbajo = "Sin leer";
  
  
  //Esta funcion prepara el juego para iniciar de 0 luego de morir
  void valoresOriginalesJuego(){
    JugadorX = 500; JugadorY = 500; //Resetear la posici[on del jugador
    //posX = 0; posY = 0; //Resetear la posici[on de los enemigos
    
    primeraAccionJuego = false;
  }
  
  //Arduino arduino;
void setup() {
  size(1000,1000);
  background(#110025);
  //Carga de documentos
  imagenMenu = loadImage("PortadaDelJuego.jpg");
  proyectilDePrueba = new Proyectil(0,0,20,40, color(#E0E0E0));
  proyectiles = new ArrayList<Proyectil>();
  
  //Minim
    //Carga de audio
    minim = new Minim(this);
    temaBatalla = minim.loadFile("TrueLove.mp3");
    
    
  
  //Arduino
  /*
  arduino = new Arduino(this,Arduino.list()[1],57600);
 
  
  arduino.pinMode(5,Arduino.INPUT_PULLUP);
  arduino.pinMode(6,Arduino.INPUT_PULLUP);
  arduino.pinMode(7,Arduino.INPUT_PULLUP);
  arduino.pinMode(9,Arduino.INPUT_PULLUP);
  arduino.pinMode(10,Arduino.INPUT_PULLUP);
  arduino.pinMode(11,Arduino.INPUT_PULLUP);
  */
}
  

  
  //Esto regresa los valores a 0 al soltar una tecla
  /* Se coloco pq si no las teclas se siguen leyendo como presionadas a menos que se
  suelten todas, esto reinica la lectura de los valores cada vez que se suelta una tecla*/
  void keyReleased() {
    valoresOriginalesEntrada();
  }
  
  
  void draw() {
   // int tiempoActual = millis();
   // if(tiempoActual - tiempoAnterior >= intervalo) {
     
     //Lectura de arduino
      
        //valoresOriginalesEntrada();
        if(primeraAccionJuego == true){
          valoresOriginalesJuego();
        }
        
        background(#110025);
      
        
      if (keyPressed) { // esto se acaiva cuando culquier tecla es presionada
      
        if (key == 'a' || key == 'A'){
          entradaIzquierda = 1;
        }
        else{
         //valoresOriginalesEntrada();
        }
        if (key == 'd' || key == 'D'){
          entradaDerecha = 1;
        }
        else{
          //valoresOriginalesEntrada();
        }
        if (key == 'w' || key == 'W'){
          entradaArriba = 1;
        }
        else{
          //valoresOriginalesEntrada();
        }
        if (key == 's' || key == 'S'){
          entradaAbajo  = 1;
        }
        else{
          //valoresOriginalesEntrada();
        }
        if (key == 'z' || key == 'Z'){
          entradaAceptar = 1;
          
        }
        
          
        if (key == 'x' || key == 'X'){
          entradaRechazar = 1;
          numDialogo1 = 1;
       }
       
        
      }
      
      //Lectura de botones Arduino
      /*
      if(arduino.digitalRead(1) == 0){
        entradaArriba = 1;
      }
      if(arduino.digitalRead(2) == 0){
        entradaAbajo = 1;
      }
      if(arduino.digitalRead(3) == 0){
        entradaIzquierda = 1;
      }
      if(arduino.digitalRead(4) == 0){
        entradaDerecha = 1;
      }
      if(arduino.digitalRead(5) == 0){
        entradaAceptar = 1;
      }
      if(arduino.digitalRead(6) == 0){
        entradaRechazar = 1;
      }
      */
      
      
      else{
        valoresOriginalesEntrada();
        
      }
      
        
        
        
        //Selector de escenas
          //Escena de Game Over
        if(salud == 0) {
          println("Ejecutando escenaMuerte");
          selectorEscena = 2;
          escenaMuerte();
        }
        
        else if(selectorEscena == 0){
          println("Ejecutando escenaMenu");
          selectorEscena = 0;
          escenaMenu();
        }
        else if (selectorEscena == 1 ){
          escenaJuego();
          
        }
        
        
        //Maquina de estados
        impactoJugador = false;
        delay(16);
  //        tiempoAnterior = tiempoActual;
  //}//cierre de la actualizacion controlada
    
  }
  
  
  
  //Herramienta de Creaci[on de texto
  void texto(String lectura, int posX, int posY, int size){
    textSize(size);
    fill(#E0E0E0);
    text(lectura,posX,posY);
  }
  
  void valoresOriginalesEntrada(){
    entradaIzquierda = 0;
    entradaDerecha   = 0;
    entradaArriba    = 0;
    entradaAbajo     = 0;
    entradaAceptar   = 0;
    entradaRechazar  = 0;
    numDialogo1      = 0;
    
    
  }
  
  
  //Configuraci[on de proyectiles

  
  // Creaci[on de la clase de proeyctilles
  class Proyectil {
    int posX, posY;
    int tamanioX;
    int tamanioY;
    color colorProyectil;
    public int radio;
    
    Proyectil(int posX, int posY, int tamanioX, int tamanioY, color colorProyectil) {
      this.posX = posX;
      this.posY = posY;
      this.tamanioX = tamanioX;
      this.tamanioY = tamanioY;
      this.colorProyectil = colorProyectil;
    }
    
    void movimientoRadialDentro(int posX, int posY, int radius, int velocidad) {
      fill(colorProyectil);
      
      if (radio == 0){
        radio = radius;
      }
      if (radio > 2){
        radio -= velocidad;
      }
      
      noStroke();
      this.posX = posX;
      this.posY = posY;
      rect(posX,posY,tamanioX,tamanioY);
      
    }
    void movimientoRadialFuera(int posX, int posY, int radius, int velocidad) {
      fill(colorProyectil);
      
      if (radio < 1500 && radio <= radius){
        radio += velocidad;
      }
      
      noStroke();
      this.posX = posX;
      this.posY = posY;
      rect(posX,posY,tamanioX,tamanioY);
      
    }
    int getRadio() {
      return radio;
    }
    
    void movimiento(int posInicialX, int posInicialY, int destinoX,
    int destinoY, int velocidad ){
          
        
       if(posX == 0){
         
         posX = posInicialX;
       }
       if(posY == 0) {
         posY = posInicialY;
       }
      
        if(posX >0){
          
        }
        //Esto se encarga de acercarse uniformemente a las coordenadas del destino
        if(destinoX > posX){
          posX = posX + velocidad;
        }
        if(destinoX < posX){
          posX = posX - velocidad;
        }
        
        if(destinoY > posY){
          posY = posY + velocidad;
        }
        if(destinoY < posY){
          posY = posY - velocidad;
        }
        
        fill(#E0E0E0);
        rect(posX,posY,tamanioX,tamanioY);
        
        println("enemigo X: " + posX);
        println("enemigo Y: " + posY);
      }
      
      void collisionDetected(){
        println("iniciando deteccion de colision");
        if(collision(posX,posY,posX + tamanioX,posY + tamanioY,JugadorX, JugadorY,JugadorX + 50, JugadorY + 50)){//SI hay impacto se ejecuta esto
          
          numDialogo2 = 3;
          impactoJugador = true;
          println("primera afirmaci[on de danio");
          if(coldownDanioRecibido == 0){
            coldownDanioRecibido = coldown;
          }
          
        }
        else{
          numDialogo2 = 2;
        }
      }
  }
    
    
    
  
  //Esta funcio recibe las coordenadas de algo y comprueba si est[an colisionando
  
  boolean collision(int entradaPosX, int entradaPosY, int entradaTamanioX, int entradaTamanioY, 
  int hitPosX, int hitPosY, int hitTamanioX, int hitTamanioY){
    //los primero 4 valores son del objeto que se a leer, representan 
    
    
    if((entradaPosX > hitPosX && entradaPosX < hitTamanioX)&&
    (entradaPosY > hitPosY && entradaPosY < hitTamanioY)){
      println("impacto confirmado: esquina superior izquierda");
      return true;
    }//esquina superior izquierda
    else if((entradaTamanioX > hitPosX && entradaTamanioX < hitTamanioX)&&
    (entradaTamanioY > hitPosY && entradaTamanioY < hitTamanioY)){
      println("impacto confirmado: esquina inferior derecha");  // NO FUNCIONA
      return true;
    }//esquina inferior derecha
    else if((entradaPosX > hitPosX && entradaPosX < hitTamanioX)&&
    (entradaTamanioY > hitPosY && entradaTamanioY < hitTamanioY)){
      println("impacto confirmado: esquina inferior izquierda");
      return true;// esquina inferior izquierda
    }
    else if((entradaTamanioX > hitPosX && entradaTamanioX < hitTamanioX)&&
    (entradaPosY > hitPosY && entradaPosY < hitTamanioY)){
      println("impacto confirmado: esquina superior derecha");
      return true;//esquina superior derecha
    }
    else{
      println("Sin contacto");
      return false;
    }
  }
  
  //Esta funcion se encarga de guardar y mostrar los valores de la barra de vida
  void barraDeVida(){
    if(impactoJugador == true && coldownDanioRecibido == 0){
      if(salud > 0){
      salud -= 100;
      println("Restando salud");
      }
    }
    fill(#E0E0E0);
    rect(200,850,salud/2,50);
    
    println("Barra de vida: " + salud);
  }
  
  void escenaMuerte() {
    temaBatalla.pause();
    temaBatalla.rewind();
    
    background(#110025);
    fill(#110025);
    stroke(#E0E0E0);
    strokeWeight(10);
    rect(100,100,800,500);// Esto ser[a remplazado con la imagen del game over
    
    texto(Dialogos1[4],400,300,40);// "Game over"
    texto("No pierdas la determinaci[on _inserteNick_ ",200,650,30);
    texto("tu puedes derrotar a _inserteBossName_",200,700,30);
    texto("Pulsa z para revivir", 300,800,30);
    texto("Pulsa x para volver al menu",300, 820,30);
    if(entradaAceptar == 1) {
      salud = 1000;
      tiempoJuego = 0;
      selectorEscena = 1;//Escena de Juego
      eliminarTodosProyectiles();
    }
    if(entradaRechazar == 1) {
      salud = 1000;
      tiempoJuego = 0;
      selectorEscena = 0;//Escena Menu
      eliminarTodosProyectiles();
      
      
    }
  }
  
  void escenaMenu(){
    background(#110025);
    fill(#110025);
    stroke(#E0E0E0);
    strokeWeight(10);
    rect(50,50,900,800);//Esto ser[ia remplazado por la imagen de portada del juego
    image(imagenMenu,50,50,900,800);
    
    texto("Pulsa z para inciar", 400,700,40);
    if(entradaAceptar == 1) {
    selectorEscena = 1;
    eliminarTodosProyectiles();
    valoresOriginalesJuego();
    }
  }
  void escenaJuego() {
        //Caja de Batalla
        tiempoJuego++;
        
        //control de musica
        
        fill(#110025);
        stroke(#E0E0E0);
        strokeWeight(10);
        int anchoCajaB = 500;
        int altoCajaB  = 400;
        rect(250,400,anchoCajaB,altoCajaB);
        
        
        
        //Jugador
        fill(#E0E0E0);
        noStroke();
        rect(JugadorX,JugadorY,50,50);
        
        //Proyectil de Prueba, comdddddentar al finalizar pruebas
          /*
        proyectilDePrueba.dibujar();
        proyectilDePrueba.movimiento(200,100,JugadorX,JugadorY);
        proyectilDePrueba.collisionDetected();
          */
        
        //Creacion de Proyectiles
        if(tiempoJuego == 10){
        crearProyectiles(10,20,40); // Horizontales 0-9
        crearProyectiles(10,20,40); // Verticales 10-19
        crearProyectiles(20,20,20);// Radiales centro 20-39
        }
        //Reproducci[on de audio
        if(tiempoJuego == 9) {
          temaBatalla.rewind();
          temaBatalla.play();
        }
        
        
   //Movimiento de los proyectiles
   
        //            PRIMERA MITAD
        
        moverMultiProyectilHorizontal(10,370,0,9,1,100,0,300,1100,2);
        moverMultiProyectilHorizontal(ajusteTime + 360,ajusteTime + 800,5,9,1,100,0,110,0,2);
        moverMultiProyectilHorizontal(ajusteTime + 600,ajusteTime + 850,0,4,1,100,0,1100, -100,8);
        moverMultiProyectilVertical(ajusteTime + 750,ajusteTime + 850,10,19,1,100,10,0,1000,9);
        moverMultiProyectilHorizontal(ajusteTime + 850,ajusteTime + 1000,0,9,1,100,0,-50,1050,10);
        moverMultiProyectilVertical(ajusteTime + 900,ajusteTime + 1000,10,19,1,100,10,1000,0,10);
        moverMultiProyectilVertical(ajusteTime + 1000,ajusteTime + 1200,10,18,2,100,10,0,1000,10);
        moverMultiProyectilVertical(ajusteTime + 1050,ajusteTime + 1200,11,19,2,100,10,0,1000,10);
        moverMultiProyectilVertical(ajusteTime + 1200,ajusteTime + 1300,10,18,2,100,10,1000,0,15);
        moverMultiProyectilVertical(ajusteTime + 1230,ajusteTime + 1320,11,19,2,100,10,1000,0,15);
        moverMultiProyectilVertical(ajusteTime + 1300,ajusteTime + 1500,10,18,2,100,10,0,1000,5);
        moverMultiProyectilVertical(ajusteTime + 1320,ajusteTime + 1520,11,19,2,100,10,0,1000,5);
      /*moverMultiProyectilHorizontal(inicio,fin,primero,ultimo,incremento,espaciado,restI,posY,destinoY,velocidad)*/
        moverMultiProyectilRadialDentro(ajusteTime + 1500,ajusteTime + 1600,20,29,500,500,400,2);
        moverMultiProyectilRadialDentro(ajusteTime + 1600,ajusteTime + 1650,20,29,500,500,400,4);
        moverMultiProyectilRadialFuera(ajusteTime + 1650, ajusteTime + 1800,20,29,500,500,300,4);
        
        //moverMultiProyectilHorizontal(ajusteTime + 1650,ajusteTime + 1800,11,19,1,100,10,0,1000,0);
        
        
        moverMultiProyectilRadialDentro(ajusteTime + 1800 ,ajusteTime + 2000,25,29,500,500,300,2);
        moverMultiProyectilRadialFuera(ajusteTime + 1800, ajusteTime + 2000,20,24,500,500,500,4);
        moverMultiProyectilRadialDentro(ajusteTime + 2000, ajusteTime + 2100,20,29,500,500,300,10);
        moverMultiProyectilRadialFuera(ajusteTime + 2000, ajusteTime + 2100,30,39,500,500,300,6);
        //moverMultiProyectilRadialDentro(inicio,fin,primero,ultimo,centroX,centroY,radio,velocidad)
        moverMultiProyectilHorizontal(ajusteTime + 2000,ajusteTime + 2100,0,9,1,100,0,1050, 2,0);
        moverMultiProyectilHorizontal(ajusteTime + 2100,ajusteTime + 2300,0,9,1,100,0,1050, 2,5);
        moverMultiProyectilVertical(ajusteTime + 2200,ajusteTime + 2250,11,19,2,100,10,0,1000,8);
        moverMultiProyectilVertical(ajusteTime + 2250,ajusteTime + 2400,11,19,2,100,10,1000,0,8);
        moverMultiProyectilVertical(ajusteTime + 2200,ajusteTime + 2250,12,18,2,100,10,1000,0,1000);
        moverMultiProyectilVertical(ajusteTime + 2250,ajusteTime + 2400,12,18,2,100,10,0,1000,8);
        
        //AQUI VA EL SILENCIO: DIALGO DEL ENEMIGO
        if(tiempoJuego > 2500 && tiempoJuego <3100){
          texto("Dialogo del enemigo",250,200,60);
        }
        
        //                        SEGUNDA MITAD: ATAQUE VELOZ
        moverMultiProyectilHorizontal(3150 + ajusteTime,3500 + ajusteTime,0,9,1,100,0,300,1100,4);
        moverMultiProyectilRadialFuera(ajusteTime + 3550, ajusteTime + 4000,20,28,480,580,150,8);
        
        //Movimiento del jugador
        if(entradaIzquierda == 1 && JugadorX > 250){//Movimiento a la izquierda
          JugadorX -= velocidadJugador;
          movIzquierda = "Activo";
          
        }
        else{
          movIzquierda = "Suspendido";
        }
        if(entradaDerecha == 1 && JugadorX < 700){//Movimiento a la derecha
          JugadorX += velocidadJugador;
          movDerecha = "Activo";
        }
        else{
          movDerecha = "Suspendido";
        }
        if(entradaArriba == 1 && JugadorY > 400){//Movimiento hacia arriba
          JugadorY -= velocidadJugador;
          movArriba = "Activo";
        }
        else{
          movArriba = "Suspendido";
        }
        if(entradaAbajo == 1 && JugadorY < 750){//Moviemiento hacia abajo
          JugadorY += velocidadJugador;
          movAbajo = "Activo";
        }
        else{
          movAbajo = "Suspendido";
        }
        
        
        
        //proyectiles   
        
        
        
        
       
        
        
        //Detecci[on de impactos al jugador
        //todas las acciones relacionadas deben ir debajo de esta funcion
        
        //ColdownDanioJugador
        if(coldownDanioRecibido > 0){
          coldownDanioRecibido--;
        }
        println("coldownDanioRecibido: " + coldownDanioRecibido);
        barraDeVida();
        
        //texto(Dialogos1[0],50,200);
      
       texto(Dialogos1[numDialogo1],40,100,20);// Dibujado de texto
       texto(Dialogos1[numDialogo2],150,150,30);//confirmaci[on de impato
       
       //Prints para la consola
        println("entradaIzquierda " + entradaIzquierda + " Estado: " + movIzquierda);
        println("entradaDerecha   " + entradaDerecha +  " Estado: " + movDerecha);
        println("entradaArriba    " + entradaArriba +    " Estado: " + movArriba);
        println("entradaAbajo     " + entradaAbajo +     " Estado: " + movAbajo);
        
        println("numDialogo1 " + numDialogo1);
        println("JugadorX " + JugadorX);
        println("JugadorY " + JugadorY);
        println("Tiempo de Juego: " + tiempoJuego);
        
   }
   
   void crearProyectiles(int cantidad, int tamanioX, int tamanioY){
     for (int i = cantidad; i>0; i--){
          proyectiles.add(new Proyectil(0,0,tamanioX,tamanioY,color(#E0E0E0)));
        }
   }
   
   void eliminarTodosProyectiles(){
     proyectiles.clear();
   }
   
   void moverMultiProyectilHorizontal(int inicio, int fin, int primero, int ultimo, int incremento, int espaciado,
   
   int restaI, int posY, int destinoY, int velocidad) {
        if(tiempoJuego > inicio && tiempoJuego < fin) {
          for(int i = primero; i<= ultimo; i+= incremento){
            Proyectil p = proyectiles.get(i);
            
            int incrementoE = (i - restaI) * espaciado;
            p.movimiento(incrementoE,posY, incrementoE, destinoY,velocidad);
            p.collisionDetected();
          }
        }
     }
    
   void moverMultiProyectilVertical(int inicio, int fin, int primero, int ultimo, int incremento, int espaciado, 
   int restaI,int posX, int destinoX, int velocidad) {
        if(tiempoJuego > inicio && tiempoJuego < fin) {
          for(int i = primero; i<= ultimo; i+= incremento){
            Proyectil p = proyectiles.get(i);
            
            int incrementoE = (i - restaI) * espaciado;
            p.movimiento(posX, incrementoE, destinoX,incrementoE,velocidad);
            p.collisionDetected();
          }
        }
     }
   void moverMultiProyectilRadialDentro(int inicio, int fin, int primero, int ultimo, int centroX, int centroY,
int radio, int velocidad) {
  int numProyectiles = ultimo - primero + 1;
  if(tiempoJuego > inicio && tiempoJuego < fin){
    for (int i = primero; i <= ultimo; i++) {
      Proyectil p = proyectiles.get(i);
      // Convertimos la iteración en un ángulo
      PVector center = new PVector(centroX, centroY);
      float angle = TWO_PI / numProyectiles * (i - primero);      
      // Calculamos la posición del proyectil
      float radius = (float)p.getRadio();
      float x = center.x + cos(angle) * radius;
      float y = center.y + sin(angle) * radius;
      int posX = (int) Math.floor(x);
      int posY = (int) Math.floor(y);
      
      // Dibujamos el proyectil
      
      p.movimientoRadialDentro(posX,posY, radio, velocidad);
      p.collisionDetected();
    }
    
  }
}
   void moverMultiProyectilRadialFuera(int inicio, int fin, int primero, int ultimo, int centroX, int centroY,
int radio, int velocidad) {
  int numProyectiles = ultimo - primero + 1;
  if(tiempoJuego > inicio && tiempoJuego < fin){
    for (int i = primero; i <= ultimo; i++) {
      Proyectil p = proyectiles.get(i);
      // Convertimos la iteración en un ángulo
      PVector center = new PVector(centroX, centroY);
      float angle = TWO_PI / numProyectiles * (i - primero);      
      // Calculamos la posición del proyectil
      float radius = (float)p.getRadio();
      float x = center.x + cos(angle) * radius;
      float y = center.y + sin(angle) * radius;
      int posX = (int) Math.floor(x);
      int posY = (int) Math.floor(y);
      
      // Dibujamos el proyectil
      
      p.movimientoRadialFuera(posX,posY, radio, velocidad);
      p.collisionDetected();
    }
    
  }
}
