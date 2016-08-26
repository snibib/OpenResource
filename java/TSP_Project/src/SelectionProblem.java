import java.util.ArrayList;
import java.util.Arrays;

/**
 * Created by yanghan on 16/2/29.
 */
public class SelectionProblem {

    //冒泡排序
    public void k_max_maker(int[] nums, int k) {
        if (nums.length == 0 || k == 0) {
            return;
        }
        long beginTime = System.currentTimeMillis();
        for (int i=0;i<nums.length;i++) {
            for (int j=i;j<nums.length;j++) {
                if (nums[i] < nums[j]) {
                    int temp = nums[i];
                    nums[i] = nums[j];
                    nums[j] = temp;
                }
            }
        }
        long endTime = System.currentTimeMillis();
        System.out.println("cast time :" + (endTime-beginTime));
        System.out.println("冒泡排序 结果 :" + Arrays.toString(nums));
        System.out.println("第K个最大者是 :" + nums[k-1]);
    }

    //前K放入数组,后面依次比较
    public void k_max_maker_other(int[] nums, int k) {
        if (nums.length == 0 || k == 0) {
            return;
        }
        long beginTime = System.currentTimeMillis();
        int[] knums = new int[nums.length];
        for (int i=0;i<k;i++) {
            knums[i] = nums[i];
        }

        for (int i=0;i<k;i++) {
            for (int j=i;j<k;j++) {
                if (knums[i] < knums[j]) {
                    int temp = knums[i];
                    knums[i] = knums[j];
                    knums[j] = temp;
                }
            }
        }

        for (int i=k;i<nums.length;i++) {
            if (knums[k-1] < nums[i]) {
                knums[k-1] = nums[i];
            }

            for (int j=0;j<k;j++) {
                for (int l=j;l<k;l++) {
                    if (knums[j] < knums[l]) {
                        int temp = knums[j];
                        knums[j] = knums[l];
                        knums[l] = temp;
                    }
                }
            }
        }
        long endTime = System.currentTimeMillis();
        System.out.println("cast time :" + (endTime-beginTime));
        System.out.println("k交换 结果 :" + Arrays.toString(knums));
        System.out.println("第K个最大者是 :" + knums[k-1]);
    }

    public static void main(String[] args) {
        SelectionProblem sp = new SelectionProblem();
        int[] numbers = {1,3,4,5,2,9,7,8,6};
        int k = 1;
        sp.k_max_maker(numbers,k);
        sp.k_max_maker_other(numbers,k);
    }
}
