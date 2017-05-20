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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import javax.swing.table.TableRowSorter;
import muebleriaswing.Mueble;
import muebleriaswing.conexion.Conexion;
import muebleriaswing.miKeyAdapter;
import muebleriaswing.MetodosUtiles;

/**
 *
 * @author José Andrés Domínguez González
 * @author Ángel Eduardo Domínguez Delgado
 */
public class Administrar extends javax.swing.JFrame {

    private DefaultTableModel modelo;
    private TableRowSorter<TableModel> elQueOrdena;
    static Connection con = null;
    static Statement s = null;
    static ResultSet rs = null;
    String sQuery;
    String inicial = "SELECT Mueble.nombreMueble, Mueble.tipoMueble, "
            + "Mueble.precioMueble, Mueble.materialMueble, Mueble.colorMueble, "
            + "Mueble.alturaMueble, Mueble.baseMueble, "
            + "Mueble.profundidadMueble, Mueble.stockMinimoMueble, "
            + "AlmacenGuardaMueble.existenciasAlmacen FROM Mueble, "
            + "AlmacenGuardaMueble WHERE Mueble.idMueble = "
            + "AlmacenGuardaMueble.mueble_idMueble; ";
    static String nombreMueble;
    static String colorMueble;

    public Administrar() {
        initComponents();
        this.setLocationRelativeTo(null);
        modeloTabla();
        jTable1.setModel(modelo);
        jTable1.setRowSorter(elQueOrdena);
        rellenarTabla(inicial);

        /**
         * Bloque de comprobaciones. Descripción: KeyListener's que comprueban
         * que no se ingresen letras a los campos que sólo aceptan números.
         */
        miKeyAdapter mka = new miKeyAdapter();

        preciotf.addKeyListener(mka);
        sminimotf.addKeyListener(mka);
        altotf.addKeyListener(mka);
        anchotf.addKeyListener(mka);
        profundidadtf.addKeyListener(mka);
        cantidadtf.addKeyListener(mka);
        //Fin del bloque de comprobaciones.
    }

    /**
     *
     * Define el modelo de la tabla y un Sorter para ordenar los datos
     */
    public void modeloTabla() {
        modelo = new DefaultTableModel();
        modelo.addColumn("Nombre");
        modelo.addColumn("Tipo");
        modelo.addColumn("Precio");
        modelo.addColumn("Material");
        modelo.addColumn("Color");
        modelo.addColumn("Alto (m)");
        modelo.addColumn("Ancho (m)");
        modelo.addColumn("Profundidad (m)");
        modelo.addColumn("Stock mínimo");
        modelo.addColumn("Existencia");
        modelo.setRowCount(0);

        elQueOrdena = new TableRowSorter<>(modelo);

    }

    /**
     *
     * Agrega los datos de los Muebles a la tabla
     *
     * @param query La consulta que se utilizará para conseguir los datos de los
     * muebles
     */
    public void rellenarTabla(String query) {
        btEliminar.setEnabled(false);
        btEditar.setEnabled(false);
        modelo.setRowCount(0);
        ArrayList<Mueble> listaMuebles = obtenerDatos(query);
        Object rowData[] = new Object[10];
        for (int i = 0; i < listaMuebles.size(); i++) {
            rowData[0] = listaMuebles.get(i).getNombreMueble();
            rowData[1] = listaMuebles.get(i).getTipoMueble();
            rowData[2] = listaMuebles.get(i).getPrecioMueble();
            rowData[3] = listaMuebles.get(i).getMaterialMueble();
            rowData[4] = listaMuebles.get(i).getColorMueble();
            rowData[5] = listaMuebles.get(i).getAlturaMueble();
            rowData[6] = listaMuebles.get(i).getBaseMueble();
            rowData[7] = listaMuebles.get(i).getProfundidadMueble();
            rowData[8] = listaMuebles.get(i).getStockMinimoMueble();
            rowData[9] = listaMuebles.get(i).getCantidadMueble();
            modelo.addRow(rowData);
        }
    }

    /**
     *
     * Limpia todos los campos de la pestaña agregar
     */
    public void limpiar() {
        nombretf.setText("");
        tipotf.setText("");
        preciotf.setText("");
        sminimotf.setText("");
        materialtf.setText("");
        colortf.setText("");
        altotf.setText("");
        anchotf.setText("");
        profundidadtf.setText("");
        cantidadtf.setText("");
    }

