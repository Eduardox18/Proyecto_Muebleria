package muebleria.modelo;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableView;
import javafx.scene.control.TextInputDialog;
import javafx.scene.control.TableColumn;
import muebleria.Main;

public class ControladorVentas {
  
  private Statement s;
  private ResultSet rs;
  private String sQuery = "";
  private Connection con; 
  private Main principal;
  private Mueble mueble;
  
  
  @FXML
  private Button agregar;
  
  @FXML
  private Button remover;
  
  @FXML
  private TableView<Mueble> tablaVentas;
  
  @FXML
  private TableColumn<Mueble,String> columnaNombre;
  
  @FXML
  private TableColumn<Mueble, Number> columnaPrecio;
  
  @FXML
  private TableColumn columnaCantidad;
  
  @FXML 
  private Button realizarVenta;
  
  @FXML
  private Label subtotal;
  
  @FXML
  private Label total;
  
  @FXML
  private void initialize() {
    columnaNombre.setCellValueFactory(cellData -> cellData.getValue().getNombreMueble());
    columnaPrecio.setCellValueFactory(cellData -> cellData.getValue().getPrecioMueble());
        
  }
  
  @FXML
  private void botonAgregar () throws ClassNotFoundException, SQLException {
    con = new Conexion().connection();
    TextInputDialog idMueble = new TextInputDialog();
    idMueble.setHeaderText(null);
    idMueble.setTitle("Ventas");
    idMueble.setContentText("Ingresa la clave del artículo que deseas:");
    
    Optional<String> result = idMueble.showAndWait();
    if (result.isPresent()){
      sQuery = "select * from Mueble where idMueble = "+ result.get()+";";
      try {
        s = con.createStatement();
        rs = s.executeQuery(sQuery);
        if(rs.next()) {
          mueble = new Mueble();
          mueble.setNombreMueble(rs.getString("nombreMueble"));
          mueble.setPrecioMubele(rs.getDouble("precioMueble"));
          mueble.setIdMueble(rs.getInt("idMueble"));
          TextInputDialog cantidad = new TextInputDialog();
          cantidad.setHeaderText(null);
          cantidad.setTitle("Ventas");
          cantidad.setContentText("¿Qué cantidad desea comprar?");
    
          Optional<String> result1 = cantidad.showAndWait();
          if (result1.isPresent()){
            for(int i = 0; i < Integer.valueOf(result1.get()); i++) {
              Mueble.listaVenta.add(mueble);
            }
            tablaVentas.setItems(Mueble.listaVenta);
            calculaSub();
          }
        }
        else {
          Alert noExiste = new Alert(AlertType.INFORMATION);
          noExiste.setTitle("Ventas");
          noExiste.setHeaderText(null);
          noExiste.setContentText("Ese artículo no existe en la base de datos");
          noExiste.showAndWait();
        }
      } catch (SQLException ex) {
        Logger.getLogger(ControladorVentas.class.getName()).log(Level.SEVERE, null, ex);
      }finally {
        con.close();
      }
    }
  }
  
  @FXML
  private void botonRemover () {
    Mueble.listaVenta.remove(tablaVentas.getSelectionModel().getSelectedItem());
    calculaSub();
  }
  
  @FXML
  private void botonRealizarVenta() throws SQLException, ClassNotFoundException {
    con = new Conexion().connection();
    for (int i = 0; i < Mueble.listaVenta.size(); i++) {
      sQuery = "UPDATE `Almacen-Guarda-Mueble` SET existenciasAlmacen = existenciasAlmacen - "+
          "1 WHERE Mueble_idMueble = " + Mueble.listaVenta.get(i).getIdMueble().toString()+";";
      System.out.println(sQuery);
      try {
        s = con.createStatement();
        s.executeUpdate(sQuery);
      } catch (SQLException ex) {
        Logger.getLogger(ControladorVentas.class.getName()).log(Level.SEVERE, null, ex);
      } finally {
        con.close();
      }
      
    }
    
    Mueble.listaVenta.clear();
    
    Alert exito = new Alert(AlertType.INFORMATION);
    exito.setTitle("Ventas");
    exito.setHeaderText(null);
    exito.setContentText("La venta se ha realizado con éxito");
    exito.showAndWait();
  }     
  
  private void calculaSub () {
    Double sub = 0.0;
    for (int i = 0; i < Mueble.listaVenta.size(); i++) {
      sub = sub + Mueble.listaVenta.get(i).getPrecioMueble().get();
    }
    
    sub = Math.rint(sub*100)/100;
    subtotal.setText(sub.toString());
    Double tmp = sub * 1.16;
    total.setText(tmp.toString());
  }
  
  public void setMainApp(Main principal) {
    this.principal = principal;
  }
  
}
