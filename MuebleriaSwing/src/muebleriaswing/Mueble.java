/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package muebleriaswing;

import java.util.ArrayList;

/**
 *
 * @author José Andrés Domínguez González
 */
public class Mueble {
  private String nombreMueble;
  private String tipoMueble;
  private double precioMueble;
  private String materialMueble;
  private String colorMueble;
  private double alturaMueble;
  private double baseMueble;
  private double profundidadMueble;
  private int stockMinimoMueble;
  private int cantidadMueble;
  public static ArrayList<Mueble> listaMueble = new ArrayList<>();
  
  public Mueble () {}
  
  public Mueble (String nombreMueble, String tipoMueble, double precioMueble, String materialMueble,
      String colorMueble, double alturaMueble, double baseMueble, double profundidadMueble, 
      int stockMinimoMueble, int cantidadMueble) {
    
    this.nombreMueble = nombreMueble;
    this.tipoMueble = tipoMueble;
    this.precioMueble = precioMueble;
    this.materialMueble = materialMueble;
    this.colorMueble = colorMueble;
    this.alturaMueble = alturaMueble;
    this.baseMueble = baseMueble;
    this.profundidadMueble = profundidadMueble;
    this.stockMinimoMueble = stockMinimoMueble;
    this.cantidadMueble = cantidadMueble;
  }

  public String getNombreMueble() {
    return nombreMueble;
  }

  public String getTipoMueble() {
    return tipoMueble;
  }

  public double getPrecioMueble() {
    return precioMueble;
  }

  public String getMaterialMueble() {
    return materialMueble;
  }

  public String getColorMueble() {
    return colorMueble;
  }

  public double getAlturaMueble() {
    return alturaMueble;
  }

  public double getBaseMueble() {
    return baseMueble;
  }

  public double getProfundidadMueble() {
    return profundidadMueble;
  }

  public int getStockMinimoMueble() {
    return stockMinimoMueble;
  }
  
  public int getCantidadMueble() {
    return cantidadMueble;
  }

  public void setNombreMueble(String nombreMueble) {
    this.nombreMueble = nombreMueble;
  }

  public void setTipoMueble(String tipoMueble) {
    this.tipoMueble = tipoMueble;
  }

  public void setPrecioMueble(double precioMueble) {
    this.precioMueble = precioMueble;
  }

  public void setMaterialMueble(String materialMueble) {
    this.materialMueble = materialMueble;
  }

  public void setColorMueble(String colorMueble) {
    this.colorMueble = colorMueble;
  }

  public void setAlturaMueble(double alturaMueble) {
    this.alturaMueble = alturaMueble;
  }

  public void setBaseMueble(double baseMueble) {
    this.baseMueble = baseMueble;
  }

  public void setProfundidadMueble(double profundidadMueble) {
    this.profundidadMueble = profundidadMueble;
  }

  public void setStockMinimoMueble(int stockMinimoMueble) {
    this.stockMinimoMueble = stockMinimoMueble;
  }
  
  public void setCantidadMueble(int cantidadMueble) {
    this.cantidadMueble = cantidadMueble;
  }
}
