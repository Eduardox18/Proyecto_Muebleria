package muebleria.modelo;

import java.time.LocalDate;
import javafx.beans.property.IntegerProperty;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.StringProperty;







public abstract class Persona
{
  private StringProperty nombre;
  private StringProperty apPaterno;
  private StringProperty apMaterno;
  private StringProperty email;
  private StringProperty calle;
  private StringProperty estado;
  private StringProperty ciudad;
  private StringProperty colonia;
  private IntegerProperty telCasa;
  private IntegerProperty telCelular;
  private ObjectProperty<LocalDate> fechaNac;
  
  public Persona() {}
  
  public String getNombre()
  {
    return (String)nombre.get();
  }
  
  public void setNombre(String nombre) {
    this.nombre.set(nombre);
  }
  
  public String getApPaterno() {
    return (String)apPaterno.get();
  }
  
  public void setApPaterno(String apPaterno) {
    this.apPaterno.set(apPaterno);
  }
  
  public String getApMaterno() {
    return (String)apMaterno.get();
  }
  
  public void setApMaterno(String apMaterno) {
    this.apMaterno.set(apMaterno);
  }
  
  public String getEmail() {
    return (String)email.get();
  }
  
  public void setEmail(String email) {
    this.email.set(email);
  }
  
  public String getCalle() {
    return (String)calle.get();
  }
  
  public void setCalle(String calle) {
    this.calle.set(calle);
  }
  
  public String getEstado() {
    return (String)estado.get();
  }
  
  public void setEstado(String estado) {
    this.estado.set(estado);
  }
  
  public String getCiudad() {
    return (String)ciudad.get();
  }
  
  public void setCiudad(String ciudad) {
    this.ciudad.set(ciudad);
  }
  
  public String getColonia() {
    return (String)colonia.get();
  }
  
  public void setColonia(String colonia) {
    this.colonia.set(colonia);
  }
  
  public Integer getTelCasa() {
    return telCasa.get();
  }
  
  public void setTelCasa(Integer telCasa) {
    this.telCasa.set(telCasa);
  }
  
  public Integer getTelCelular() {
    return telCelular.get();
  }
  
  public void setTelCelular(Integer telCelular) {
    this.telCelular.set(telCelular);
  }
  
  public LocalDate getFechaNac() {
    return (LocalDate)fechaNac.get();
  }
  
  public void setFechaNac(LocalDate fechaNac) {
    this.fechaNac.set(fechaNac);
  }
}