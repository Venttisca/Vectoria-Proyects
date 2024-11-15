
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
  
//Configuracion de escenas
  boolean primeraAccionJuego = true;
  
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
  int velocidadProyectil1 = 1;
  
  // Barra de vida
  int salud = 1000;
  boolean impactoJugador;
  int coldownDanioRecibido = 1; // esta variable se encarga de almacenar el coldown
  int coldown = 5; //el tiempo q se le asigna al coldown de danio cada vez q se reincia
  int ultimoAtaque = 100;// Esto es para las pruebas
  
  //Datos de enemigo
  int posX=0 , posY=0;
  
  int prueba1 = 50, prueba2 = 250;
//Datos de lectura
  String movDerecha = "Sin leer", movIzquierda = "Sin leer", movArriba = "Sin leer", movAbajo = "Sin leer";
  
  
  //Esta funcion prepara el juego para iniciar de 0 luego de morir
  void valoresOriginalesJuego(){
    JugadorX = 500; JugadorY = 500; //Resetear la posici[on del jugador
    posX = 0; posY = 0; //Resetear la posici[on de los enemigos
    
    primeraAccionJuego = false;
  }
  
void setup() {
  size(1000,1000);
  background(#110025);
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
      else{
        valoresOriginalesEntrada();
        
      }
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
        
        if (salud > 0) {
        //Caja de Batalla
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
        proyectilStandar1(prueba1, prueba2, 20,40,JugadorX,JugadorY);
        
        //Detecci[on de impactos al jugador
        //todas las acciones relacionadas deben ir debajo de esta funcion
        if(collision(posX,posY,posX + 20,posY + 40,JugadorX, JugadorY,JugadorX + 50, JugadorY + 50)){//SI hay impacto se ejecuta esto
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
        //ColdownDanioJugador
        if(coldownDanioRecibido > 0){
          coldownDanioRecibido--;
        }
        println("coldownDanioRecibido: " + coldownDanioRecibido);
        barraDeVida();
        
   }//tEMPORAL
        
        
        //Selector de escenas
          //Escena de Game Over
        if(salud == 0) {
          println("Ejecutando escenaMuerte");
          escenaMuerte();
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
  void proyectilStandar1(int posInicialX, int posInicialY, int tamanioX, int tamanioY, int destinoX,
    int destinoY){
      
    
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
      posX = posX + velocidadProyectil1;
    }
    if(destinoX < posX){
      posX = posX - velocidadProyectil1;
    }
    
    if(destinoY > posY){
      posY = posY + velocidadProyectil1 ;
    }
    if(destinoY < posY){
      posY = posY - velocidadProyectil1;
    }
    
    fill(#E0E0E0);
    rect(posX,posY,tamanioX,tamanioY);
    
    println("enemigo X: " + posX);
    println("enemigo Y: " + posY);
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
    background(#110025);
    fill(#110025);
    stroke(#E0E0E0);
    strokeWeight(10);
    rect(100,100,800,500);// Esto ser[a remplazado con la imagen del game over
    
    texto(Dialogos1[4],400,300,40);// "Game over"
    texto("No pierdas la determinaci[on _inserteNick_ ",200,650,30);
    texto("tu puedes derrotar a _inserteBossName_",200,700,30);
    texto("Pulsa z para revivir", 300,800,30);
    if(entradaAceptar == 1) {
      salud = 1000;
      primeraAccionJuego = true;
    }
  }
    
    
