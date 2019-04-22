"""
Created on Mon Apr 22 16:51:29 2019
input,output : 8bit
key : 10bit 2x 8bit round keys
rounds 2
sboxes:2
@author: r4#51c0debl00d3d
refrences: https://www.youtube.com/watch?v=qHZKze24kVo
"""
InputPerm = [2, 6, 3, 1, 4, 8, 5, 7]
FinalPerm = [4, 1, 3, 5, 7, 2, 8, 6]

#Expand and permutate
EPtable = [4, 1, 2, 3, 2, 3, 4, 1]

S0 = [[1, 0, 3, 2], [3, 2, 1, 0], [0, 2, 1, 3], [3, 1, 3, 2]]
S1 = [[0, 1, 2, 3], [2, 0, 1, 3], [3, 0, 1, 0], [2, 1, 0, 3]]
P4table = [2, 4, 3, 1]

P10Table = [3, 5, 2, 7, 4, 10, 1, 9, 8, 6]
P8Table = [6, 3, 7, 4, 8, 5, 10, 9]

tempKey8K1 = ''
tempKey8K2 = ''

def XORStrings(s1,s2,bit):
    s1binary = int('0b'+s1,2)
    s2binary = int('0b'+s2,2)
    x = s1binary ^ s2binary
    return ('{:0'+bit+'b}').format(x)

def Encrypt_Decrypt(plainBin,round_no,key_no):
    IP= []
    EP= []
    if(round_no == 0):
        for i in range(0,8):
            IP.append(plainBin[InputPerm[i] - 1])
        IP = ''.join(IP)
        L = IP[:4]
        R = IP[4:]
    
    if(round_no == 1):
        L = plainBin[:4]
        R = plainBin[4:]
    
    for i in range(0,8):
        EP.append(R[EPtable[i] - 1])
    print(EP)
    EP = ''.join(EP)
    
    if(key_no == 0):
        XORED = XORStrings(EP,tempKey8K1,'8')
    
    if(key_no == 1):
        XORED = XORStrings(EP,tempKey8K2,'8')
    
    S0_index = XORED[:4]
    S1_index = XORED[4:]
    
    row0_index = S0_index[0] + S0_index[3]
    column0_index = S0_index[1] + S0_index[2]
    row0_index = int('0b'+row0_index ,2) # converting binary to decimal
    column0_index = int('0b'+column0_index ,2) # converting binary to decimal
    
    S0_data = S0[row0_index][column0_index]
    S0_str = '{0:02b}'.format(int(S0_data))
    
    row1_index = S1_index[0]+ S1_index[3]
    column1_index = S1_index[1]+S1_index[2]
    
    row1_index = int('0b'+row1_index,2)
    column1_index = int('0b'+column1_index,2)
    #S1_data.append(S1[row1_index][column1_index])
    S1_data = S1[row1_index][column1_index]
    S1_str = '{0:02b}'.format(int(S1_data))
 
    P4_temp = S0_str + S1_str 
    
    P4 = []
    for i in range(0,4):
        P4.append(P4_temp[P4table[i] - 1])
    P4 = ''.join(P4)
    
    XORED2 = XORStrings(P4,L,'4')
    
    FinalRound2 = []
    if(round_no == 0):
        FinalRoundOut = R + XORED2
        return FinalRoundOut
    if(round_no == 1):
        FinalRoundOut = XORED2 + R
        for i in range(0,8):
            FinalRound2.append(FinalRoundOut[FinalPerm[i] - 1])
        return FinalRound2

def circularRotateLeft(st):
    st += st[0]
    return st[1:]

def GenerateKeys(TenBitKey):
    tempKey10 = []
    
    for i in range(0,10):
        tempKey10.append(TenBitKey[P10Table[i] - 1])
    
    tempKey10 = ''.join(tempKey10)
    print("p10 is "+ tempKey10)
    LS11 = tempKey10[:5]
    LS12 = tempKey10[5:]
    
    LS11 = circularRotateLeft(LS11)
    LS12 = circularRotateLeft(LS12)
    
    LS1 = LS11 + LS12
    print('LS11= '+LS11+'\nLS12=  '+LS12)
    tempKey8K1 = []
    for i in range(0,8):
        tempKey8K1.append(LS1[P8Table[i] - 1])
    tempKey8K1 = ''.join(tempKey8K1)
    
    LS11 = circularRotateLeft(LS11)
    LS11 = circularRotateLeft(LS11)
    LS12 = circularRotateLeft(LS12)
    LS12 = circularRotateLeft(LS12)
    
    LS2 = LS11 + LS12
    tempKey8K2 = []
    for i in range(0,8):
        tempKey8K2.append(LS2[P8Table[i] - 1])
    tempKey8K2 = ''.join(tempKey8K2)
    
    return tempKey8K1, tempKey8K2
#****************************************************************************************************    

binaryInput = ['01110010']
binaryKey = '1010000010'
print("Message to be sent:\n"+ binaryInput[0])

tempKey8K1,tempKey8K2 = GenerateKeys(binaryKey)
print();
encryptData = []
decryptData = []
for i in range(0,len(binaryInput)):
    encrypted = []
    encrypted.append(Encrypt_Decrypt(binaryInput[i],0,0))
    encrypted.append(Encrypt_Decrypt(encrypted[0],1,1))
    encryptData.append(encrypted[1])
    decrypted = []
    decrypted.append(Encrypt_Decrypt(encrypted[1],0,1))
    decrypted.append(Encrypt_Decrypt(decrypted[0],1,0))
    decryptData.append(decrypted[1])

print("Encrypted Messgae")
for i in range(0,len(encryptData)):
    print(encryptData[i])
print("Decrypted Messgae")
text = ''.join(decryptData[0])
print(chr(int('0b'+text,2)))