    /**
     * Realiza una consulta y obtiene los datos de los Muebles
     *
     * @param query La consulta que se utilizará para los muebles
     * @return ArrayList de objetos Mueble
     */
    public ArrayList<Mueble> obtenerDatos(String query) {
        ArrayList<Mueble> lista = new ArrayList<>();
        try {
            con = new Conexion().connection();
            s = con.createStatement();
            rs = s.executeQuery(query);

            while (rs != null && rs.next()) {
                Mueble mueble = new Mueble();
                mueble.setNombreMueble(rs.getString("nombreMueble"));
                mueble.setTipoMueble(rs.getString("tipoMueble"));
                mueble.setPrecioMueble(rs.getDouble("precioMueble"));
                mueble.setMaterialMueble(rs.getString("materialMueble"));
                mueble.setColorMueble(rs.getString("colorMueble"));
                mueble.setAlturaMueble(rs.getDouble("alturaMueble"));
                mueble.setBaseMueble(rs.getDouble("baseMueble"));
                mueble.setProfundidadMueble(rs.getDouble("profundidadMueble"));
                mueble.setStockMinimoMueble(rs.getInt("stockMinimoMueble"));
                mueble.setCantidadMueble(rs.getInt("existenciasAlmacen"));
                lista.add(mueble);
            }

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Administrar.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    /**
     * Se utiliza para poder filtrar los mubles en tiempo real
     *
     * @param filtro La palabra "Filtro" que se utiliza para la consulta
     * @return Consulta con la palbra para filtrar
     */
    public String filtrado(String filtro) {
        return "SELECT Mueble.nombreMueble, Mueble.tipoMueble, Mueble.precioMueble, "
                + "Mueble.materialMueble, Mueble.colorMueble, Mueble.alturaMueble, "
                + "Mueble.baseMueble, Mueble.profundidadMueble, Mueble.stockMinimoMueble, "
                + "AlmacenGuardaMueble.existenciasAlmacen FROM Mueble, AlmacenGuardaMueble "
                + "WHERE Mueble.idMueble = AlmacenGuardaMueble.mueble_idMueble AND "
                + "Mueble.nombreMueble LIKE '" + filtro + "%';";
    }

    /**
     * Agrega un nuevo mueble a la base de datos.
     *
     * @param nombre Nombre del mueble
     * @param tipo Tipo de mueble
     * @param precio Precio del mueble
     * @param stock La cantidad mínima de muebles que puede haber
     * @param material Material del mueble
     * @param color Color del mueble
     * @param altura Altura (cm o m) del mueble
     * @param base Base (cm o m) del mueble
     * @param profundidad Profundidad (cm o m) del mueble
     * @param cantidad Existencias del mueble
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public void insertarMueble(String nombre, String tipo, String precio, String stock,
            String material, String color, String altura, String base, String profundidad, String cantidad)
            throws SQLException, ClassNotFoundException {

        sQuery = "INSERT INTO Mueble (nombreMueble, precioMueble, tipoMueble, stockMinimoMueble, "
                + "baseMueble, alturaMueble, profundidadMueble, colorMueble, materialMueble) "
                + "VALUES ('" + nombre + "', " + precio + ", '" + tipo + "', " + stock + ", '"
                + base + "', '" + altura + "', '" + profundidad + "', '" + color + "', '" + material + "');";

        update(sQuery);

        sQuery = "INSERT INTO AlmacenGuardaMueble (Almacen_idAlmacen, "
                + "Mueble_idMueble, existenciasAlmacen) VALUES (1, " + getIDMueble() + "," + cantidad + ");";

        update(sQuery);
    }

    /**
     * Función que realiza un update válido cualquiera.
     *
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
     * Función que recupera el ID del último mueble agregado a la base de datos.
     *
     * @return Retorna el ID del último mueble agregado.
     * @throws SQLException
     */
    public int getIDMueble() throws SQLException {
        sQuery = "SELECT MAX(idMueble) FROM Mueble;";

        try {
            con = new Conexion().connection();
            s = con.createStatement();
            rs = s.executeQuery(sQuery);

            if (rs != null && rs.next()) {
                return rs.getInt("MAX(idMueble)");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Administrar.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            con.close();
        }
        return 0;
    }

    /**
     * Localiza el número de la fila en que está posicionado el usuario.
     * @return Número de la fila donde se encuentra el usuario.
     */
    public int posicionTabla() {
        return jTable1.getSelectedRow();
    }

    /**
     * Crea un objeto tipo mueble con los datos relacionados a la posición de una fila de la tabla
     * @return Objeto Mueble con los atributos de la fila seleccionada.
     */
    public Mueble datosMueble() {
        Mueble mueble = new Mueble();
        mueble.setNombreMueble(jTable1.getValueAt(posicionTabla(), 0).toString());
        mueble.setTipoMueble(jTable1.getValueAt(posicionTabla(), 1).toString());
        mueble.setPrecioMueble(MetodosUtiles.stringADouble(jTable1.getValueAt(posicionTabla(), 2).toString()));
        mueble.setMaterialMueble(jTable1.getValueAt(posicionTabla(), 3).toString());
        mueble.setColorMueble(jTable1.getValueAt(posicionTabla(), 4).toString());
        mueble.setAlturaMueble(MetodosUtiles.stringADouble(jTable1.getValueAt(posicionTabla(), 5).toString()));
        mueble.setBaseMueble(MetodosUtiles.stringADouble(jTable1.getValueAt(posicionTabla(), 6).toString()));
        mueble.setProfundidadMueble(MetodosUtiles.stringADouble(jTable1.getValueAt(posicionTabla(), 7).toString()));
        mueble.setStockMinimoMueble(MetodosUtiles.stringAInt(jTable1.getValueAt(posicionTabla(), 8).toString()));
        mueble.setCantidadMueble(MetodosUtiles.stringAInt(jTable1.getValueAt(posicionTabla(), 9).toString()));
        return mueble;
    }

    /**
     * Elimina un mueble de la base de datos.
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    public void eliminarMueble() throws ClassNotFoundException, SQLException {
        int idMueble = 0;
        int existenciasMueble = 0;

        sQuery = "SELECT Mueble.idMueble, AlmacenGuardaMueble.existenciasAlmacen "
                + "FROM Mueble, AlmacenGuardaMueble WHERE Mueble.idMueble = "
                + "AlmacenGuardaMueble.Mueble_idMueble AND Mueble.nombreMueble "
                + "= '" + nombreMueble + "' AND Mueble.colorMueble = '" + colorMueble + "';";

        try {
            con = new Conexion().connection();
            s = con.createStatement();
            rs = s.executeQuery(sQuery);

            if (rs != null && rs.next()) {
                idMueble = rs.getInt("idMueble");
                existenciasMueble = rs.getInt("existenciasAlmacen");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Administrar.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            con.close();
        }

        if (existenciasMueble == 0) {
            int response = JOptionPane.showConfirmDialog(null, "¿Seguro que desea eliminar el mueble seleccionado?", "Eliminar",
                    JOptionPane.YES_NO_OPTION, JOptionPane.ERROR_MESSAGE);

            if (response == JOptionPane.YES_OPTION) {
                sQuery = "DELETE FROM AlmacenGuardaMueble WHERE Mueble_idMueble "
                        + "= " + idMueble + ";";
                update(sQuery);
                sQuery = "DELETE FROM Mueble WHERE nombreMueble = '" + nombreMueble
                        + "' AND colorMueble = '" + colorMueble + "';";
                update(sQuery);
                rellenarTabla(inicial);
                JOptionPane.showMessageDialog(null, "Mueble eliminado",
                        "Éxito al eliminar",
                        JOptionPane.INFORMATION_MESSAGE);
            }
        } else {
            JOptionPane.showMessageDialog(null, "No se pueden eliminar muebles"
                    + "con existencias", "Imposible eliminar",
                    JOptionPane.WARNING_MESSAGE);
        }
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jTabbedPane1 = new javax.swing.JTabbedPane();
        jPanel4 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        profundidadtf = new javax.swing.JTextField();
        anchotf = new javax.swing.JTextField();
        altotf = new javax.swing.JTextField();
        colortf = new javax.swing.JTextField();
        materialtf = new javax.swing.JTextField();
        jLabel13 = new javax.swing.JLabel();
        jLabel14 = new javax.swing.JLabel();
        jLabel15 = new javax.swing.JLabel();
        jPanel3 = new javax.swing.JPanel();
        limpiar = new javax.swing.JButton();
        agregar = new javax.swing.JButton();
        regresar = new javax.swing.JButton();
        jPanel1 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel8 = new javax.swing.JLabel();
        jLabel9 = new javax.swing.JLabel();
        nombretf = new javax.swing.JTextField();
        tipotf = new javax.swing.JTextField();
        preciotf = new javax.swing.JTextField();
        sminimotf = new javax.swing.JTextField();
        jLabel11 = new javax.swing.JLabel();
        cantidadtf = new javax.swing.JTextField();
        jPanel5 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        jPanel6 = new javax.swing.JPanel();
        btEditar = new javax.swing.JButton();
        btEliminar = new javax.swing.JButton();
        bRegresar = new javax.swing.JButton();
        jTextField1 = new javax.swing.JTextField();
        jLabel12 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        jTabbedPane1.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        jPanel4.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Características", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Lucida Sans", 0, 12))); // NOI18N
        jPanel2.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        jLabel3.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel3.setText("Material:");

        jLabel4.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel4.setText("Color:");

        jLabel5.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel5.setText("Alto:");

        jLabel6.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel6.setText("Ancho:");

        jLabel7.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel7.setText("Profundidad:");

        jLabel13.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel13.setText("metros");

        jLabel14.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel14.setText("metros");

        jLabel15.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel15.setText("metros");

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel7)
                    .addComponent(jLabel6)
                    .addComponent(jLabel5)
                    .addComponent(jLabel4)
                    .addComponent(jLabel3))
                .addGap(49, 49, 49)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(materialtf, javax.swing.GroupLayout.PREFERRED_SIZE, 139, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(colortf)
                        .addComponent(altotf)
                        .addComponent(anchotf)
                        .addComponent(profundidadtf, javax.swing.GroupLayout.DEFAULT_SIZE, 139, Short.MAX_VALUE)))
                .addGap(8, 8, 8)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel13)
                    .addComponent(jLabel15)
                    .addComponent(jLabel14)))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel3)
                    .addComponent(materialtf, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel4)
                    .addComponent(colortf, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel5)
                    .addComponent(altotf, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel14))
                .addGap(18, 18, 18)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel6)
                    .addComponent(anchotf, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel13))
                .addGap(18, 18, 18)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel7)
                    .addComponent(profundidadtf, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel15))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jPanel3.setBorder(javax.swing.BorderFactory.createTitledBorder(""));
        jPanel3.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        limpiar.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        limpiar.setText("Limpiar");
        limpiar.setToolTipText("");
        limpiar.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        limpiar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                limpiarActionPerformed(evt);
            }
        });

        agregar.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        agregar.setText("Agregar");
        agregar.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        agregar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                agregarActionPerformed(evt);
            }
        });

        regresar.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        regresar.setText("Regresar");
        regresar.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        regresar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                regresarActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(regresar, javax.swing.GroupLayout.PREFERRED_SIZE, 100, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(limpiar, javax.swing.GroupLayout.PREFERRED_SIZE, 100, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(agregar, javax.swing.GroupLayout.PREFERRED_SIZE, 100, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(limpiar)
                    .addComponent(agregar)
                    .addComponent(regresar))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Detalles", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Lucida Sans", 0, 12))); // NOI18N
        jPanel1.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        jLabel1.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel1.setText("Nombre:");

        jLabel2.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel2.setText("Tipo:");

        jLabel8.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel8.setText("Precio:");

        jLabel9.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel9.setText("Stock minimo:");

        nombretf.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                nombretfActionPerformed(evt);
            }
        });

        preciotf.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                preciotfActionPerformed(evt);
            }
        });

        jLabel11.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel11.setText("Cantidad:");

        cantidadtf.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cantidadtfActionPerformed(evt);
            }
        });
        cantidadtf.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                cantidadtfKeyReleased(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel1)
                            .addComponent(jLabel2)
                            .addComponent(jLabel8))
                        .addGap(49, 49, 49)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(tipotf, javax.swing.GroupLayout.DEFAULT_SIZE, 169, Short.MAX_VALUE)
                            .addComponent(preciotf)
                            .addComponent(nombretf)))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel9)
                            .addComponent(jLabel11))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(cantidadtf)
                            .addComponent(sminimotf))))
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(nombretf, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(tipotf, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel8)
                    .addComponent(preciotf, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel9)
                    .addComponent(sminimotf, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel11)
                    .addComponent(cantidadtf, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(27, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                .addContainerGap(43, Short.MAX_VALUE)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                    .addComponent(jPanel3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(42, 42, 42)
                        .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(29, 29, 29))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                .addGap(23, 23, 23)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(18, 18, 18)
                .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jTabbedPane1.addTab("Agregar", jPanel4);

        jTable1.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {

            }
        ));
        jTable1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseReleased(java.awt.event.MouseEvent evt) {
                jTable1MouseReleased(evt);
            }
        });
        jTable1.addPropertyChangeListener(new java.beans.PropertyChangeListener() {
            public void propertyChange(java.beans.PropertyChangeEvent evt) {
                jTable1PropertyChange(evt);
            }
        });
        jScrollPane1.setViewportView(jTable1);

        jPanel6.setBorder(javax.swing.BorderFactory.createTitledBorder(""));

        btEditar.setText("Editar");
        btEditar.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        btEditar.setEnabled(false);
        btEditar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btEditarActionPerformed(evt);
            }
        });

        btEliminar.setText("Eliminar");
        btEliminar.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        btEliminar.setEnabled(false);
        btEliminar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btEliminarActionPerformed(evt);
            }
        });

        bRegresar.setText("Regresar");
        bRegresar.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        bRegresar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                bRegresarActionPerformed(evt);
            }
        });

        jTextField1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextField1ActionPerformed(evt);
            }
        });
        jTextField1.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyTyped(java.awt.event.KeyEvent evt) {
                jTextField1KeyTyped(evt);
            }
            public void keyPressed(java.awt.event.KeyEvent evt) {
                jTextField1KeyPressed(evt);
            }
            public void keyReleased(java.awt.event.KeyEvent evt) {
                jTextField1KeyReleased(evt);
            }
        });

        jLabel12.setFont(new java.awt.Font("Lucida Sans", 0, 13)); // NOI18N
        jLabel12.setText("Filtrar:");

        javax.swing.GroupLayout jPanel6Layout = new javax.swing.GroupLayout(jPanel6);
        jPanel6.setLayout(jPanel6Layout);
        jPanel6Layout.setHorizontalGroup(
            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel6Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(bRegresar, javax.swing.GroupLayout.PREFERRED_SIZE, 100, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jLabel12)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, 185, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(btEliminar, javax.swing.GroupLayout.PREFERRED_SIZE, 100, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(btEditar, javax.swing.GroupLayout.PREFERRED_SIZE, 100, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );
        jPanel6Layout.setVerticalGroup(
            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel6Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btEditar)
                    .addComponent(btEliminar)
                    .addComponent(bRegresar)
                    .addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel12))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
        jPanel5.setLayout(jPanel5Layout);
        jPanel5Layout.setHorizontalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 738, Short.MAX_VALUE)
                    .addComponent(jPanel6, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );
        jPanel5Layout.setVerticalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 224, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(jPanel6, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jTabbedPane1.addTab("Lista", jPanel5);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jTabbedPane1)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jTabbedPane1)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

  private void btEditarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btEditarActionPerformed
      Mueble mueble = datosMueble();
      EditarMueble em = new EditarMueble(this, true);

      int idMueble = 0;
      sQuery = "SELECT idMueble FROM Mueble WHERE nombreMueble = '" + mueble.getNombreMueble()
              + "' AND colorMueble = '" + mueble.getColorMueble() + "';";

      try {
          con = new Conexion().connection();
          s = con.createStatement();
          rs = s.executeQuery(sQuery);

          if (rs != null && rs.next()) {
              idMueble = rs.getInt("idMueble");
          }
      } catch (ClassNotFoundException | SQLException ex) {
          Logger.getLogger(Administrar.class.getName()).log(Level.SEVERE, null, ex);
      } finally {
          try {
              con.close();
          } catch (SQLException ex) {
              Logger.getLogger(Administrar.class.getName()).log(Level.SEVERE, null, ex);
          }
      }
      em.llenarTF(idMueble, mueble.getNombreMueble(), mueble.getTipoMueble(), mueble.getPrecioMueble(),
              mueble.getStockMinimoMueble(), mueble.getMaterialMueble(), mueble.getColorMueble(),
              mueble.getAlturaMueble(), mueble.getBaseMueble(), mueble.getProfundidadMueble());
      em.setLocationRelativeTo(null);
      em.setVisible(true);
      rellenarTabla(inicial);

  }//GEN-LAST:event_btEditarActionPerformed

  private void jTextField1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextField1ActionPerformed
      // TODO add your handling code here:
  }//GEN-LAST:event_jTextField1ActionPerformed

  private void jTable1PropertyChange(java.beans.PropertyChangeEvent evt) {//GEN-FIRST:event_jTable1PropertyChange
      // TODO add your handling code here:
  }//GEN-LAST:event_jTable1PropertyChange

    private void bRegresarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_bRegresarActionPerformed
        Inicial inicio = new Inicial();
        inicio.setVisible(true);
        this.dispose();
    }//GEN-LAST:event_bRegresarActionPerformed

  private void jTextField1KeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_jTextField1KeyTyped

  }//GEN-LAST:event_jTextField1KeyTyped

  private void jTextField1KeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_jTextField1KeyPressed
      // TODO add your handling code here:
  }//GEN-LAST:event_jTextField1KeyPressed

  private void jTextField1KeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_jTextField1KeyReleased
      rellenarTabla(filtrado(jTextField1.getText()));
  }//GEN-LAST:event_jTextField1KeyReleased

  private void jTable1MouseReleased(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jTable1MouseReleased
      Mueble mueble = datosMueble();
      nombreMueble = mueble.getNombreMueble();
      colorMueble = mueble.getColorMueble();
      btEliminar.setEnabled(true);
      btEditar.setEnabled(true);

  }//GEN-LAST:event_jTable1MouseReleased

    private void btEliminarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btEliminarActionPerformed
        try {
            eliminarMueble();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Administrar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_btEliminarActionPerformed

    private void cantidadtfKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_cantidadtfKeyReleased

    }//GEN-LAST:event_cantidadtfKeyReleased

    private void cantidadtfActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cantidadtfActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_cantidadtfActionPerformed

    private void preciotfActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_preciotfActionPerformed

    }//GEN-LAST:event_preciotfActionPerformed

    private void nombretfActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_nombretfActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_nombretfActionPerformed

    private void regresarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_regresarActionPerformed
        Inicial inicio = new Inicial();
        inicio.setVisible(true);
        this.dispose();
    }//GEN-LAST:event_regresarActionPerformed

    private void agregarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_agregarActionPerformed
        boolean bnombre, btipo, bprecio, bminimo, bmaterial, bcolor, balto, bancho, bprofundidad, bcantidad;
        bnombre = nombretf.getText().equals("");
        btipo = tipotf.getText().equals("");
        bprecio = preciotf.getText().equals("");
        bminimo = sminimotf.getText().equals("");
        bmaterial = materialtf.getText().equals("");
        bcolor = colortf.getText().equals("");
        balto = altotf.getText().equals("");
        bancho = anchotf.getText().equals("");
        bprofundidad = profundidadtf.getText().equals("");
        bcantidad = cantidadtf.getText().equals("");

        if (bnombre != true && btipo != true && bprecio != true && bminimo != true && bmaterial != true
                && bcolor != true && balto != true && bancho != true && bprofundidad != true && bcantidad != true) {

            if (Integer.parseInt(cantidadtf.getText()) > Integer.parseInt(sminimotf.getText())) {
                try {
                    insertarMueble(nombretf.getText(), tipotf.getText(), preciotf.getText(),
                            sminimotf.getText(), materialtf.getText(), colortf.getText(),
                            altotf.getText(), anchotf.getText(), profundidadtf.getText(), cantidadtf.getText());
                    JOptionPane.showMessageDialog(this, "Los datos fueron agregados exitosamente", "Éxito", JOptionPane.INFORMATION_MESSAGE);
                    limpiar();
                } catch (SQLException | ClassNotFoundException ex) {
                    System.out.println("Error");
                }
            } else {
                JOptionPane.showMessageDialog(this, "No se pueden agregar menos "
                        + "existencias que stock mínimo", "Error", JOptionPane.WARNING_MESSAGE);
            }
        } else {
            JOptionPane.showMessageDialog(null, "Por favor complete todos los campos");
        }
        rellenarTabla(inicial);
    }//GEN-LAST:event_agregarActionPerformed

    private void limpiarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_limpiarActionPerformed
        limpiar();
    }//GEN-LAST:event_limpiarActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton agregar;
    private javax.swing.JTextField altotf;
    private javax.swing.JTextField anchotf;
    private javax.swing.JButton bRegresar;
    private javax.swing.JButton btEditar;
    private javax.swing.JButton btEliminar;
    private javax.swing.JTextField cantidadtf;
    private javax.swing.JTextField colortf;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel14;
    private javax.swing.JLabel jLabel15;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTabbedPane jTabbedPane1;
    private javax.swing.JTable jTable1;
    private javax.swing.JTextField jTextField1;
    private javax.swing.JButton limpiar;
    private javax.swing.JTextField materialtf;
    private javax.swing.JTextField nombretf;
    private javax.swing.JTextField preciotf;
    private javax.swing.JTextField profundidadtf;
    private javax.swing.JButton regresar;
    private javax.swing.JTextField sminimotf;
    private javax.swing.JTextField tipotf;
    // End of variables declaration//GEN-END:variables
}
