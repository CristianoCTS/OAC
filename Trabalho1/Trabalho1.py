#imports
import numpy as np

#base
mem = np.zeros(16384, dtype = np.uint8)

#functions

def lb(reg, kte):
    address = reg + kte
    byte = np.int8(mem[address])
    return np.uint32(byte)

def lbu(reg, kte):
    address = reg + kte
    byte = np.uint8(mem[address])
    return np.uint32(byte)

def lw(reg, kte):
    address = reg + kte
    word = (mem[address + 3] << 24) | (mem[address + 2] << 16) | (mem[address + 1] << 8) | mem[address]
    return np.uint32(word)

def sb(reg, kte, byte):
    address = reg + kte
    mem[address] = np.uint8(byte)

def sw(reg, kte, word):
    address = reg + kte
    mem[address] = np.uint8(word & 0xFF)
    mem[address + 1] = np.uint8((word >> 8) & 0xFF)
    mem[address + 2] = np.uint8((word >> 16) & 0xFF)
    mem[address + 3] = np.uint8((word >> 24) & 0xFF)

#testing

sw(0,	0,	0xABACADEF)
sb(4,	0,	1)
sb(4,	1,	2)
sb(4,	2,	3)
sb(4,	3,	4)

print(hex(lw(0,0)))	
print(hex(lb(0,0)))
print(hex(lb(0,1)))
print(hex(lb(0,2)))
print(hex(lb(0,3)))
print(hex(lbu(0,0)))
print(hex(lbu(0,1)))
print(hex(lbu(0,2)))
print(hex(lbu(0,3)))