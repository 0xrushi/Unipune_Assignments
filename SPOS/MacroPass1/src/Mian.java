import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.StringTokenizer;


class MNT{
	public void write(int mntc,String name,int mdtc) throws IOException{
	PrintWriter pw=new PrintWriter(new FileWriter(Constants.mnt,true));
	pw.println(mntc+"\t"+name+"\t"+mdtc);
	pw.flush();
	pw.close();
	}
}

class MDT{
	public void write(int mdtc,String instruction) throws IOException{
		PrintWriter pw=new PrintWriter(new FileWriter(Constants.mdt,true));
		pw.println(mdtc+"\t"+instruction);
		pw.flush();
		pw.close();
	}
}

class ALA{
	public void write(int ind,String arg) throws IOException{
		PrintWriter pw=new PrintWriter(new FileWriter(Constants.ala,true));
		pw.println(ind+"\t"+arg);
		pw.flush();
		pw.close();
		}
}

class Intermediate{
	public void write(int loc,String label,String opcode,String operand) throws IOException{
		PrintWriter pw=new PrintWriter(new FileWriter(Constants.intermediate,true));
		pw.println(loc+"\t"+label+"\t"+opcode+"\t"+operand);
		pw.flush();
		pw.close();
	}
}

class Constants{
	final static String PATH="/home/h4x3d/Documents/TE3Sem2/Unipune_Assignments/SPOS/MacroPass1/src/";
	final static String source=PATH+"source.asm";
	final static String intermediate=PATH+"intermediate.txt";
	final static String mnt=PATH+"mnt.txt";
	final static String mdt=PATH+"mdt.txt";
	final static String ala=PATH+"ala.txt";
}

public class Mian {
	public static void main(String args[]) throws IOException{
		BufferedReader br= new BufferedReader(new FileReader(Constants.source));
		String source_line;
		String [] source_token=new String[4];
		MDT mdt=new MDT();
		MNT mnt=new MNT();
		ALA ala=new ALA();
		Intermediate imt=new Intermediate();
		int mdtc=0,mntc=0,ala_ind=0,counter=0;
		boolean mendoccurred=false,macrooccurred=false;
		HashMap<String, Integer>map=new HashMap<String,Integer>();
		
		while((source_line=br.readLine())!=null){
                    
			//System.out.println(source_line);
			StringTokenizer st=new StringTokenizer(source_line," ");
			source_token[0]=st.nextToken();//label
			source_token[1]=st.nextToken();//opcode
			source_token[2]=st.nextToken();//operands
			
			if(source_token[1].equals("MEND")){
				mendoccurred=true;
				mdt.write(mdtc,source_token[1]);
				mdtc++;
			}
			
			if(source_token[1].equals("MACRO")){
				macrooccurred=true;
				source_line=br.readLine();
				st=new StringTokenizer(source_line," ");
				source_token[0]=st.nextToken();//label
				source_token[1]=st.nextToken();//opcode
				source_token[2]=st.nextToken();//operands
				
                                System.out.println(source_token[2]);
				st=new StringTokenizer(source_token[2],",");

				while(st.hasMoreTokens()&&source_token[2].contains("&")){
					String arg_i=st.nextToken();
					//System.out.println(arg_i);
					ala.write(ala_ind, arg_i);
                    map.put(arg_i, ala_ind);
                    source_line=source_line.replaceAll(arg_i, "#"+ala_ind);
					ala_ind++;
				}
				mdt.write(mdtc,source_line );
				mnt.write(mntc, source_token[1], mdtc);
				mntc++;
				mdtc++;
				
			}
			else if(!mendoccurred&&macrooccurred){
                            for(HashMap.Entry<String,Integer> entry:map.entrySet())
				{
					String key=entry.getKey();
					String val=String.valueOf(entry.getValue());
					System.out.println(val+"value");
                                        System.out.println(key+"asdfg");
                                        source_line=source_line.replaceAll(key, "#"+val);
                                        System.out.println(source_line);
				}
				mdt.write(mdtc,source_line.replace("&", "#"));
				mdtc++;
			}
                        else if(!mendoccurred){
				imt.write(counter, source_token[0], source_token[1], source_token[2]);
				counter++;
			}
                        if(mendoccurred&&macrooccurred){
                            mendoccurred=false;
                            macrooccurred=false;
//                            map.clear();
                        }
			
		}
	}
}
