import javax.swing.*;
import javax.swing.event.*;
import java.awt.*;
import java.awt.event.*;
import java.io.Serializable;

/**
 * Created by yanghan on 16/2/26.
 */
public class HelloWorld extends JFrame{
    private JLabel jLabel;
    private JButton jButton;
    private JTextField jTextField;

    public HelloWorld() {
        super();
        this.setSize(300,200);
        this.getContentPane().setLayout(null);
        this.add(getJLabel(),null);
        this.add(getjTextField(),null);
        this.add(getjButton(),null);
        this.setTitle("Hello World");
    }

    private javax.swing.JLabel getJLabel() {
        if (jLabel == null) {
            jLabel = new javax.swing.JLabel();
            jLabel.setBounds(34,49,53,18);
            jLabel.setText("Name");
        }

        return jLabel;
    }

    private javax.swing.JButton getjButton() {
        if (jButton == null) {
            jButton = new javax.swing.JButton();
            jButton.setBounds(103,110,71,27);
            jButton.setText("OK");
            jButton.addActionListener(new HelloListener());
        }
        return jButton;
    }

    private javax.swing.JTextField getjTextField() {
        if (jTextField == null) {
            jTextField = new javax.swing.JTextField();
            jTextField.setBounds(96,49,160,20);
        }
        return jTextField;
    }

    public static void main(String[] args) {
        HelloWorld w = new HelloWorld();
        w.setVisible(true);
    }

    class HelloListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            getjTextField().setText("hello");
        }
    }
}
