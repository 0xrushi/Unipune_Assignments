import random
import math
def gcd(a, b):
    return math.gcd(a,b)

def is_prime(num):
    if num == 2:
        return True
    if num < 2 or num % 2 == 0:
        return False
    for n in range(3, int(num**0.5)+2, 2):
        if num % n == 0:
            return False
    return True

def generate_keypair(p, q):
    if not (is_prime(p) and is_prime(q)):
        raise ValueError('Both numbers must be prime.')
    elif p == q:
        raise ValueError('p and q cannot be equal')
        
    n = p * q
    phi = (p-1) * (q-1)
    e = random.randrange(1, phi)
    
    g = gcd(e, phi)
    
    while g != 1:
        e = random.randrange(1, phi)
        g = gcd(e, phi)

    print("e = ",e)
    for i in range(1,100000):
        d = ((phi * i) + 1)/e
        if d%1 ==0:
            break
    d = int(d)    
    print("d= ",d)
    print("i= ",i)
    return ((e, n), (d, n))

def encrypt(pk, plaintext):
    key, n = pk
    cipher = [(ord(char) ** key) % n for char in plaintext]
    return cipher

def decrypt(pk, ciphertext):
    key, n = pk
    plain = [chr((char ** key) % n) for char in ciphertext]
    return ''.join(plain)
    

if __name__ == '__main__':
    print ("RSA Encrypter/ Decrypter")
    p = int(input("Enter a prime number (17, 19, 23, etc): "))
    q = int(input("Enter another prime number (Not one you entered above): "))
    print ("Generating your public/private keypairs now . . .")
    public, private = generate_keypair(p, q)
    print ("Your public key is ", public ," and your private key is ", private)
    message = input("Enter a message to encrypt with your public key: ")
    encrypted_msg = encrypt(public, message)
    print ("Your encrypted message is: ")
    print (''.join(map(str,encrypted_msg)))
    print ("Decrypting message with private key ", private ," . . .")
    print ("Your message is:")
    print (decrypt(private, encrypted_msg))
