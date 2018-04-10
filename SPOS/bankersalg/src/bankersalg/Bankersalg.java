package bankersalg;

import java.util.Arrays;
import java.util.Scanner;

public class Bankersalg {

    //private int need[][], allocate[][], max[][], avail[], np, nr;
    int allocate[][] = {{0, 1, 0}, {2, 0, 0}, {3, 0, 2}, {2, 1, 1}, {0, 0, 2}};
    int max[][] = {{7, 5, 3}, {3, 2, 2}, {9, 0, 2}, {2, 2, 2}, {4, 3, 3}};
    int avail[] = {3, 3, 2};

   final int allocate1[][] = Arrays.copyOf(allocate,allocate.length);
   final int max1[][] = Arrays.copyOf(max,max.length);
   final int avail1[] = Arrays.copyOf(avail,avail.length);

    final int np = 5;
    final int nr = 3;
    int need[][] = new int[np][nr];
    int req[] = {4, 3, 2};
    int id = 0;
    boolean success = false;

    private void input() {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter no. of processes and resources : ");
        //np = sc.nextInt();
        //nr = sc.nextInt();
        need = new int[np][nr];
        max = new int[np][nr];
        allocate = new int[np][nr];
        avail = new int[nr];

        System.out.println("Enter allocation matrix -->");
        for (int i = 0; i < np; i++) {
            for (int j = 0; j < nr; j++) //allocate[i][j] = sc.nextInt(); //allocation matrix
            {
                System.out.println("Enter max matrix -->");
            }
        }
        for (int i = 0; i < np; i++) {
            for (int j = 0; j < nr; j++) //max[i][j] = sc.nextInt(); //max matrix
            {
                System.out.println("Enter available matrix -->");
            }
        }
        for (int i = 0; i < nr; i++) //avail[i] = sc.nextInt(); //available matrix
        {
            sc.close();
        }
    }

    private int[][] calc_need() {
        for (int i = 0; i < np; i++) {
            for (int j = 0; j < nr; j++) {
                need[i][j] = max[i][j] - allocate[i][j];
            }
        }
        return need;
    }

    private boolean check(int i) {
        //checking if all resources for ith process can be allocated
        for (int j = 0; j < nr; j++) {
            if (need[i][j] > avail[j]) {
                return false;
            }
        }

        return true;
    }
    
    private boolean checkDone(boolean d[]){
        for(int i=0;i<np;i++)
            if(d[i]==false)
                return false;
        return true;
    }

    private void finaldisplay() {
        System.out.println("\nMax Matrix:");

        for (int i = 0; i < np; i++) {
            for (int j = 0; j < nr; j++) {
                System.out.print(max[i][j] + " ");
            }
            System.out.println();
        }

        System.out.println("\nNeed Maatrix");

        for (int i = 0; i < np; i++) {
            for (int j = 0; j < nr; j++) {
                System.out.print(need[i][j] + " ");
            }
            System.out.println();
        }

        System.out.println("\nAllocated Maatrix");

        for (int i = 0; i < np; i++) {
            for (int j = 0; j < nr; j++) {
                System.out.print(allocate[i][j] + " ");
            }
            System.out.println();
        }

        System.out.println("\nAvailable Matrix");

        for (int j = 0; j < nr; j++) {
            System.out.print(avail[j] + " ");
        }

    }

    public boolean checkRequestHandlerCondition() {
        Scanner sc = new Scanner(System.in);
        //int req[]=new int[nr];

        System.out.println("Enter process no.");
        id = sc.nextInt();

        for (int i = 0; i < nr; i++) {
            if (!(req[i] <= need[id][i])) {
                return false;
            }
            if (!(req[i] <= avail[i])) {
                return false;
            }
        }
        return true;
    }

    public void isSafe() {
        //input();
        avail = Arrays.copyOf(avail1,avail1.length);
        max = Arrays.copyOf(max1,max1.length);
        allocate = Arrays.copyOf(allocate1,allocate1.length);
        System.out.println("AvailMat is "+Arrays.deepToString(allocate));
        need= new int[np][nr];
        finaldisplay();
        Scanner sc = new Scanner(System.in);

        if (success) {

//            need = need1.clone();
            calc_need();
            for (int i = 0; i < nr; i++) {
                avail[i] -= req[i];
                allocate[id][i] += req[i];
                need[id][i] -= req[i];
            }
            System.out.println("Exitedfromhere");
        }
        else
        {
            //finaldisplay();       
            calc_need();
        }

        boolean done[] = new boolean[np];
        boolean allocated=false;
        int cnt = 0;//cnt is counter to count the 
        
        while (cnt < np) { //until all process allocated
            for (int i = 0; i < np; i++) {
                if (!done[i] && check(i)) {
                    for (int j = 0; j < nr; j++) {
                        avail[j] += allocate[i][j];
                    }

                    System.out.println("Success");
                    System.out.println("Allocated process : " + i);
                    System.out.println("available: ");
                    for (int j = 0; j < nr; j++) {
                        System.out.print(avail[j] + " ");
                    }
                    System.out.println("");
                    done[i] = true;
                    allocated=true;
                    cnt++;
                }
            }
            if(!allocated)
                break;
        }
        System.out.println("ikde ka nai ala");
        if (cnt==np) {
                System.out.println("\nSafely allocated");
                //finaldisplay();

                System.out.println("\nDo you want to handle requests? y/n");
                String ch = sc.next();
                if (ch.charAt(0) == 'y') {

                    success = checkRequestHandlerCondition();
                    if (success == false) {
                        System.out.println("CAnt handle requests");
                        System.exit(0);
                    }

                    //finaldisplay();
                    isSafe();
                }
            } else {
                System.out.println("All proceess cant be allocated safely ");
                if (success) {
                    System.out.println("Need to roll back , Rolling back");
                    success = false;
                    isSafe();
                }
            }
    }

    public static void main(String[] args) {
        Bankersalg b = new Bankersalg();
        b.isSafe();
    }

}
