PRG1 START 100 	
	 L 1,FIVE
	 A 1,='3'
	 MACRO 	
	 ADD &A1,&A2
	 L 5,&A1
	 A 5,&A2
	 ST 5,RES
	 MEND 	
	 MACRO 	
	 STORE &A1 	
	 L 6,&A1
	 ST 6,RES
	 MEND 	
	 MACRO 	
	 NOARG 	 	
	 L 5,6
	 ST 5,RES
	 MEND 	
	 SR 3,3
	 ADD 3,5
	 STORE 7
	 NOARG 	 	
	 BR 5,5
FIVE DC F'5' 	
RES DS F 	
	 END 	