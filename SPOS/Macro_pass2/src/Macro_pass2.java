import java.lang.*;
import java.io.*;
import java.util.*;

import javax.xml.transform.stream.StreamResult;
public class Macro_pass2
{
	public static void main(String[] args)throws Exception
	{
		FileReader fr_inter=new FileReader("/home/sujit/eclipse-workspace/Macro_pass2/src/inter.txt");
		BufferedReader br_inter=new BufferedReader(fr_inter);
		FileReader fr_mdt=new FileReader("/home/sujit/eclipse-workspace/Macro_pass2/src/mdt.txt");
		BufferedReader br_mdt=new BufferedReader(fr_mdt);	
		String line_inter;
		String[] op_inter=new String[3];
		int mdtc=0;
		while((line_inter=br_inter.readLine())!=null)
		{
			int i=0;
			StringTokenizer st_inter=new StringTokenizer(line_inter," ");
			while(st_inter.hasMoreTokens())
			{
				op_inter[i]=st_inter.nextToken();
				i++;
			}
			String line_mnt;
			String[] op_mnt=new String[3];
			FileReader fr_mnt=new FileReader("/home/sujit/eclipse-workspace/Macro_pass2/src/mnt.txt");
			BufferedReader br_mnt=new BufferedReader(fr_mnt);
			int flag=0;
			while((line_mnt=br_mnt.readLine())!=null)
			{
				int j=0;
				StringTokenizer st_mnt=new StringTokenizer(line_mnt," ");
				while(st_mnt.hasMoreTokens())
				{
					op_mnt[j]=st_mnt.nextToken();
					j++;
				}
				if(op_inter[1].equals(op_mnt[1]))
				{
					flag=1;
					mdtc=Integer.parseInt(op_mnt[2]);
					String line_mdt;
					String[] op_mdt=new String[3];
					while((line_mdt=br_mdt.readLine())!=null)
					{
						int k=0;
						StringTokenizer st_mdt=new StringTokenizer(line_mdt," ");
						while(st_mdt.hasMoreTokens())
						{
							op_mdt[k]=st_mdt.nextToken();
							k++;
						}
						if(op_mdt[1].equals("MEND"))
						{
							break;
						}
						String[] op_mdt_arg=new String[5];
						int n=0;
						StringTokenizer st_mdt_arg=new StringTokenizer(op_mdt[2],",");
						while(st_mdt_arg.hasMoreTokens())
						{
							op_mdt_arg[n]=st_mdt_arg.nextToken();
							n++;
						}
						if(mdtc==Integer.parseInt(op_mdt[0]))
						{
							String[] op_inter_arg=new String[5];
							int m=0;
							StringTokenizer st_inter_arg=new StringTokenizer(op_inter[2],",");
							while(st_inter_arg.hasMoreTokens())
							{
								op_inter_arg[m]=st_inter_arg.nextToken();
								m++;
							}
							int p=0;
							while(p<n)
							{
								FileWriter fw_ala=new FileWriter("/home/sujit/eclipse-workspace/Macro_pass2/src/ala.txt",true);
								PrintWriter pw_ala=new PrintWriter(fw_ala);
								pw_ala.append(op_inter_arg[p]+" "+op_mdt_arg[p]+"\n");
								pw_ala.flush();
								pw_ala.close();
								p++;
							}
						}
						else
						{
							if(op_mdt_arg[1].contains("#"))
							{
								FileReader fr_ala=new FileReader("/home/sujit/eclipse-workspace/Macro_pass2/src/ala.txt");
								BufferedReader br_ala=new BufferedReader(fr_ala);
								String line_ala;
								String[] op_ala=new String[2];
								while((line_ala=br_ala.readLine())!=null)
								{
									int q=0;
									StringTokenizer st_ala=new StringTokenizer(line_ala," ");
									while(st_ala.hasMoreTokens())
									{
										op_ala[q]=st_ala.nextToken();
										q++;
									}
									if(op_ala[1].equals(op_mdt_arg[1]))
									{
										FileWriter fr_obj=new FileWriter("/home/sujit/eclipse-workspace/Macro_pass2/src/obj.txt",true);
										PrintWriter pw_obj=new PrintWriter(fr_obj);
										pw_obj.append(op_inter[0]+" "+op_mdt[1]+" "+op_mdt_arg[0]+","+op_ala[0]+"\n");
										pw_obj.flush();
										pw_obj.close();
									}
								}
							}
							else
							{
								FileWriter fr_obj=new FileWriter("/home/sujit/eclipse-workspace/Macro_pass2/src/obj.txt",true);
								PrintWriter pw_obj=new PrintWriter(fr_obj);
								pw_obj.append(op_inter[0]+" "+op_mdt[1]+" "+op_mdt[2]+"\n");
								pw_obj.flush();
								pw_obj.close();
							}
						}
					}
				}
			}
			if(flag==0)
			{
				FileWriter fr_obj=new FileWriter("/home/sujit/eclipse-workspace/Macro_pass2/src/obj.txt",true);
				PrintWriter pw_obj=new PrintWriter(fr_obj);
				pw_obj.append(op_inter[0]+" "+op_inter[1]+" "+op_inter[2]+"\n");
				pw_obj.flush();
				pw_obj.close();
			}
		}
	}
}