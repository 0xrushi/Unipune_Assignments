package assignment1_pass2;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Collections;
import java.util.StringTokenizer;

public class Main {
	static String PATH="/home/h4x3d/TE3Sem2/SPOS/workspace/sposstring/src/sposstring/";
	static String asmsrc = PATH+"a2.asm";
	static String btxt=PATH+"bt.txt";
	static String motf=PATH+"mot.txt";
	static String symf=PATH+"symboltable_new.txt";
	static String objf=PATH+"objfile.txt";
	static int lc=0;

	public static void main(String args[]) throws IOException{


		FileInputStream fstream = new FileInputStream(asmsrc);
		BufferedReader br = new BufferedReader(new InputStreamReader(fstream));
		String strLine;
		String op[]=new String[4];
		while((strLine = br.readLine()) != null){
			StringTokenizer st=new StringTokenizer(strLine," ,");
			op[0]=st.nextToken();//label
			op[1]=st.nextToken();//opcode
			op[2]=st.nextToken();//operand1
			op[3]=st.nextToken();//operand2

			System.out.println(Arrays.toString(op));

			if(searchPot2(op) == false) {
				searchMot2(op);
			}

		}
	}


	static boolean searchPot2(String[] op) throws IOException {
		int i = 0;

		switch(op[1]){
		case "START":
			lc=Integer.parseInt(op[2]);
			return true;
		case "USING":
			PrintWriter pw=new PrintWriter(new FileWriter(btxt));
			int val=0;
			System.out.println("***+"+op[2]+"+***");
			if(op[2].charAt(0)=='*'){
				val=lc;
				System.out.println("***+"+op[2]+"+***");
			}
			else {
				val=Integer.parseInt(op[2]);
			}
			pw.println(op[3]+"\t"+val);
			pw.close();
			return true;

		default:
			return false;
		}
	}

	static void searchMot2(String[] op) throws IOException {
		FileInputStream motfstream = new FileInputStream(motf);
		BufferedReader motbr = new BufferedReader(new InputStreamReader(motfstream));
		String motLine,get_kelela_opcode;
		String t1[]=new String[3];

		FileInputStream symfstream = new FileInputStream(symf);
		BufferedReader symbr = new BufferedReader(new InputStreamReader(symfstream));
		String symLine;
		int EA=-1;
		String s1[]=new String[4];

		FileInputStream btstream = new FileInputStream(btxt);
		BufferedReader btbr = new BufferedReader(new InputStreamReader(btstream));
		String btLine;
		int offset=-1;
		String b1[]=new String[3];


		while((motLine = motbr.readLine())!=null){
			StringTokenizer motst=new StringTokenizer(motLine,"\t");
			t1[0]=motst.nextToken();//opcode
			t1[1]=motst.nextToken();//address
			t1[2]=motst.nextToken();//length

			if(op[1].equals(t1[0])) {
				while((symLine = symbr.readLine())!=null){
					StringTokenizer symst=new StringTokenizer(symLine,"\t");
					s1[0]=symst.nextToken();//symbol
					s1[1]=symst.nextToken();//addr
					s1[2]=symst.nextToken();//value
					s1[3]=symst.nextToken();//len

					if(op[3].equals(s1[0])){		//TEN cha lc symbol table madhun shodla
						EA=Integer.parseInt(s1[1]);
						break;
					}
				}

				while((btLine = btbr.readLine())!=null){		//read base table
					StringTokenizer btst=new StringTokenizer(btLine,"\t");
					b1[0]=btst.nextToken();
					b1[1]=btst.nextToken();
				}

				offset=EA-Integer.parseInt(b1[1]) - 0;
				PrintWriter po=new PrintWriter(new FileWriter(objf,true));
				po.println(t1[1]+"\t"+op[2]+"\t"+offset+"\t"+"("+0+","+b1[0]+")");
				po.close();

			}
		}
		//return false;
	}
}



