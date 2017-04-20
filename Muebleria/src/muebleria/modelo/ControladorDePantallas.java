package muebleria.modelo;


import java.util.HashMap;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.layout.StackPane;

 public class ControladorDePantallas extends StackPane {	
 
   private HashMap<String, Node> screens = new HashMap<>(); 
   
   public void addScreen(String name, Node screen) { 
       screens.put(name, screen); 
   } 
   
   public boolean loadScreen(String name, String resource) { 
     try { 
       FXMLLoader myLoader = new 
               FXMLLoader(getClass().getResource(resource)); 
       Parent loadScreen = (Parent) myLoader.load(); 
       PantallaControlada myScreenControler = 
              ((PantallaControlada) myLoader.getController()); 
       myScreenControler.setScreenParent(this); 
       addScreen(name, loadScreen); 
       return true; 
     }catch(Exception e) { 
       System.out.println(e.getMessage()); 
       return false; 
     } 
   } 

 }
