#imports
import numoy as np

#base
mem = np.zeros(16384, dtype = np.uint8)

#functions

def lb(reg, kte):
    address = reg + kte
    byte = np.int8(mem[address])
    if byte < 0:
        word = (1 << 32) + byte
    pass

def lbu(reg, kte):
    address = reg + kte
    byte = np.int8(mem[address])
    if byte < 0:
        word = (1 << 32) + byte
    pass

def lw(reg, kte):
    address = reg + kte
    byte = np.int8(mem[address])
    if byte < 0:
        word = (1 << 32) + byte
    pass

def sb(reg, kte, byte):
    address = reg + kte
    byte = np.int8(mem[address])
    if byte < 0:
        word = (1 << 32) + byte
    pass

def sw(reg, kte, word):
    address = reg + kte
    byte = np.int8(mem[address])
    if byte < 0:
        word = (1 << 32) + byte
    pass

sb(7, 0, 0xaa)
word = lb(7, 0)
print("word_10 = ", word)
print("word_x = ", hex(word))