import javax.swing.*;
import java.awt.*;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by yanghan on 16/2/26.
 */
public class Road {
    int width = 900;
    int height = 600;
    public Road() {
        JFrame jFrame = new JFrame();

        jFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jFrame.setLayout(null);
        jFrame.setSize(width,height);

        RoadLine line = new RoadLine();
        line.setSize(jFrame.getSize());
        jFrame.add(line);
        jFrame.addComponentListener(new ComponentAdapter() {
            @Override
            public void componentResized(ComponentEvent e) {
                super.componentResized(e);
                line.repaint();
            }
        });

        ReadAndWrite read = new ReadAndWrite();
        read.intPutPath = "DataInput/roadPoints.txt";
        String result = read.readText();

        read.intPutPath = "DataInput/roadLines.txt";
        String otherResult = read.readText();

        //线
        String[] linesStr = replaceBlank(otherResult).replace("\",",";").replace("\"","").split(";");
        ArrayList<HashMap> lines = new ArrayList<>();

        for (String lineStr:linesStr) {
            String[] linePS = lineStr.replace("(","").replace(")","").split("-");
            if (linePS.length == 2) {
                String[] startPoints = linePS[0].split(",");
                String[] endPoints = linePS[1].split(",");

                int x1 = (int)(Double.parseDouble(startPoints[0])*100);
                int y1 = (int)(Double.parseDouble(startPoints[1])*100);

                int x2 = (int)(Double.parseDouble(endPoints[0])*100);
                int y2 = (int)(Double.parseDouble(endPoints[1])*100);

                Point startPoint = new Point();
                startPoint.x = x1;
                startPoint.y = y1;
                Point endPoint = new Point();
                endPoint.x = x2;
                endPoint.y = y2;

                HashMap<String,Point> location = new HashMap<>();
                location.put("start",startPoint);
                location.put("end",endPoint);
                lines.add(location);
            }
        }
        //点
        String[] pointsStr = replaceBlank(result).replace("\",",";").replace("\"","").split(";");
        ArrayList<Point> points = new ArrayList<>();

        for (String pointStr:pointsStr) {
            String[] pS = pointStr.replace("(","").replace(")","").split(",");
            if (pS.length == 2) {
                int x = (int)(Double.parseDouble(pS[0])*100);
                int y = (int)(Double.parseDouble(pS[1])*100);
                Point point = new Point();
                point.x = x;
                point.y = y;

                points.add(point);
            }
        }

        line.lines = lines;
        line.points = points;

        jFrame.setVisible(true);
    }

    public String replaceBlank(String str) {
        String dest = "";
        if (str != null) {
            Pattern p = Pattern.compile("\\s*|\t|\r|\n");
            Matcher m = p.matcher(str);
            dest = m.replaceAll("");
        }
        return dest;
    }
    public static void main(String[] args) {
        new Road();
    }
}

class RoadLine extends JPanel {
    ArrayList<HashMap> lines = new ArrayList<>();
    ArrayList<Point> points = new ArrayList<>();

    int xMin = 200;
    int xMax = this.getWidth()-200;
    int yMin = 100;
    int yMax = this.getHeight()-100;
    int sigleValue = 40;

    public RoadLine() {
        
    }

    @Override
    public void paint(Graphics g) {
        super.paint(g);
        g.setColor(Color.lightGray);
        //画表格
        for (int i=yMin;i<=yMax;i=i+sigleValue) {
            g.drawLine(xMin,i,xMax,i);
            g.drawString(Integer.toString((i-yMin)/sigleValue),xMin-20,i+5);
        }

        for (int j=xMin;j<=xMax;j=j+sigleValue) {
            g.drawLine(j,yMin,j,yMax);
            g.drawString(Integer.toString((j-xMin)/sigleValue),j-5,yMin-20);
        }

        //绘制点和线
        for (HashMap line: lines) {
            System.out.println(line.toString());
            int startx = ((Point)line.get("start")).x*sigleValue+xMin;
            int starty = ((Point)line.get("start")).y*sigleValue+yMin;

            int endx = ((Point)line.get("end")).x*sigleValue+xMin;
            int endy = ((Point)line.get("end")).y*sigleValue+yMin;

            g.setColor(Color.black);
            g.fillOval(startx-5,starty-5,10,10);
            g.fillOval(endx-5,endy-5,10,10);

            g.setColor(Color.red);
            g.drawLine(startx,starty,endx,endy);
        }
    }
}