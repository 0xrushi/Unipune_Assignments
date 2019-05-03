"""https://sandilands.info/sgordon/teaching/css322y12s2/unprotected/CSS322Y12S2H02-Simplified-AES-Example.pdf"""

from pyfinite import ffield
F = ffield.FField(4)
plaintext="1101011100101000"
key="0100101011110101"

#plaintext = input("Enter plaintext to encrypt: ")
#key = input("Enter a 16 bit key: ")

S_Box={'0000':'1111','0001':'0100','0010':'1010','0011':'1011','0100':'1101','0101':'0001','0110':'0101','0111':'1000',
'1000':'0110','1001':'0010','1010':'0000','1011':'0011','1100':'1100','1101':'1110','1110':'1001','1111':'0111'}
InvS_Box=dict((v,k) for k,v in S_Box.items())

def RotNibble(text):
	return text[4::]+text[:4:]

def SubNibble(text,box):
	temp=''
	for i in range(0,len(text),4):
		temp+=box[text[i:i+4]]
	return temp

'''Append bits to binary string'''
def gen_bits(text,bits):
	return '0'*(bits-len(text))+text

'''Perform EXOR operation'''
def EXOR(text1,text2,bits):
	ex=bin(int(text1,2)^int(text2,2))[2:]
	ex=gen_bits(ex,bits)
	return ex

def ShiftRow(text):
	return text[:4]+text[12:16]+text[8:12]+text[4:8]

def mult(num1,num2):
	num2=int(num2,2)
	p=0
	while num2:
		if num2 & 0b1:
			p^=num1
		num1 <<=1
		if num1 & 0b10000:
			num1 ^=0b11
		num2 >>= 1
	return gen_bits(bin(p & 0b1111)[2:],4)

def MixColumns(text):
	S00=EXOR(text[:4],mult(4,text[8:12]),4)
	S01=EXOR(text[4:8],mult(4,text[12:16]),4)
	S10=EXOR(text[8:12],mult(4,text[:4]),4)
	S11=EXOR(text[12:16],mult(4,text[4:8]),4)
	return S00+S10+S01+S11

def InverseMixColumns(text):
	S00=EXOR(mult(9,text[:4]),mult(2,text[4:8]),4)
	S01=EXOR(mult(9,text[8:12]),mult(2,text[12:16]),4)
	S10=EXOR(mult(9,text[4:8]),mult(2,text[:4]),4)
	S11=EXOR(mult(9,text[12:16]),mult(2,text[8:12]),4)
	return S00+S10+S01+S11

'''Key Generation'''
w0=key[:8]
w1=key[8:]
w2=EXOR(EXOR(w0,'10000000',8),SubNibble(RotNibble(w1),S_Box),8)
w3=EXOR(w2,w1,8)
w4=EXOR(EXOR(w2,'00110000',8),SubNibble(RotNibble(w3),S_Box),8)
w5=EXOR(w4,w3,8)
key0=w0+w1
key1=w2+w3
key2=w4+w5

'''Encryption'''
ciphertext=SubNibble(EXOR(plaintext,key0,16),S_Box)
ciphertext=MixColumns(ShiftRow(ciphertext))
ciphertext=SubNibble(EXOR(ciphertext,key1,16),S_Box)
ciphertext=EXOR(ShiftRow(ciphertext),key2,16)
print('Ciphertext: ',ciphertext)

'''Decryption'''
plain=SubNibble(ShiftRow(EXOR(ciphertext,key2,16)),InvS_Box)
plain=SubNibble(ShiftRow(InverseMixColumns(EXOR(plain,key1,16))),InvS_Box)
plain=EXOR(plain,key0,16)
print('Plaintext: ',plain)


"""
python3 SAES.py 
Ciphertext:  0010010011101100
Plaintext:  1101011100101000

"""

