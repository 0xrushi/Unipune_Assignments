"""
Created on Mon Apr 22 16:51:29 2019
input,output : 8bit
key : 10bit 2x 8bit round keys
rounds 2
sboxes:2
@author: r4#51c0debl00d3d
refrences: https://www.youtube.com/watch?v=qHZKze24kVo

P10 and P8 are such functions, which mimic PC1 and PC2 in DES. 
They are part of the definition of S-DES. 
P10 is an entirely arbitrary permutation of 10 bits. 
P8 is a selection of 8 bits out of 10.
"""

P10=(3,5,2,7,4,10,1,9,8,6)
P8=(6,3,7,4,8,5,10,9)

IP=(2,6,3,1,4,8,5,7)
IP_inv=(4,1,3,5,7,2,8,6)

P4=(2,4,3,1)

S0=[[1,0,3,2],[3,2,1,0],[0,2,1,3],[3,1,3,2]]
#S1=[[0,1,2,3],[2,0,1,3],[3,0,1,0],[2,1,0,3]]
S1=[[2,1,3,0],[2,0,1,3],[1,3,1,0],[0,1,2,3]]


def permute(P,key):
	key='0'+key
	k=''
	for i in P:
		k+=key[i]
	return k

'''Perform circular shift of defined bits'''
def shift(key,bits):#split and shift
    print("key is ",key)
    sk1=key[:5]
    sk2=key[5:]
    sk1=sk1[bits:]+sk1[:bits]
    sk2=sk2[bits:]+sk2[:bits]
    return sk1+sk2

'''Append bits to binary string'''
def gen_bits(text,bits):
	return '0'*(bits-len(text))+text

'''Perform EXOR operation'''
def EXOR(text1,text2,bits):
	ex=bin(int(text1,2)^int(text2,2))[2:]
	ex=gen_bits(ex,bits)
	return ex

def S_Box(s,text):
	row=int(text[0]+text[3],2)
	col=int(text[1]+text[2],2)
	return(s[row][col])

def mapping_F(right,sk):
	expansion=(4,1,2,3,2,3,4,1)
	output=permute(expansion,right)
	output=EXOR(output,sk,8)
	left=gen_bits(bin(S_Box(S0,output[:4]))[2:],2)
	right=gen_bits(bin(S_Box(S1,output[4:]))[2:],2)
	
	output=permute(P4,left+right)
	return output

def fk(text,key):
	left=text[:4]
	right=text[4:]
	F=mapping_F(right,key)
	fk_text=EXOR(left,F,4)+right
	return(fk_text)

plaintext= "11101101"
key = "1100011110"
binary = plaintext
print((binary))

'''Generate two 8-bit keys from 10-bit key'''
K1=permute(P8,shift(permute(P10,key),1))
K2=permute(P8,shift(permute(P10,key),3))

'''Encryption'''
cipher=permute(IP,plaintext)
fk1=fk(cipher,K1)
fk2=fk(fk1[4:]+fk1[:4],K2)
cipher=permute(IP_inv,fk2)
print("Ciphertext (Encryption): ")
print(cipher)

'''Decryption'''
plain=permute(IP,cipher)
fk2=fk(plain,K2)
fk1=fk(fk2[4:]+fk2[:4],K1)
plain=permute(IP_inv,fk1)

print("Plaintext (Decryption): " + plain)
