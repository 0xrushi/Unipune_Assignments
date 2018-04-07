package bankersalg;

import java.util.Scanner;


public class Bankersalg {

    //private int need[][], allocate[][], max[][], avail[], np, nr;
    int allocate[][]={{0,1,0},{2,0,0},{3,0,2},{2,1,1},{0,0,2}};
    int max[][]={{7,5,3},{3,2,2},{9,0,2},{2,2,2},{4,3,3}};
    int avail[]={3,3,2};
    int np=5;
    int nr=3;
    int need [][] = new int[np][nr];

    private void input() {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter no. of processes and resources : ");
        np = sc.nextInt(); 
        nr = sc.nextInt();
        need = new int[np][nr];
        max = new int[np][nr];
        allocate = new int[np][nr];
        avail = new int[nr];

        System.out.println("Enter allocation matrix -->");
        for (int i = 0; i < np; i++)
            for (int j = 0; j < nr; j++)
                //allocate[i][j] = sc.nextInt(); //allocation matrix

        System.out.println("Enter max matrix -->");
        for (int i = 0; i < np; i++)
            for (int j = 0; j < nr; j++)
                //max[i][j] = sc.nextInt(); //max matrix

        System.out.println("Enter available matrix -->");
        for (int i = 0; i < nr; i++)
            //avail[i] = sc.nextInt(); //available matrix

        sc.close();
    }

    private int[][] calc_need() {
        for (int i = 0; i < np; i++)
            for (int j = 0; j < nr; j++) 
                need[i][j] = max[i][j] - allocate[i][j];

        return need;
    }

    private boolean check(int i) {
        //checking if all resources for ith process can be allocated
        for (int j = 0; j < nr; j++)
            if (need[i][j]>avail[j])
                return false;

        return true;
    }

    public void isSafe() {
        //input();
        calc_need();
        boolean done[] = new boolean[np];
        int cnt = 0;

        while (cnt < np) { //until all process allocated
            for (int i = 0; i < np; i++)
                if (!done[i] && check(i)) {
                    for (int j = 0; j < nr; j++){
                        avail[j] += allocate[i][j];
                    }
                    System.out.println("Allocated process : " + i);
                    done[i] = true;
                    cnt++;
                }
        }
        if (cnt == np)
            System.out.println("\nSafely allocated");
        else
            System.out.println("All proceess cant be allocated safely");
    }

    public static void main(String[] args) {
        Bankersalg b = new Bankersalg();
        b.isSafe();
    }

}