package assignment1_pass2;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Collections;
import java.util.StringTokenizer;

public class Main {

    static String PATH = "/home/h4x3d/TE3Sem2/SPOS/workspace/sposstring/src/sposstring/";
    static String asmsrc = PATH + "src_pass2.txt";
    static String btxt = PATH + "bt.txt";
    static String motf = PATH + "MOT.txt";
    static String symf = PATH + "SYM.txt";
    static String objf = PATH + "objfile.txt";
    static String litf = PATH + "lit.txt";
    static int lc = 0;

    public static void main(String args[]) throws IOException {

        FileInputStream fstream = new FileInputStream(asmsrc);
        BufferedReader br = new BufferedReader(new InputStreamReader(fstream));
        String strLine;
        String op[] = new String[4];
        while ((strLine = br.readLine()) != null) {
            StringTokenizer st = new StringTokenizer(strLine, " ,");
            op[0] = st.nextToken();//label
            op[1] = st.nextToken();//opcode
            op[2] = st.nextToken();//operand1
            //System.out.println(op[2]);
            op[3] = st.nextToken();//operand2

            System.out.println(Arrays.toString(op));

            if (searchPot2(op) == false) {
                searchMot2(op);
            }

        }
    }

    static boolean searchPot2(String[] op) throws IOException {
        int i = 0;
        
        PrintWriter pobj = new PrintWriter(new FileWriter(objf,true));
        
        switch (op[1]) {
            
            case "START":
                lc = Integer.parseInt(op[2]);
                return true;
            case "USING":
                PrintWriter pw = new PrintWriter(new FileWriter(btxt));
                
                int val = 0;
                System.out.println("***+" + op[2] + "+***");
                if (op[2].charAt(0) == '*') {
                    val = lc;
                    System.out.println("***+" + op[2] + "+***");
                } else {
                    val = Integer.parseInt(op[2]);
                }
                pw.println(op[3] + "\t" + val);
                pw.close();
                return true;
            case "DC":
                pobj.write(op[0]+" "+op[1]+" "+op[2]+" "+op[3]+ "\n");
                pobj.close();
                return true;

            case "DS":
                pobj.write(op[0]+" "+op[1]+" "+op[2]+" "+op[3]+ "\n");
                pobj.close();
                return true;

            case "EQU":
                pobj.write(op[0]+" "+op[1]+" "+op[2]+" "+op[3]+ "\n");
                pobj.close();
                return true;

            case "LTORG":
                pobj.write(op[0]+" "+op[1]+" "+op[2]+" "+op[3]+ "\n");
                pobj.close();
                return true;

            case "END":
                pobj.write(op[0]+" "+op[1]+" "+op[2]+" "+op[3]+ "\n");
                pobj.close();
                return true;

            default:
                System.out.println("erorrrr");
        }

        return false;
    }

    static String[] getBaseTableValues() throws FileNotFoundException, IOException {
        FileInputStream btstream = new FileInputStream(btxt);
        BufferedReader btbr = new BufferedReader(new InputStreamReader(btstream));
        String btLine;
        int offset = -1;
        String b1[] = new String[3];

        String s = btbr.readLine();
        StringTokenizer bst = new StringTokenizer(s, "\t");
        b1[0] = bst.nextToken();
        b1[1] = bst.nextToken();

        return b1;
    }

    static void readSymbolTable(String op[], String t1) throws FileNotFoundException, IOException {
        FileInputStream symfstream = new FileInputStream(symf);
        BufferedReader symbr = new BufferedReader(new InputStreamReader(symfstream));
        PrintWriter pw = new PrintWriter(new FileWriter(objf, true));
        String symLine;
        int EA = -1;
        int offset = -1;
        String s1[] = new String[4];

        String b1[] = getBaseTableValues();

        while ((symLine = symbr.readLine()) != null) {

            StringTokenizer st2 = new StringTokenizer(symLine, "\t");
            s1[0] = st2.nextToken();//symbol
            s1[1] = st2.nextToken();//addr
            s1[2] = st2.nextToken();//val
            s1[3] = st2.nextToken();//len

            if (s1[0].equals(op[3])) {
                EA = Integer.parseInt(s1[1]);
                offset = EA - Integer.parseInt(b1[1]) - 0;
                pw.write(t1 + "\t");
                pw.write(op[2] + "," + offset);
                pw.write("(0" + "," + b1[0] + ")\n");

            }
        }
        pw.close();
        pw.flush();
    }

    static boolean searchLiteral(String litData, String op[]) throws FileNotFoundException, IOException {
        FileReader litstream = new FileReader(litf);
        BufferedReader litbr = new BufferedReader(litstream);
        PrintWriter p2 = new PrintWriter(new FileWriter(objf, true));
        String litLine;
        String l1[] = new String[3];

        String b1[] = getBaseTableValues();

        while ((litLine = litbr.readLine()) != null) {
            StringTokenizer lst = new StringTokenizer(litLine, "\t");
            l1[0] = lst.nextToken();//value
            l1[1] = lst.nextToken();//address 
            l1[2] = lst.nextToken();//length

            if (l1[0].equals(litData)) {
                int EA = Integer.parseInt(l1[1]);

                int indexR = EA - 0 - Integer.parseInt(b1[1]);

                p2.write(l1[1] + "\t");
                p2.write(op[2] + ",");
                p2.write(indexR + "(" + "0" + "," + b1[0] + ")");
                p2.write("\n");
                p2.close();
                p2.flush();
                return true;
            }
        }
        return false;
    }

    static void searchMot2(String[] op) throws IOException {
        FileInputStream motfstream = new FileInputStream(motf);
        BufferedReader motbr = new BufferedReader(new InputStreamReader(motfstream));
        String motLine, get_kelela_opcode;
        String t1[] = new String[3];

        while ((motLine = motbr.readLine()) != null) {
            StringTokenizer motst = new StringTokenizer(motLine, "\t ");
            t1[0] = motst.nextToken();//opcode L,SR etc
            t1[1] = motst.nextToken();//address
            t1[2] = motst.nextToken();//length
            System.out.println(t1[0] + "------------\n" + op[1] + "--");
            String tmp_literal = "";

            if (op[1].equals(t1[0])) {
                if (op[3].contains("=")) {
                    tmp_literal = op[3].split("'")[1];
                    System.out.println(tmp_literal + "========");
                    if (searchLiteral(tmp_literal, op) == false) {
                        System.out.println("never here");
                    }
                } else {
                    readSymbolTable(op, t1[1]);
                }
            }
        }
        //return false;
    }
}
