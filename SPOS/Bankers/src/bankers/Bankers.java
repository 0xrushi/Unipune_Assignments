package bankers;

import java.util.Arrays;
import java.util.Scanner;

public class Bankers {
    static int allocate[][]={{0,1,0},{2,0,0},{3,0,2},{2,1,1},{0,0,2}};
    static int max[][] = {{7,5,3},{3,2,2},{9,0,2},{2,2,2},{4,3,3}};
    static int avail[][] = {{3,3,2}};
    static int avail1[][] = {{3,3,2}};
    
    static int avail_save[][];
    static int req[];
    
    static int np=5,nr=3,req_n;
    
    static int need[][] = new int [np][nr];
    static int sequence[]=new int[np];
    
    Scanner sc=new Scanner(System.in);
    
    private void input(){
        //need
    }
    
    public static int[][] calc_need(){
     for(int i=0;i<np;i++)
         for(int j=0;j<nr;j++){
             need[i][j]=max[i][j]-allocate[i][j];
         }
     return need;
    }
    
    public static boolean check(int i){
        //checking if all resources for ith process can be allocated
        for(int j=0;j<nr;j++){
            if(avail[0][j]<need[i][j]){
                return false;
            }
        }
        return true;
    }
    
    public static boolean check1(){
        System.out.println(Arrays.deepToString(need));
        for(int i=0;i<nr;i++){
            System.out.println("req i "+need[req_n-1][i]+" i="+i);
            if(req[i]>need[req_n-1][i] && req[i]>avail_save[0][i]){
                return false;
            }
        }
        return true;
    }
    
    public static boolean isSafe(){
        boolean done[]=new boolean[np];
        int j=0;
        while(j<np){
            //until all process allocated\
            boolean allocated=false;
            for(int i=0;i<np;i++){
                if(done[i]==false && check(i)){
                    for(int k=0;k<nr;k++){
                        avail[0][k]+=allocate[i][k];
                    }
                    allocated=true;
                    done[i]=true;
                    sequence[j]=i+1;
                    j++;
                }
            }
            if(allocated==false){
                break; //if no allocation
            }
        }
        
        if(j==np){
            System.out.println("Safely Allocated");
            System.out.println("Sequence is :");
            for(int i=0;i<np;i++)
                System.out.println("P"+sequence[i]+" ");
            return true;
        }
        else{
            System.out.println("All process cant be allocated"+j);
            return false;
        }
    }
    
    public static void request(){
        int allocate_save[][]=Arrays.copyOf(allocate,allocate.length);
        int need_save[][]=Arrays.copyOf(need, need.length);
        avail_save=Arrays.copyOf(avail, avail.length);
        avail=Arrays.copyOf(avail1, avail1.length);
        
        
        req=new int[]{1,0,2};
        
        req_n=2;
        
        if(check1()){
            for(int i=0;i<nr;i++){
                allocate[req_n-1][i]+=req[i];
                need[req_n-1][i]-=req[i];
                avail[0][i]-=req[i];
            }
            
            if(isSafe()){
                System.out.println("All matrix updated");
            }
            else{
                allocate=Arrays.copyOf(allocate_save, allocate_save.length);
                need=Arrays.copyOf(need_save, need_save.length);
                avail=Arrays.copyOf(avail_save, avail_save.length);
                System.out.println("Request not granted all matrices recovered");
            }
        }
        else{
            System.out.println("Request should less than need and avail matrix: ");
        }
    }
    
    public static void main(String[] args) {
        need=calc_need();
        System.out.println(Arrays.deepToString(need));
        boolean b=isSafe();
        request();
    }
}
