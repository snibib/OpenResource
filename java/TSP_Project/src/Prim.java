import java.util.ArrayList;
import java.util.Arrays;
import java.util.Dictionary;
import java.util.Enumeration;

/**
 * Created by yanghan on 16/2/24.
 */
public class Prim {
    final int maxInt = Integer.MAX_VALUE;
    private int number,start;//number 表示点数,START 表示起点
    int[][] map = new int[1000][1000];//矩阵保留点之间的边值
    int[] low = new int[1000];
    int[] visited = new int[1000];//到达过的点
    int[][] line = new int[1000][1000];

    private ArrayList<Integer> visitedList = new ArrayList();
    ArrayList<String> lineList = new ArrayList<>();//保存路线

    public void setNumber(int number) {
        this.number = number;
    }

    public int getNumber() {
        return number;
    }

    public void setStart(int start) {
        this.start = start;

    }

    public int getStart() {
        return start;
    }

    //PRIM算法
    public int prim() {
        int i,j,pos,min,result=0;

        pos = start;
        visited[pos] = 1;

        //初始化LOW数组
        for (i=1;i<=number;i++){
            if (i != pos) {
                low[i] = map[pos][i];
            }
        }

        visitedList.add(pos);
        for (i=1;i<number;i++) {
            //找出最小权值并记录位置
            min = maxInt;
            for (j = 1; j <= number; j++) {
                if (visited[j] == 0 && min > low[j]) {
                    min = low[j];
                    pos = j;
                }
            }

            //最小权值累加
            result += min;
            //更新标记点
            visited[pos] = 1;
            visitedList.add(pos);

            //根据已有点和计算出的线推测线路
            for (Integer station: visitedList) {
                if (map[pos][station] == min ) {
                    StringBuffer str = new StringBuffer();
                    str.append("("+station+","+pos+")"+"->"+min);
                    lineList.add(str + "\n");

                    line[station][pos] = min;
                    line[pos][station] = min;
                }

            }
            //更新权值
            for (j = 1; j <= number; j++) {
                if (visited[j] == 0 && low[j] > map[pos][j]) {
                    low[j] = map[pos][j];
                }
            }
        }
        return result;
    }
}