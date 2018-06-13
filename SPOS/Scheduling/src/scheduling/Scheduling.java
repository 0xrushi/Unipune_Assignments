package scheduling;

import java.util.*;
import java.lang.*;

public class Scheduling {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int btArr[]={5,3,8,6};
        int atArr[]={0,1,2,3};
        int priorArr[]={0,1,2,3};
        int n = btArr.length;
        int at,bt,prior,ft,wt,tt;
        
        Process[] p = new Process[n];
        //int at, bt, ft, tt, wt, prior;
        for (int i = 0; i < n; i++) {
            p[i] = new Process((i + 1), atArr[i], btArr[i], 0, 0, 0, priorArr[i]);
        }
        
        Arrays.sort(p,Comparator.comparing(Process::getat));  //One liner for Sorting
        
//        //sorting
//        for (int i = 0; i < n - 1; i++) {
//            for (int j = 0; j < n - 1; j++) {
//                if (p[j].at > p[j + 1].at) {
//                    Process temp = p[j];
//                    p[j] = p[j + 1];
//                    p[j + 1] = temp;
//                }
//            }
//        }

        int choice;
        while (true) {
            System.out.println("Enter Choice:\n1.FCFS\n2.SJF(Preemptive)");
            System.out.println("3.Priority(Non Premptive)\n4.Round Robin(Preemptive)\n5.Exit");
            choice = sc.nextInt();
            switch (choice) {
                case 1://FCFS
                    bt = 0;
                    for (int i = 0; i < n; i++) {
                        bt = bt + p[i].bt;
                        ft = bt;
                        tt = ft - p[i].at;
                        wt = tt - p[i].bt;
                        p[i].setval(ft, tt, wt);
                    }
                    System.out.println("Process\tAT\tBT\tFT\tTT\tWT");
                    for (int i = 0; i < n; i++) {
                        p[i].display();
                    }
                    float tt1 = 0;
                    float wt1 = 0;
                    
                    //calculating average
                    for (int i = 0; i < n; i++) {
                        tt1 = tt1 + p[i].TT();
                        wt1 = wt1 + p[i].WT();
                    }
                    System.out.println("Average TT: " + tt1 / n);
                    System.out.println("Average WT: " + wt1 / n);
                    break;
                case 2://SJF
                    System.out.println("Enter time quantum: ");
                    int time_quantum = sc.nextInt();
                    int total = 0,
                    st = 0;
                    int[] f = new int[n];
                    int[] at2 = new int[n];
                    int[] bt2 = new int[n];
                    int[] ft2 = new int[n];
                    for (int i = 0; i < n; i++) {
                        at2[i] = p[i].at;
                        bt2[i] = p[i].bt;
                        ft2[i] = p[i].ft;
                    }
                    while (true) {
                        int min_bt = 1000, index = n;
                        if (total == n) {
                            break;
                        }
                        
                        //calculating min burst time and its index
                        for (int i = 0; i < n; i++) {
                            if ((at2[i] <= st) && (f[i] == 0) && (bt2[i] < min_bt)) {
                                min_bt = bt2[i];
                                index = i;
                            }
                        }
                        if (index == n) {
                            st++;
                        }
                        else{
                            if (bt2[index] > time_quantum) {
                                bt2[index] = bt2[index] - time_quantum;
                                st = st + time_quantum;
                                if (bt2[index] == 0) {
                                    ft2[index] = st;
                                    f[index] = 1;
                                    total++;
                                }
                            } else {
                                st = st + bt2[index];
                                bt2[index] = 0;
                                ft2[index] = st;
                                f[index] = 1;
                                total++;
                            }
                        }
                    }
                    for (int i = 0; i < n; i++) {
                        tt = ft2[i] - p[i].at;
                        wt = tt - p[i].bt;
                        p[i].setval(ft2[i], tt, wt);
                    }
                    System.out.println("Process\tAT\tBT\tFT\tTT\tWT");
                    for (int i = 0; i < n; i++) {
                        p[i].display();
                    }
                    tt1 = 0;
                    wt1 = 0;
                    //calculating average 
                    for (int i = 0; i < n; i++) {
                        tt1 = tt1 + p[i].TT();
                        wt1 = wt1 + p[i].WT();
                    }
                    System.out.println("Average TT: " + tt1 / n);
                    System.out.println("Average WT: " + wt1 / n);
                    break;
                case 3://Priority
                    total = 0;
                    st = 0;
                    f = new int[n];
                    at2 = new int[n];
                    bt2 = new int[n];
                    ft2 = new int[n];
                    int[] prior2 = new int[n];
                    for (int i = 0; i < n; i++) {
                        at2[i] = p[i].at;
                        bt2[i] = p[i].bt;
                        ft2[i] = p[i].ft;
                        prior2[i] = p[i].prior;
                    }
                    while (true) {
                        int min_prior = 1000, index = n;
                        if (total == n) {
                            break;
                        }
                        for (int i = 0; i < n; i++) {
                            if ((at2[i] <= st) && (f[i] == 0) && (prior2[i] < min_prior)) {
                                min_prior = prior2[i];
                                index = i;
                            }
                        }
                        if (index == n) {
                            st++;
                        }
                        else {
                            bt2[index]--;
                            st = st + 1;
                            if (bt2[index] == 0) {
                                ft2[index] = st;
                                f[index] = 1;
                                total++;
                            }
                        }
                    }
                    for (int i = 0; i < n; i++) {
                        tt = ft2[i] - p[i].at;
                        wt = tt - p[i].bt;
                        p[i].setval(ft2[i], tt, wt);
                    }
                    System.out.println("Process\tAT\tBT\tFT\tTT\tWT");
                    for (int i = 0; i < n; i++) {
                        p[i].display();
                    }
                    tt1 = 0;
                    wt1 = 0;
                    //calculating average
                    for (int i = 0; i < n; i++) {
                        tt1 = tt1 + p[i].TT();
                        wt1 = wt1 + p[i].WT();
                    }
                    System.out.println("Average TT: " + tt1 / n);
                    System.out.println("Average WT: " + wt1 / n);
                    break;
                case 4://RR
                    System.out.println("Enter time quantum: ");
                    time_quantum = sc.nextInt();

                    break;
                case 5:
                    System.exit(0);
                    break;
            }
        }
    }
}

class Process {

    int pid, at, bt, ft, tt, wt, prior;

    Process(int pid, int at, int bt, int ft, int tt, int wt, int prior) {
        this.pid = pid;
        this.at = at;
        this.bt = bt;
        this.ft = ft;
        this.tt = tt;
        this.wt = wt;
        this.prior = prior;
    }

    public void setval(int ft, int tt, int wt) {
        this.ft = ft;
        this.tt = tt;
        this.wt = wt;
    }

    public void display() {
        System.out.println(pid + "\t" + at + "\t" + bt + "\t" + ft + "\t" + tt + "\t" + wt);
    }

    public int TT() {
        return tt;
    }

    public int WT() {
        return wt;
    }
    
    public int getat(){
        return at;
    }
}
