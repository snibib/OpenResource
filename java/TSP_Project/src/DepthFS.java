import javax.xml.soap.Node;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by yanghan on 16/2/25.
 */
public class DepthFS {
    int number,start;
    int[][] line = new int[1000][1000];//最小生成树图
    int[] visited = new int[1000];

    public void depth_first_search() {
        int pos = 0;

        pos = start;
        visited[pos] = 1;

        for (int i=1;i<number;i++) {
            ArrayList<HashMap> search = new ArrayList<HashMap>();
            int minStatinon = pos;
            int minCount = Integer.MAX_VALUE;

            for (int j=1;j<=number;j++) {//为每一个节点寻找自节点顺序
                if (visited[j] == 0 && line[pos][j] != 0) {
                    //记录每一起始点的子节点
                    ArrayList<Integer> father = new ArrayList<>();
                    father.add(pos);
                    int count = statistic(j,father);
                    if (minCount >= count) {
                        minCount = count;
                        minStatinon = j;
                    }
                }
            }
            System.out.println("最小节点为 " + minStatinon + "节点数 " + minCount);
        }
    }
    //统计当前节点及其子节点树的节点总数,
    public int statistic(int pos,ArrayList<Integer> father) {
        int result = 1;
        for (int i=1;i<=number;i++) {
            if (line[pos][i] != 0 && !father.contains(i) && !father.contains(pos)) {
                father.add(pos);
                result += statistic(i,father);
            }
        }
        if (!father.isEmpty()) {
            father.remove(father.size()-1);
        }
        return result;
    }
}
