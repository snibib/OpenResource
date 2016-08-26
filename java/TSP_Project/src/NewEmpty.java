import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;

/**
 * Created by yanghan on 16/2/26.
 */
public class NewEmpty {
    public NewEmpty(){
        JFrame frame=new JFrame("棋盘测试");
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setLayout(null);
        frame.setSize(900, 650);

        JPanel panel=new JPanel();
        panel.setBounds(200, 30, 100, 30);

        JButton button=new JButton("按钮");
        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

            }
        });
        panel.add(button);

        shu a=new shu(); //关键的一步，调用Pint画棋盘
        a.setBounds(40, 40, 500, 500);

        frame.add(panel);
        frame.add(a);

        frame.setVisible(true);


    }
    public static void main(String args[]){
        new NewEmpty();
    }
}
class shu extends JPanel{
    public void paint(Graphics g)
    {
        //横线
        for (int i=40;i<=380;i=i+20)
        {
            g.drawLine(40,i,400,i);
        }
        g.drawLine(40,400,400,400);
        //竖线
        for(int j=40;j<=380;j=j+20)
        {
            g.drawLine(j,40,j,400);
        }
        g.drawLine(400,40,400,400);

        g.fillOval(97,97,6,6);
        g.fillOval(337,97,6,6);
        g.fillOval(97,337,6,6);
        g.fillOval(337,337,6,6);
        g.fillOval(217,217,6,6);
    }
}