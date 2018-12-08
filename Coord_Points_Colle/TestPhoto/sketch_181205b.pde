import java.io.*;

import processing.serial.*;
import java.util.Map;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

int result=0;
String textValue = "";
PImage photo;



void setup() {
}

void draw() {
}



void mousePressed() {
   //Process p2 = exec("gphoto2","--auto-detect","--capture-image-and-download","--debug","--debug-logfile","/tmp/mac1.log","--debug-loglevel","debug");
   
   Process p2 = exec("python","/home/lismont/Mac/Exemples-python/capture-image.py");
      try {
    result = p2.waitFor();
    print("result photo2:");
    println(result);
  }
  catch(InterruptedException e)
  {
    e.printStackTrace();
  } 

   Process p3 = exec("python","/home/lismont/Mac/Coord_Points_Colle/batchCopy.py","--debug","--debug-logfile","/tmp/mac1.log","--debug-loglevel","debug");
      try {
    result = p3.waitFor();
    print("result photo3:");
    println(result);
  }
  catch(InterruptedException e)
  {
    e.printStackTrace();
  }
  
  //   Process p3 = exec("gphoto2","--get-all-files");//,"--debug","--debug-logfile","/tmp/mac1.log","--debug-loglevel","debug");
    
  //    try {
  //  result = p3.waitFor();
  //  print("result photo3:");
  //  println(result);
  //}
  //catch(InterruptedException e)
  //{
  //  e.printStackTrace();
  //} 


// Process p = exec("gphoto2","--capture-image-and-download","--debug","--debug-logfile","/tmp/mac.log","--debug-loglevel","debug","--force-overwrite", "--filename", "/tmp/mac2.jpg"); //"sudo","-u","lismont",
// Process p = exec("bash","/tmp/test.sh"); //"sudo","-u","lismont",

  //try {
  //  result = p.waitFor();
  //  print("result photo:");
  //  println(result);
  //}
  //catch(InterruptedException e)
  //{
  //  e.printStackTrace();
  //} 


  //println("Test");

}


public class RecuperationSorties extends Thread {  

  /**  Le flux à rediriger  */
  private InputStream flux;

  /**
   * <b>Constructeur de RecuperationSorties</b>
   * @param flux
   *  Le flux à rediriger
   */
  public RecuperationSorties(InputStream flux) {
    this.flux = flux;
  }

  @Override
    public void run() {
    try {    
      InputStreamReader reader = new InputStreamReader(flux);
      BufferedReader br = new BufferedReader(reader);
      String ligne=null;
      while ( (ligne = br.readLine()) != null) {
        System.out.println(ligne);
      }
    }
    catch (IOException ioe) {
      ioe.printStackTrace();
    }
  }
}
public class Photo {

  /**
   * Cette méhthode permet de réaliser un ping sur la machine dont l'ip est passée en paramètre
   * @param nomMachine
   *   L'adresse ip ou le nom de la machine à pinger
   * @return vrai si la machine est joignable par le ping et faux sinon
   */
  public boolean Photo() {
    int exitValue=1;

    /* Récupération de l'environnement d'exécution */
    Runtime runtime = Runtime.getRuntime();

    try {
      /* Création et lancement de processus qui fait le ping */
      Process process = runtime.exec("gphoto2 --capture-image");
      /* Lancement du thread de récupération de la sortie standard */
      new RecuperationSorties(process.getInputStream()).start();

      /* Lancement du thread de récupération de la sortie en erreur */
      new RecuperationSorties(process.getErrorStream()).start();
      exitValue=process.waitFor();
    }
    catch (IOException e) {
      e.printStackTrace();
    }
    catch (InterruptedException e) {
      e.printStackTrace();
    }
    return exitValue==0;
  }
} 
