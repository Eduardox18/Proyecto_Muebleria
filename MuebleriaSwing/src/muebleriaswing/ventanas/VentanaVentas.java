/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package muebleriaswing.ventanas;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import javax.swing.table.TableRowSorter;
import muebleriaswing.MetodosUtiles;
import muebleriaswing.Mueble;
import muebleriaswing.conexion.Conexion;

/**
 * @author Domínguez Delgado Angel Eduardo
 * @author Domínguez González José Andrés
 * @author Hernández González Esmeralda Yamileth
 */
public class VentanaVentas extends javax.swing.JFrame {

  /**
   * Creates new form Ventas
   */
  private DefaultTableModel modelo;
  private TableRowSorter<TableModel> elQueOrdena;
  private final double IVA = 0.16;
  private Mueble mueble;
  static Connection con = null;
  static Statement s = null;
  static ResultSet rs = null;
  String sQuery;
  private ArrayList<Mueble> venta = new ArrayList<>();
    
  /**
   * Constructor de la clase Ventana de ventas
   */
  public VentanaVentas() {
    initComponents();
    this.setLocationRelativeTo(null);
    modeloTabla();
    tablaVentas.setModel(modelo);
    tablaVentas.setRowSorter(elQueOrdena);
    agregarFila();
    lSubtotal.setText("0");
    lTotal.setText("0");
    lIva.setText(MetodosUtiles.dobleAString(IVA));  
    jLabelFecha.setText(obtenerFecha());
  }
    
  /**
   *
   * Establece el modelo de la tabla
   */
  private void modeloTabla () {
    modelo = new DefaultTableModel() {
      public boolean iscellEditable(int row, int column) {
        return true;
      }
    };            
    modelo.addColumn("Clave");
    modelo.addColumn("Nombre");
    modelo.addColumn("Precio");
    modelo.addColumn("Cantidad");
    elQueOrdena = new TableRowSorter<>(modelo);
  }
    
  /**
   * 
   * Agrega una fila vacia a la tabla
   */
  private void agregarFila () {
    Object [] objeto = new Object[4];
    modelo.addRow(objeto);
  }
    
  /**
   * 
   * Obtiene el valor de la tabla en la posición especificada
   * @param fila Fila deseada
   * @param columna Columna deseada
   * @return Valor en el lugar especificado
   */
  private Object valorTabla (int fila, int columna) {
    return tablaVentas.getValueAt(fila, columna);
  }
    
  /**
   * 
   * Calcula el precio de los productos multiplicando cantidad por precio
   * @return Arreglo con los valores de cada fila
   */
  private Double[] calculaPrecios () {
    int filas = tablaVentas.getRowCount();
    double precio;
    int cantidad;
    Double[] precios = new Double[filas];
  
    for(int i = 0; i < filas; i++) {
      precio = (double) valorTabla(i, 2);      
      
      if(valorTabla(i, 3) == null) {
        tablaVentas.setValueAt("1", i, 3);
      }      
      cantidad = MetodosUtiles.stringAInt((String)valorTabla(i, 3));      
      precios[i] = precio * cantidad;
    }
    return precios;
  }
    
