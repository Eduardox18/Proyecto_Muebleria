package muebleria.modelo;

import javafx.beans.property.DoubleProperty;
import javafx.beans.property.IntegerProperty;
import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

public class Mueble
{
  private IntegerProperty idMueble;
  private StringProperty nombreMueble;
  private DoubleProperty precioMueble;
  private StringProperty tipoMueble;
  private IntegerProperty stockMinimoMueble;
  public static ObservableList<Mueble> listaVenta = FXCollections.observableArrayList();
  
  public Mueble() {}
  
  public Mueble(Integer idMueble, String nombreMueble, Double precioMueble, String tipoMueble, Integer stockMinimoMueble)
  {
    this.idMueble = new SimpleIntegerProperty(idMueble);
    this.nombreMueble = new SimpleStringProperty(nombreMueble);
    this.precioMueble = new SimpleDoubleProperty(precioMueble);
    this.tipoMueble = new SimpleStringProperty(tipoMueble);
    this.stockMinimoMueble = new SimpleIntegerProperty(stockMinimoMueble);
  }
  
  public Integer getIdMueble() {
    return idMueble.get();
  }
  
  public void setIdMueble(Integer idMueble) {
    this.idMueble = new SimpleIntegerProperty(idMueble);
  }
  
  public StringProperty getNombreMueble() {
    return nombreMueble;
  }
  
  public void setNombreMueble(String nombreMueble) {
    this.nombreMueble = new SimpleStringProperty(nombreMueble);
  }
  
  public DoubleProperty getPrecioMueble() {
    return precioMueble;
  }
  
  public void setPrecioMubele(Double precioMueble) {
    this.precioMueble = new SimpleDoubleProperty(precioMueble);
  }
  
  public StringProperty getTipoMueble() {
    return tipoMueble;
  }
  
  public void setTipoMueble(String tipoMueble) {
    this.tipoMueble = new SimpleStringProperty(tipoMueble);
  }
  
  public IntegerProperty getStockMinimoMueble() {
    return stockMinimoMueble;
  }
  
  public void setStockMinimoMueble(Integer stockMinimoMueble) {
    this.stockMinimoMueble = new SimpleIntegerProperty(stockMinimoMueble);
  }
}