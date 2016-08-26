/**
 * Created by yanghan on 16/2/23.
 */
import java.awt.*;
import java.io.*;
import java.util.Arrays;
import java.util.Scanner;

public class MST {
    public static void main(String[] args) {

        Prim pr = new Prim();

        pr.setNumber(7);
        pr.setStart(4);

        //初始化矩阵
        for (int i=1;i<=pr.getNumber();i++){
            for (int j=1;j<=pr.getNumber();j++){
                pr.map[i][j] = pr.maxInt;
                pr.line[i][j] = pr.maxInt;
            }
        }

        ReadAndWrite read = new ReadAndWrite();
        read.intPutPath = "DataInput/points.txt";
        read.outPutPath = "DataOutput/lines.txt";
        String[] readResults = read.readText().split(";");

        for (String str:readResults) {
            String formatStr = str.replace(" ","");
            //获得坐标点
            int beginIndex = formatStr.indexOf("(")+1;
            int endIndex = formatStr.indexOf(")");
            String pointStr = formatStr.substring(beginIndex,endIndex);
            String[] points = pointStr.split(",");
            int start = Integer.parseInt(points[0]);
            int end = Integer.parseInt(points[1]);

            //获得权值
            int valueIndex = formatStr.indexOf("=")+1;
            String valueStr = formatStr.substring(valueIndex);
            int value = Integer.parseInt(valueStr);

            pr.map[start][end] = value;
            pr.map[end][start] = value;
        }

        int result = pr.prim();

        DepthFS depth = new DepthFS();
        depth.line = pr.line;
        depth.number = pr.getNumber();
        depth.start = pr.getStart();
        depth.depth_first_search();

        StringBuffer sb = new StringBuffer();
        sb.append("图形矩阵:\n");
        for (int i=1;i<=pr.getNumber();i++){
            for (int j=1;j<=pr.getNumber();j++){
                int va = pr.map[i][j]==Integer.MAX_VALUE ? 0 : pr.map[i][j];
                sb.append(" " + va);
            }
            sb.append("\n");
        }
        sb.append("路线矩阵:\n");
        for (int i=1;i<=pr.getNumber();i++) {
            for (int j=1;j<=pr.getNumber();j++) {
                sb.append(" " + pr.line[i][j]);
            }
            sb.append("\n");
        }
        sb.append("最小生成树路线:\n");
        sb.append(pr.lineList.toString() + "\n");
        sb.append("最小生成树权值和 = " + result);
        read.writeText(sb.toString());
    }
}
