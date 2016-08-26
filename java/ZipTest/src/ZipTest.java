import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.Scanner;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

/**
 * Created by yanghan on 16/5/23.
 */
public class ZipTest {
    public static void main(String[] args) {
        EventQueue.invokeLater(new Runnable() {
            @Override
            public void run() {
                ZipTestFrame frame = new ZipTestFrame();
                frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
                frame.setVisible(true);
            }
        });
    }
}

class ZipTestFrame extends JFrame {
    public static final int DEFAULT_WIDTH = 400;
    public static final int DEFAULT_HEIGHT = 300;
    private JComboBox fileCombo;
    private JTextArea fileText;
    private String zipname;

    public ZipTestFrame() {
        setTitle("ZipTest");
        setSize(DEFAULT_WIDTH, DEFAULT_HEIGHT);

        JMenuBar menuBar = new JMenuBar();
        JMenu menu = new JMenu("File");

        JMenuItem openItem = new JMenuItem("Open");
        menu.add(openItem);
        openItem.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JFileChooser chooser = new JFileChooser();
                chooser.setCurrentDirectory(new File("."));
                int r = chooser.showOpenDialog(ZipTestFrame.this);
                if (r == JFileChooser.APPROVE_OPTION) {
                    zipname = chooser.getSelectedFile().getPath();
                    fileCombo.removeAllItems();
                    scanZipFile();
                }
            }
        });

        JMenuItem exitItem = new JMenuItem("Exit");
        menu.add(exitItem);
        exitItem.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });

        menuBar.add(menu);
        setJMenuBar(menuBar);

        fileText = new JTextArea();
        fileCombo = new JComboBox();
        fileCombo.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                loadZipFile((String) fileCombo.getSelectedItem());
            }
        });

        add(fileCombo, BorderLayout.SOUTH);
        add(new JScrollPane(fileText), BorderLayout.CENTER);
    }

    public void scanZipFile() {
        new SwingWorker<Void, String>() {
            protected Void doInBackground() throws Exception {
                ZipInputStream zin = new ZipInputStream(new FileInputStream(zipname));
                ZipEntry entry;
                while ((entry = zin.getNextEntry()) != null) {
                    publish(entry.getName());
                    zin.closeEntry();
                }
                zin.close();
                return null;
            }

            protected void process(List<String> names) {
                for (String name: names) {
                    if (!name.startsWith("__MACOSX")) {//屏蔽解压MAC下ZIP包生成的MACOSX文件
                        fileCombo.addItem(name);
                    }
                }
            }
        }.execute();
    }

    public void loadZipFile(final String name) {
        fileCombo.setEnabled(false);
        fileText.setText("");
        new SwingWorker<Void,Void>() {
            protected Void doInBackground() throws Exception {
                try {
                    ZipInputStream zin = new ZipInputStream(new FileInputStream(zipname));
                    ZipEntry entry;

                    while ((entry = zin.getNextEntry()) != null) {
                        if (entry.getName().equals(name)) {
                            Scanner in = new Scanner(zin);
                            while (in.hasNextLine()) {
                                fileText.append(in.nextLine());
                                fileText.append("\n");
                            }
                        }
                        zin.closeEntry();
                    }
                    zin.close();
                }catch (IOException e) {
                    e.printStackTrace();
                }
                return null;
            }

            protected void done(){
                fileCombo.setEnabled(true);
            }
        }.execute();
    }
}