  /**
   * 
   * Comprueba si la cantidad de muebles es suficiente
   * @param cantidad La cantidad que se desea comprar   
   * @return true si la cantidad es suficiente y false si no alcanza 
   */
  private boolean esSuficiente (int cantidad, int idMueble) {
    sQuery = "select existenciasAlmacen from AlmacenGuardaMueble where "
        + "Mueble_idMueble = " + idMueble + ";";
    int existencia = 0;
        
    try {
      con = new Conexion().connection();
      s = con.createStatement();
      rs = s.executeQuery(sQuery);
            
      if(rs.next() && rs != null) {
        existencia = rs.getInt("existenciasAlmacen");
        if (existencia >= cantidad) {
          return true;
        }
      } else {
        JOptionPane.showMessageDialog(null, "No se encontró ningún mueble "
            + "que coincida con esa clave", "No encontrado",
            JOptionPane.WARNING_MESSAGE);
      }
    } catch (ClassNotFoundException | SQLException ex) {
      Logger.getLogger(VentanaVentas.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
  }
    
  /**
   * 
   * Suma los precios de cada fila y después calcula el totoal
   */
  private void sumarPrecios () {
    double subtotal = 0;
    double total = 0;
    Double[] cantidades = calculaPrecios();
        
    for(int i = 0; i < cantidades.length; i++) {
      subtotal += cantidades[i];
    }
        
    total = subtotal * (1 + IVA);
    
    lSubtotal.setText(MetodosUtiles.dobleAString(subtotal));
    lTotal.setText(MetodosUtiles.dobleAString(total));
  }
    
  /**
   * 
   * Comrueba si el id del mueble existe en la base de datos
   * @param id El id que se va a buscar
   * @return Un objeto mueble si existe y null si no existe 
   */
  private Mueble existeIDMueble (String id) {
    sQuery = "SELECT * FROM mueble WHERE idMueble = " + id +";";
    mueble = new Mueble();
    try {
      con = new Conexion().connection();
      s = con.createStatement();
      rs = s.executeQuery(sQuery);      
            
      if(rs != null && rs.next()) {
        mueble.setPrecioMueble(rs.getDouble("precioMueble"));
        mueble.setNombreMueble(rs.getString("nombreMueble"));
        return mueble;
      }                      
    } catch (ClassNotFoundException | SQLException ex) {
      Logger.getLogger(VentanaVentas.class.getName()).log(Level.SEVERE, null, ex);
    } finally {
      try {
        con.close();
      } catch (SQLException ex) {
        Logger.getLogger(VentanaVentas.class.getName()).log(Level.SEVERE, null, ex);
      }
    }
    return null;
  }
  
  /**
   * Inserta los datos de las ventas en la base de datos
   * @param fecha día en que se realiza la venta
   * @throws SQLException
   * @throws ClassNotFoundException 
   */
  public void insertarVenta(String fecha) throws SQLException, ClassNotFoundException {
    String bandera;
    int filas = tablaVentas.getRowCount();
    int idMueble;
    int cantidad;
    int nuevaExistencia;
    
    sQuery = "INSERT INTO VentaContado (fechaVentaContado, Empleado_idEmpleado,"
        + " Cliente_idCliente) VALUES ('" + fecha + "', " + LogIn.idUsuario + ", 1);";
    update(sQuery);
    
    if(jToggleButtonResguardo.isSelected()) {
        bandera = "true";
    }
    else {
        bandera = "false";
    }
    
    for (int i = 0; i < filas; i++) {
        sQuery = "INSERT INTO MuebleSolicitaVentaContado (cantidadVentaContado, "
            + "resguardoVentaContado,Mueble_idMueble, VentaContado_idVentaContado)"
            + " VALUES ("+ MetodosUtiles.stringAInt((String)valorTabla
        (i, 3)) + "," + bandera + ", " + MetodosUtiles.stringAInt((String)valorTabla
        (i, 0))+ " ," + getIDVenta() + ");";
        update(sQuery);
    }
    
    for(int i = 0; i < filas; i++) {
        idMueble = MetodosUtiles.stringAInt((String) valorTabla(i, 0));
        cantidad = MetodosUtiles.stringAInt((String)valorTabla(i, 3));
        nuevaExistencia  = existenciaMueble(idMueble) - cantidad;
        sQuery = "UPDATE almacenguardamueble SET existenciasAlmacen =" + 
            nuevaExistencia + " WHERE Mueble_idMueble =" + idMueble + ";";
        update(sQuery);
    }
  }
  
  /**
   * 
   * Devuleve las existencias del mueble solicitado
   * @param idMueble id del mueble
   * @return Existencias del mueble, 0 si no se encuentra
   */
  private int existenciaMueble (int idMueble) {
      sQuery = "select existenciasAlmacen from almacenguardamueble where "
          + "Mueble_idMueble ="+ idMueble + ";";
      
      try {
          con = new Conexion().connection();
          s = con.createStatement();
          rs = s.executeQuery(sQuery);
          
          if(rs.next() && rs != null) {
              return rs.getInt("existenciasAlmacen");
          }
      } catch (ClassNotFoundException | SQLException ex) {
          Logger.getLogger(VentanaVentas.class.getName()).log(Level.SEVERE, null, ex);
      }
      return 0;
  }
  
  /**
   * Función que realiza un update válido cualquiera.
   * @param sQuery Sentencia del update
   * @throws ClassNotFoundException
   * @throws SQLException 
   */
  public void update(String sQuery) throws ClassNotFoundException, SQLException {
    try {
      con = new Conexion().connection();
      s = con.createStatement();
      s.executeUpdate(sQuery);
    } catch (SQLException e) {
      System.err.print("Error: " + e.getMessage() + "\n" + e.getErrorCode());
    } finally {
      con.close();
    }
  } 
  
  /**
   * Obtiene el id de la última venta registrada en la base de datos.
   * @return
   * @throws SQLException 
   */
  public int getIDVenta() throws SQLException {
    sQuery = "SELECT MAX(idVentaContado) FROM VentaContado;";

    try {
      con = new Conexion().connection();
      s = con.createStatement();
      rs = s.executeQuery(sQuery);

      if (rs != null && rs.next()) {
        return rs.getInt("MAX(idVentaContado)");
      }
    } catch (ClassNotFoundException | SQLException ex) {
      Logger.getLogger(VentanaVentas.class.getName()).log(Level.SEVERE, null, ex);
    } finally {
      con.close();
    }
    return 0;
  }
  
  private String obtenerFecha () {
    Calendar cal = new GregorianCalendar();
    String dia, mes, anio;
        
    dia = Integer.toString(cal.get(Calendar.DAY_OF_MONTH)); 
    mes = Integer.toString(cal.get(Calendar.MONTH));
    anio = Integer.toString(cal.get(Calendar.YEAR));
        
    return dia + "/" + mes + "/" + anio;
  }

  /**
   * This method is called from within the constructor to initialize the form.
   * WARNING: Do NOT modify this code. The content of this method is always
   * regenerated by the Form Editor.
   */
  @SuppressWarnings("unchecked")
  // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
  private void initComponents() {

    jToolBar1 = new javax.swing.JToolBar();
    jScrollPane1 = new javax.swing.JScrollPane();
    tablaVentas = new javax.swing.JTable();
    jPanel2 = new javax.swing.JPanel();
    jLabel4 = new javax.swing.JLabel();
    lSubtotal = new javax.swing.JLabel();
    jLabel2 = new javax.swing.JLabel();
    lIva = new javax.swing.JLabel();
    jSeparator1 = new javax.swing.JSeparator();
    jLabel5 = new javax.swing.JLabel();
    lTotal = new javax.swing.JLabel();
    jButtonRealizarVenta = new javax.swing.JButton();
    jPanel1 = new javax.swing.JPanel();
    jButtonRegresar = new javax.swing.JButton();
    jButtonNuevo = new javax.swing.JButton();
    jToggleButtonResguardo = new javax.swing.JToggleButton();
    jLabelFecha = new javax.swing.JLabel();

    jToolBar1.setRollover(true);

    setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

    tablaVentas.setModel(new javax.swing.table.DefaultTableModel(
      new Object [][] {
        {null, null, null, null},
        {null, null, null, null},
        {null, null, null, null},
        {null, null, null, null}
      },
      new String [] {
        "Title 1", "Title 2", "Title 3", "Title 4"
      }
    ));
    tablaVentas.addMouseListener(new java.awt.event.MouseAdapter() {
      public void mouseReleased(java.awt.event.MouseEvent evt) {
        tablaVentasMouseReleased(evt);
      }
    });
    tablaVentas.addKeyListener(new java.awt.event.KeyAdapter() {
      public void keyPressed(java.awt.event.KeyEvent evt) {
        tablaVentasKeyPressed(evt);
      }
      public void keyReleased(java.awt.event.KeyEvent evt) {
        tablaVentasKeyReleased(evt);
      }
    });
    jScrollPane1.setViewportView(tablaVentas);

    jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder(""));

    jLabel4.setText("Subtotal:");

    lSubtotal.setText("jLabel1");

    jLabel2.setText("IVA:");

    lIva.setText("jLabel3");

    jLabel5.setText("Total:");

    lTotal.setText("jLabel6");

    jButtonRealizarVenta.setText("Realizar venta");
    jButtonRealizarVenta.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
    jButtonRealizarVenta.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(java.awt.event.ActionEvent evt) {
        jButtonRealizarVentaActionPerformed(evt);
      }
    });

    javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
    jPanel2.setLayout(jPanel2Layout);
    jPanel2Layout.setHorizontalGroup(
      jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(jPanel2Layout.createSequentialGroup()
        .addContainerGap()
        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
          .addComponent(jSeparator1)
          .addGroup(jPanel2Layout.createSequentialGroup()
            .addComponent(jLabel4)
            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 66, Short.MAX_VALUE)
            .addComponent(lSubtotal))
          .addGroup(jPanel2Layout.createSequentialGroup()
            .addComponent(jLabel2)
            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(lIva))
          .addGroup(jPanel2Layout.createSequentialGroup()
            .addComponent(jLabel5)
            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(lTotal)))
        .addContainerGap())
      .addGroup(jPanel2Layout.createSequentialGroup()
        .addGap(21, 21, 21)
        .addComponent(jButtonRealizarVenta)
        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
    );
    jPanel2Layout.setVerticalGroup(
      jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(jPanel2Layout.createSequentialGroup()
        .addContainerGap()
        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
          .addComponent(jLabel4)
          .addComponent(lSubtotal))
        .addGap(18, 18, 18)
        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
          .addComponent(jLabel2)
          .addComponent(lIva))
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
        .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, 10, javax.swing.GroupLayout.PREFERRED_SIZE)
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
          .addComponent(jLabel5)
          .addComponent(lTotal))
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        .addComponent(jButtonRealizarVenta)
        .addContainerGap())
    );

    jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder(""));

    jButtonRegresar.setText("Regresar");
    jButtonRegresar.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
    jButtonRegresar.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(java.awt.event.ActionEvent evt) {
        jButtonRegresarActionPerformed(evt);
      }
    });

    jButtonNuevo.setText("Nuevo");
    jButtonNuevo.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(java.awt.event.ActionEvent evt) {
        jButtonNuevoActionPerformed(evt);
      }
    });

    jToggleButtonResguardo.setText("Resguardo");

    javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
    jPanel1.setLayout(jPanel1Layout);
    jPanel1Layout.setHorizontalGroup(
      jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(jPanel1Layout.createSequentialGroup()
        .addContainerGap()
        .addComponent(jButtonRegresar)
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        .addComponent(jToggleButtonResguardo, javax.swing.GroupLayout.PREFERRED_SIZE, 102, javax.swing.GroupLayout.PREFERRED_SIZE)
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
        .addComponent(jButtonNuevo)
        .addContainerGap())
    );
    jPanel1Layout.setVerticalGroup(
      jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
          .addComponent(jButtonRegresar)
          .addComponent(jButtonNuevo)
          .addComponent(jToggleButtonResguardo))
        .addContainerGap())
    );

    jLabelFecha.setText("jLabel1");

    javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
    getContentPane().setLayout(layout);
    layout.setHorizontalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addContainerGap()
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
          .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 372, Short.MAX_VALUE)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
          .addComponent(jLabelFecha))
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
        .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        .addContainerGap())
    );
    layout.setVerticalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
          .addGroup(layout.createSequentialGroup()
            .addContainerGap()
            .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
          .addGroup(layout.createSequentialGroup()
            .addGap(8, 8, 8)
            .addComponent(jLabelFecha)
            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 216, javax.swing.GroupLayout.PREFERRED_SIZE)
            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
            .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
    );

    pack();
  }// </editor-fold>//GEN-END:initComponents

    private void tablaVentasMouseReleased(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tablaVentasMouseReleased
        
    }//GEN-LAST:event_tablaVentasMouseReleased

    private void jButtonRegresarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonRegresarActionPerformed
      Inicial inicio = new Inicial();
      inicio.setVisible(true);
      this.dispose();
    }//GEN-LAST:event_jButtonRegresarActionPerformed

    private void tablaVentasKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_tablaVentasKeyReleased
      if(existeIDMueble((String)valorTabla(tablaVentas.getSelectedRow(), 0)) != null) {
        tablaVentas.setValueAt(mueble.getNombreMueble(), tablaVentas.getSelectedRow(), 1);
        tablaVentas.setValueAt(mueble.getPrecioMueble(), tablaVentas.getSelectedRow(), 2);
        sumarPrecios();
      } else {
        JOptionPane.showMessageDialog(null, "No se encontró ningún mueble "
            + "que coincida con esa clave", "No encontrado",
            JOptionPane.WARNING_MESSAGE);
        tablaVentas.setValueAt(null, tablaVentas.getSelectedRow(), 0);
      }
        
