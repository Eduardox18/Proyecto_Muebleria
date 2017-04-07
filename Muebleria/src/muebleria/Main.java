package muebleria;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;


public class Main extends Application
{
  private Stage primaryStage;
  private BorderPane menuLayout;
  
  public Main() {}
  
  @Override
  public void start(Stage primaryStage)
  {
    this.primaryStage = primaryStage;
    this.primaryStage.setTitle("S.O.F.A");
    
    iniciarMenu();
    showInicio();
  }
  
  public void iniciarMenu() {
    try {
      FXMLLoader loader = new FXMLLoader();
      loader.setLocation(Main.class.getResource("vista/Menu.fxml"));
      menuLayout = (BorderPane) loader.load();
      
      Scene escena = new Scene(menuLayout);
      primaryStage.setScene(escena);
      primaryStage.show();
    } catch (IOException ex) {
      Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
    } 
  }
  
  public void showInicio() {
    try {
      FXMLLoader loader = new FXMLLoader();
      loader.setLocation(Main.class.getResource("vista/Inicio.fxml"));
      AnchorPane vistaInicio = (AnchorPane)loader.load();
      
      menuLayout.setCenter(vistaInicio);
    } catch (IOException ex) {
      Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
    }
  }
  
  public Stage getPrimaryStage() {
    return primaryStage;
  }

  public static void main(String[] args)
  {
    launch(args);
  }
}