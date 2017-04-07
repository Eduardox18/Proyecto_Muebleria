package muebleria.modelo;

import javafx.beans.property.DoubleProperty;
import javafx.beans.property.IntegerProperty;
import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;












public class Mueble
{
  private IntegerProperty idMueble;
  private StringProperty nombreMueble;
  private DoubleProperty precioMueble;
  private StringProperty tipoMueble;
  private IntegerProperty stockMinimoMueble;
  
  public Mueble() {}
  
  public Mueble(Integer idMueble, String nombreMueble, Double precioMueble, String tipoMueble, Integer stockMinimoMueble)
  {
    this.idMueble = new SimpleIntegerProperty(idMueble.intValue());
    this.nombreMueble = new SimpleStringProperty(nombreMueble);
    this.precioMueble = new SimpleDoubleProperty(precioMueble.doubleValue());
    this.tipoMueble = new SimpleStringProperty(tipoMueble);
    this.stockMinimoMueble = new SimpleIntegerProperty(stockMinimoMueble.intValue());
  }
  
  public Integer getIdMueble() {
    return Integer.valueOf(idMueble.get());
  }
  
  public void setIdMueble(Integer idMueble) {
    this.idMueble.set(idMueble.intValue());
  }
  
  public String getNombreMueble() {
    return (String)nombreMueble.get();
  }
  
  public void setNombreMueble(String nombreMueble) {
    this.nombreMueble.set(nombreMueble);
  }
  
  public Double getPrecioMueble() {
    return Double.valueOf(precioMueble.get());
  }
  
  public void setPrecioMubele(Double precioMueble) {
    this.precioMueble.set(precioMueble.doubleValue());
  }
  
  public String getTipoMueble() {
    return (String)tipoMueble.get();
  }
  
  public void setTipoMueble(String tipoMueble) {
    this.tipoMueble.set(tipoMueble);
  }
  
  public Integer getStockMinimoMueble() {
    return Integer.valueOf(stockMinimoMueble.get());
  }
  
  public void setStockMinimoMueble(Integer stockMinimoMueble) {
    this.stockMinimoMueble.set(stockMinimoMueble.intValue());
  }
}