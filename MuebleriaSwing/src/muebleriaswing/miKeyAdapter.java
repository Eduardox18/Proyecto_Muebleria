/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package muebleriaswing;

import java.awt.Toolkit;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;

/**
 *
 * @author lalo
 */
public class miKeyAdapter extends KeyAdapter {
    
    @Override
    public void keyTyped(KeyEvent e) {
            char c = e.getKeyChar();
            if (!(Character.isDigit(c) || 
                    (c == KeyEvent.VK_BACK_SPACE) || 
                    (c == KeyEvent.VK_DELETE) || 
                    (c == '.'))) {
                Toolkit.getDefaultToolkit().beep();
                e.consume();
            }
        }
}
