import java.io.*;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * Created by yanghan on 16/5/25.
 */
public class ObjectStreamTest {
    public static void main(String[] args) {
        Employee harry = new Employee("Harry Hacker", 50000, 1989, 10, 1);
        Manager carl = new Manager("Carl Cracker", 80000, 1987, 12, 15);
        carl.setSecretary(harry);
        Manager tony = new Manager("Tony Tester", 40000, 1990, 3, 15);
        tony.setSecretary(harry);

        Employee[] staff = new Employee[3];
        staff[0] = carl;
        staff[1] = harry;
        staff[2] = tony;

        try {
            ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream("employee.dat"));
            out.writeObject(staff);
            out.close();

            ObjectInputStream in = new ObjectInputStream(new FileInputStream("employee.dat"));
            Employee[] newStaff = (Employee[]) in.readObject();
            in.close();

            newStaff[1].raiseSalary(10);

            for (Employee e: newStaff) {
                System.out.println(e);
            }
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
}

class Employee implements Serializable {
    private String name;
    private double salary;
    private Date hireDay;

    public Employee() {

    }

    public Employee(String n, double s, int year, int month, int day) {
        name = n;
        salary = s;
        GregorianCalendar calendar = new GregorianCalendar(year, month-1, day);
        hireDay = calendar.getTime();
    }

    public String getName() {
        return name;
    }

    public double getSalary() {
        return salary;
    }

    public Date getHireDay() {
        return hireDay;
    }

    public void raiseSalary(double byPercent) {
        double raise = salary * byPercent / 100;
        salary += raise;
    }

    public String toString() {
        return getClass().getName() + "[name=" + name + ",salary=" + salary + ",hireDay" +
                hireDay + "]";
    }
}

class Manager extends Employee {
    private Employee secretary;

    public Manager(String n, double s, int year, int month, int day) {
        super(n, s, year, month, day);
        secretary = null;
    }

    public void setSecretary(Employee s) {
        secretary = s;
    }

    public String toString() {
        return super.toString() + "[secretary=" + secretary + "]";
    }
}