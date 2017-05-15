/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package muebleriaswing;

/**
 *
 * @author andre
 */
public abstract class MetodosUtiles {
    
    public static double stringADouble(String cuerda) {
        Double doble = Double.parseDouble(cuerda);
        return doble;
    }

    public static int stringAInt(String cuerda) {
        Integer entero = Integer.parseInt(cuerda);
        return entero;
    }

    public static String dobleAString(Double doble) {
        return doble.toString();
    }

    public static String intAString(Integer entero) {
        return entero.toString();
    }
    
    public static int objectAInt(Object objeto) {
        return (Integer) objeto;
    }
}
