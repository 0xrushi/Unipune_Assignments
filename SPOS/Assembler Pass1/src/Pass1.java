
import java.util.*;
import java.io.*;

public class Pass1 {

    public static void ltorgFunc(int lc, String op[], boolean b, Intermediate inter) throws IOException {
        if (b == true) {
            inter.write(lc, op[0], op[1], op[2], op[3]);
        }
        final String PATH = "//home//h4x3d/TE3Sem2//SPOS//workspace//PAss1//src//";

        try {
            LiteralTable lit1 = new LiteralTable();
            BufferedReader br1 = new BufferedReader(new FileReader(PATH + "s1.txt"));
            String line1 = null;
            while ((line1 = br1.readLine()) != null) {
                StringTokenizer st3 = new StringTokenizer(line1, " ,");
                String op1[] = new String[4];
                int x = 0;
                op1[0] = st3.nextToken();
                op1[1] = st3.nextToken();
                op1[2] = st3.nextToken();
                op1[3] = st3.nextToken();

                if (op1[3].contains("=")) {
                    //split at ' and =
                    StringTokenizer st2 = new StringTokenizer(op1[3], "='");
                    String op2[] = new String[2];
                    int y = 0;

                    op2[0] = st2.nextToken();//=F'10'  => F
                    op2[1] = st2.nextToken();//value   => 10

                    int val1 = Integer.parseInt(op2[1]);
                    switch (op2[0]) {
                        case "F":
                            lit1.write(val1, lc, 4);
                            lc = lc + 4;
                            break;

                        case "H":
                            lit1.write(val1, lc, 2);
                            lc = lc + 2;
                            break;

                        case "B":
                            lit1.write(val1, lc, 1);
                            lc = lc + 1;
                            break;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) throws Exception {
        final String PATH = "//home//h4x3d/TE3Sem2//SPOS//workspace//PAss1//src//";
        Scanner sc = new Scanner(System.in);
        int choice;
        do {
            System.out.println("1.Print Source Code\n2.Print MOT\n3.Pass 1\n4.Exit\n");
            choice = sc.nextInt();
            switch (choice) {
                case 1:
                    try {
                        BufferedReader br = new BufferedReader(new FileReader(PATH + "s1.txt"));
                        String line = null;
                        while ((line = br.readLine()) != null) {
                            StringTokenizer st = new StringTokenizer(line, " ,");
                            String op[] = new String[4];
                            int i = 0;
                            while (st.hasMoreTokens()) {
                                op[i] = st.nextToken();
                                i++;
                            }
                            System.out.println(op[0] + " " + op[1] + " " + op[2] + " " + op[3]);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;

                case 2:
                    try {
                        BufferedReader br = new BufferedReader(new FileReader(PATH + "MOT.txt"));
                        String line = null;
                        while ((line = br.readLine()) != null) {
                            StringTokenizer st = new StringTokenizer(line, " ");
                            String op[] = new String[4];
                            int i = 0;
                            while (st.hasMoreTokens()) {
                                op[i] = st.nextToken();
                                i++;
                            }
                            System.out.println(op[0] + "\t" + op[1] + "\t" + op[2] + "\t" + op[3]);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;

                case 3:
                    try {
                        int addr1 = 0;
                        SymbolTable sym1 = new SymbolTable();
                        Intermediate inter = new Intermediate();
                        BufferedReader br = new BufferedReader(new FileReader(PATH + "s1.txt"));
                        String line = null;
                        int lc = 0;
                        String a1 = null;
                        boolean ltorgoccured = false;
                        
                        while ((line = br.readLine()) != null) {
                            StringTokenizer st = new StringTokenizer(line, " ,");
                            String op[] = new String[4];
                            op[0] = st.nextToken();//symbol
                            op[1] = st.nextToken();//opcode
                            op[2] = st.nextToken();//operand1
                            op[3] = st.nextToken();//operand2

                            switch (op[1]) {
                                case "START":
                                    if (!op[0].equalsIgnoreCase("\t")) {
                                        int addr = Integer.parseInt(op[2]);
                                        lc = addr;
                                        addr1 = addr;
                                        a1 = op[0];
                                    }
                                    inter.write(lc, op[0], op[1], op[2], op[3]);
                                    break;

                                case "USING":
                                    inter.write(lc, op[0], op[1], op[2], op[3]);
                                    break;

                                case "DC":
                                    String[] token = new String[2];
                                    StringTokenizer st1 = new StringTokenizer(op[2], "'");

                                    token[0] = st1.nextToken();//F
                                    token[1] = st1.nextToken();//Value

                                    int value = 0;
                                    switch (token[0]) {
                                        case "F":
                                            inter.write(lc, op[0], op[1], op[2], op[3]);
                                            value = Integer.parseInt(token[1]);
                                            sym1.write(op[0], lc, value, 4);
                                            lc = lc + 4;
                                            break;

                                        case "H":
                                            inter.write(lc, op[0], op[1], op[2], op[3]);
                                            value = Integer.parseInt(token[1]);
                                            sym1.write(op[0], lc, value, 2);
                                            lc = lc + 2;
                                            break;

                                        case "B":
                                            inter.write(lc, op[0], op[1], op[2], op[3]);
                                            value = Integer.parseInt(token[1]);
                                            sym1.write(op[0], lc, value, 1);
                                            lc = lc + 1;
                                            break;
                                    }
                                    break;

                                case "DS":
                                    int num = Integer.parseInt(Character.toString(op[2].charAt(0)));
                                    switch (op[2].charAt(1)) {
                                        case 'F':
                                            inter.write(lc, op[0], op[1], op[2], op[3]);
                                            sym1.write(op[0], lc, -1, num * 4);
                                            lc = lc + num * 4;
                                            break;

                                        case 'H':
                                            inter.write(lc, op[0], op[1], op[2], op[3]);
                                            sym1.write(op[0], lc, -1, num * 2);
                                            lc = lc + num * 2;
                                            break;

                                        case 'B':
                                            inter.write(lc, op[0], op[1], op[2], op[3]);
                                            sym1.write(op[0], lc, -1, num * 1);
                                            lc = lc + num * 1;
                                            break;
                                    }
                                    break;

                                case "L":
                                    inter.write(lc, op[0], op[1], op[2], op[3]);
                                    lc = lc + 4;
                                    break;

                                case "A":
                                    inter.write(lc, op[0], op[1], op[2], op[3]);
                                    lc = lc + 4;
                                    break;

                                case "ST":
                                    inter.write(lc, op[0], op[1], op[2], op[3]);
                                    lc = lc + 4;
                                    break;

                                case "EQU":
                                    inter.write(lc, op[0], op[1], op[2], op[3]);
                                    int val = Integer.parseInt(op[2]);
                                    sym1.write(op[0], lc, val, -1);
                                    break;

                                case "END":
                                    inter.write(lc, op[0], op[1], op[2], op[3]);
                                    int lc2 = lc - addr1;
                                    sym1.write(a1, addr1, -1, lc2);
                                    if(!ltorgoccured)
                                        ltorgFunc(lc, op, ltorgoccured, inter);
                                    break;

                                case "LTORG":
                                    ltorgoccured = true;
                                    ltorgFunc(lc, op, ltorgoccured, inter);
                                    break;
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;

                case 4:
                    System.out.println("Exit Succesfully\n");
                    break;
            }
        } while (choice != 4);

    }

}

class SymbolTable {

    final String PATH = "//home//h4x3d/TE3Sem2//SPOS//workspace//PAss1//src//";
    String symbol;
    int address, value, length;

    void write(String symbol, int address, int value, int length) throws IOException {
        this.symbol = symbol;
        this.address = address;
        this.value = value;
        this.length = length;
        FileWriter Fileright = new FileWriter(PATH + "SYM.txt", true);
        PrintWriter pw = new PrintWriter(Fileright);
        pw.println(symbol + "\t" + address + "\t" + value + "\t" + length);
        pw.flush();
        pw.close();
    }
}

class LiteralTable {

    final String PATH = "//home//h4x3d/TE3Sem2//SPOS//workspace//PAss1//src//";
    int address, literal, length;

    void write(int literal, int address, int length) throws IOException {
        this.literal = literal;
        this.address = address;
        this.length = length;
        FileWriter fw = new FileWriter(PATH + "lit.txt", true);
        PrintWriter pw = new PrintWriter(fw);
        pw.println(literal + "\t" + address + "\t" + length);
        pw.flush();
        pw.close();
    }
}

class Intermediate {

    final String PATH = "//home//h4x3d/TE3Sem2//SPOS//workspace//PAss1//src//";
    int location;
    String label, instruction, operand1, operand2;

    void write(int location, String label, String instruction, String operand1, String operand2) throws IOException {
        this.location = location;
        this.label = label;
        this.instruction = instruction;
        this.operand1 = operand1;
        this.operand2 = operand2;
        FileWriter Fileright = new FileWriter(PATH + "inter.txt", true);
        PrintWriter pw = new PrintWriter(Fileright);
        pw.println(location + "\t" + label + "\t" + instruction + "\t" + operand1 + "\t" + operand2);
        pw.flush();
        pw.close();
    }
}
