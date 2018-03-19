PRG1 START 100 	
	 L 1,FIVE
	 A 1,='3'
	 MACRO 	
	 ADD &1,&2
	 L 5,&A1
	 A 5,&A2
	 ST 5,RES
	 MEND 	
	 SR 3,3
	 ADD 3,5
	 BR 5,5
FIVE DC F'5' 	
RES DS F 	
	 END 	