//        if(evt.getKeyCode() == KeyEvent.VK_ENTER){
//            if(valorTabla() != null) {
//                agregarFila();
//            }
//        }
    }//GEN-LAST:event_tablaVentasKeyReleased

    private void tablaVentasKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_tablaVentasKeyPressed
        
    }//GEN-LAST:event_tablaVentasKeyPressed

    private void jButtonNuevoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonNuevoActionPerformed
      if(tablaVentas.getSelectedRow() != -1){
        if(valorTabla(tablaVentas.getSelectedRow(),3) != null) {
          if(esSuficiente(MetodosUtiles.stringAInt((String) valorTabla(tablaVentas.getSelectedRow(), 3)), 
              MetodosUtiles.stringAInt((String) valorTabla(tablaVentas.getSelectedRow(), 0)))){
            agregarFila();
          } else {
            JOptionPane.showMessageDialog(null, "No hay existencias disponibles", 
                "Sin existencias", JOptionPane.WARNING_MESSAGE);
            tablaVentas.setValueAt(null, tablaVentas.getSelectedRow(), 3);
          }
        } else {
          JOptionPane.showMessageDialog(null, "No ha ingresado ninguna clave", 
              "Sin clave", JOptionPane.WARNING_MESSAGE);
        }
      } else {
        JOptionPane.showMessageDialog(null, "No ha ingresado ninguna clave", 
            "Sin clave", JOptionPane.WARNING_MESSAGE);
      }     
    }//GEN-LAST:event_jButtonNuevoActionPerformed
  private void jButtonRealizarVentaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonRealizarVentaActionPerformed
    if(tablaVentas.getValueAt(0, 0) != null) {
        try {
            insertarVenta(jLabelFecha.getText());
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(VentanaVentas.class.getName()).log(Level.SEVERE, null, ex);
        }
        JOptionPane.showMessageDialog(this, "La venta se realizó exitosamente", "'Exito", 
            JOptionPane.INFORMATION_MESSAGE); 
    
        VentanaVentas ventas = new VentanaVentas();
        ventas.setVisible(true);
        this.dispose();
    }else{
        JOptionPane.showMessageDialog(null, "No ha ingresado ningún artículo", 
            "Sin artículos", JOptionPane.WARNING_MESSAGE);
    }
      
  }//GEN-LAST:event_jButtonRealizarVentaActionPerformed


  // Variables declaration - do not modify//GEN-BEGIN:variables
  private javax.swing.JButton jButtonNuevo;
  private javax.swing.JButton jButtonRealizarVenta;
  private javax.swing.JButton jButtonRegresar;
  private javax.swing.JLabel jLabel2;
  private javax.swing.JLabel jLabel4;
  private javax.swing.JLabel jLabel5;
  private javax.swing.JLabel jLabelFecha;
  private javax.swing.JPanel jPanel1;
  private javax.swing.JPanel jPanel2;
  private javax.swing.JScrollPane jScrollPane1;
  private javax.swing.JSeparator jSeparator1;
  private javax.swing.JToggleButton jToggleButtonResguardo;
  private javax.swing.JToolBar jToolBar1;
  private javax.swing.JLabel lIva;
  private javax.swing.JLabel lSubtotal;
  private javax.swing.JLabel lTotal;
  private javax.swing.JTable tablaVentas;
  // End of variables declaration//GEN-END:variables
}
