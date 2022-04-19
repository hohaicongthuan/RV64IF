######################################
# FLOATING-POINT TEST CASE GENERATOR #
######################################
#
# This script generates test cases for fp addition,
# fp subtraction, fp multiplication, and fp division instructions.
#
# 1st line: number A
# 2nd line: number B
# 3rd line: expected result for fp addition
# 4th line: expected result for fp subtraction
# 5th line: expected result for fp multiplication
# 6th line: expected result for fp division

import struct
import random

# Function that converts a hex string (in 32-bit floating-point format) to a float number
def Hex_To_Float(x):
    return struct.unpack('!f', bytes.fromhex(x))[0]

# Function that converts a hex string (in 64-bit floating-point format) to a float number
def Hex_To_Double(x):
    return struct.unpack('!d', bytes.fromhex(x))[0]

# Function that converts a 32-bit floating-point number to a hex string
def Float_To_Hex(f):
    return hex(struct.unpack('<I', struct.pack('<f', f))[0])

# Function that converts a 64-bit floating-point number to a hex string
def Double_To_Hex(f):
    return hex(struct.unpack('<Q', struct.pack('<d', f))[0])

if __name__ == "__main__":
    TEST_CASE_NUM = 1000

    f = open("Test_Cases.txt", "w")

    for i in range(TEST_CASE_NUM):
        num1 = random.uniform(-1.00, 1.00)
        num2 = random.uniform(-1.00, 1.00)
        
        f.write(Float_To_Hex(num1) + "\n" + Float_To_Hex(num2) + "\n")
        f.write(Float_To_Hex(num1 + num2) + "\n")
        f.write(Float_To_Hex(num1 - num2) + "\n")
        f.write(Float_To_Hex(num1 * num2) + "\n")
        f.write(Float_To_Hex(num1 / num2) + "\n")

    f.close()