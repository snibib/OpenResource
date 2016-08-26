import java.io.*;

/**
 * Created by yanghan on 16/2/23.
 */
public class ReadAndWrite {
    String outPutPath = new String();
    String intPutPath = new String();
    public void writeText(String str) {
        try {
            //文件写入
            File f2 = new File(outPutPath);
            OutputStream stream2 = new FileOutputStream(f2);
            OutputStreamWriter writer = new OutputStreamWriter(stream2,"UTF-8");

            for (int i=0;i < str.length();i++) {
                writer.append(str.charAt(i));
            }
            writer.close();
            stream2.close();
        }
        catch (IOException e){
            System.out.println(e);
        }
    }

    public String readText() {
        String result = new String();
        try {
            //读取文件
            File f1 = new File(intPutPath);
            InputStream stream1 = new FileInputStream(f1);
            InputStreamReader reader = new InputStreamReader(stream1,"UTF-8");

            StringBuffer sb = new StringBuffer();
            while (reader.ready()) {
                sb.append((char)reader.read());
            }
            result = sb.toString();

            reader.close();
            stream1.close();
        }catch (IOException e){
            System.out.println(e);
        }

        return result;
    }
}
