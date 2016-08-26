package com.dmall;

import java.io.*;
import java.util.Scanner;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

/**
 * Created by yanghan on 16/5/20.
 */
public class RandomFileTest {
    public static void main(String[] args) {
        Employee[] staff = new Employee[3];

        staff[0] = new Employee("Carl Cracker",75000, 1987, 12, 15);
        staff[1] = new Employee("Harry Hacker",50000, 1989, 10, 1);
        staff[2] = new Employee("Tony Tester",40000, 1990, 3, 15);

        try {
            DataOutputStream out = new DataOutputStream(new FileOutputStream("employee.dat"));
            for (Employee e: staff) {
                e.writeData(out);
            }
            out.close();

            RandomAccessFile in = new RandomAccessFile("employee.dat","r");
            int n = (int)(in.length() / Employee.RECORD_SIZE);
            Employee[] newStaff = new Employee[n];

            for (int i=n-1;i>=0;i--) {
                newStaff[i] = new Employee();
                in.seek(i * Employee.RECORD_SIZE);
                newStaff[i].readData(in);
            }
            in.close();

            for (Employee e:newStaff) {
                System.out.println(e);
            }
        }catch (IOException e) {
            e.printStackTrace();
        }

        //写入东西到ZIP
        try {
            FileOutputStream fout = new FileOutputStream("ziptest.zip");
            ZipOutputStream zout = new ZipOutputStream(fout);

            ZipEntry ze = new ZipEntry("employee.dat");
            zout.putNextEntry(ze);

            zout.closeEntry();
            zout.close();

            System.out.println("read file from zip");
            ZipInputStream zin = new ZipInputStream(new FileInputStream("ziptest.zip"));
            ZipEntry entry;
            while ((entry = zin.getNextEntry()) != null) {
                RandomAccessFile in = new RandomAccessFile(entry.getName(),"r");
                int n = (int)(in.length() / Employee.RECORD_SIZE);
                Employee[] newStaff = new Employee[n];

                for (int i=n-1;i>=0;i--) {
                    newStaff[i] = new Employee();
                    in.seek(i * Employee.RECORD_SIZE);
                    newStaff[i].readData(in);
                }
                in.close();

                for (Employee e:newStaff) {
                    System.out.println(e);
                }
                zin.closeEntry();
            }
            zin.close();
        }catch (IOException e) {
            e.printStackTrace();
        }
    }
}
