
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
  
//Aqui van los dialogos que se van a mostrar
  String[] Dialogos1 = {
  "Mision Inicial: Abre la puerta" , "Mision final: Mata a Dios", "Sin lectura","Colision",
};

//Datos para el juego
  int numDialogo1 = 0; //Esto controla el dialogo que se nuestra
  int numDialogo2 =3;
  int JugadorX = 500, JugadorY = 500; //Estas son las cordenadas del jugador
  int velocidadJugador = 3;
  int velocidadProyectil1 = 1;
  
  //Datos de enemigo
  int posX=0 , posY=0;
  
  int prueba1 = 50, prueba2 = 250;
//Datos de lectura
  String movDerecha = "Sin leer", movIzquierda = "Sin leer", movArriba = "Sin leer", movAbajo = "Sin leer";
  
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
    int tiempoActual = millis();
    if(tiempoActual - tiempoAnterior >= intervalo) {
      
        //valoresOriginalesEntrada();
        
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
        if (key == 'l' || key == 'L'){
          entradaAceptar = 1;
          
        }
        
          
        if (key == 'z' || key == 'Z'){
          entradaRechazar = 1;
          numDialogo1 = 1;
       }
       
        
      }
      else{
        valoresOriginalesEntrada();
        
      }
      //texto(Dialogos1[0],50,200);
      
       texto(Dialogos1[numDialogo1],40,100,20);// Dibujado de texto
       texto(Dialogos1[numDialogo2],150,150,30);
       
       //Prints para la consola
        println("entradaIzquierda " + entradaIzquierda + " Estado: " + movIzquierda);
        println("entradaDerecha   " + entradaDerecha +  " Estado: " + movDerecha);
        println("entradaArriba    " + entradaArriba +    " Estado: " + movArriba);
        println("entradaAbajo     " + entradaAbajo +     " Estado: " + movAbajo);
        
        println("numDialogo1 " + numDialogo1);
        println("JugadorX " + JugadorX);
        println("JugadorY " + JugadorY);
        
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
        
        
        if(collision(posX,posY,posX + prueba1,posY + prueba2,JugadorX, JugadorY,JugadorX + 50, JugadorY + 50)){
          numDialogo2 = 4;
        }
        
        delay(16);
          tiempoAnterior = tiempoActual;
  }//cierre de la actualizacion controlada
    
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
    if((entradaPosX > hitPosX && entradaPosX < hitTamanioX)&&
    (entradaPosY > hitPosY && entradaPosY < hitTamanioY)){
      return true;
    }//esquina superior izquierda
    else if((entradaTamanioX > hitPosX && entradaTamanioX < hitTamanioX)&&
    (entradaPosY > hitPosY && entradaTamanioY < hitTamanioY)){
      return true;
    }//esquina inferior derecha
    else if((entradaPosX > hitPosX && entradaPosX < hitTamanioX)&&
    (entradaTamanioY > hitPosY && entradaTamanioY < hitTamanioY)){
      return true;// esquina inferior izquierda
    }
    else if((entradaTamanioX > hitPosX && entradaTamanioX < hitTamanioX)&&
    (entradaPosY > hitPosY && entradaPosY < hitTamanioY)){
      return true;//esquina superior derecha
    }
    else{
      return false;
    }
    
    
   
    
  }
    
  
  
