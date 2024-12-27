#imports
import numpy as np
import warnings
import variables
warnings.simplefilter("ignore", category=RuntimeWarning)

#instruções
def lb(rd, imm, rs1):
    variables.address = variables.regs[rs1] + imm
    if variables.address < len(variables.mem):
        byte = np.int8(variables.mem[variables.address])
        variables.regs[rd] = np.uint32(byte)

def lbu(rd, imm, rs1):
    variables.address = variables.regs[rs1] + imm
    if variables.address < len(variables.mem):
        byte = np.uint8(variables.mem[variables.address])
        variables.regs[rd] = np.uint32(byte)

def lw(rd, imm, rs1):
    variables.address = variables.regs[rs1] + imm
    if variables.address + 3 < len(variables.mem):
        word = (variables.mem[variables.address + 3] << 24) | (variables.mem[variables.address + 2] << 16) | (variables.mem[variables.address + 1] << 8) | variables.mem[variables.address]
        variables.regs[rd] = np.uint32(word)

def lui(rd, imm):
    variables.regs[rd] = np.uint32(imm)

def sb(rs2, imm, rs1):
    variables.address = variables.regs[rs1] + imm
    if variables.address < len(variables.mem):
        variables.mem[variables.address] = np.uint8(variables.regs[rs2] & 0xFF)

def sw(rs2, imm, rs1):
    variables.address = variables.regs[rs1] + imm
    if variables.address + 3 < len(variables.mem):
        variables.mem[variables.address] = np.uint8(variables.regs[rs2] & 0xFF)
        variables.mem[variables.address + 1] = np.uint8((variables.regs[rs2] >> 8) & 0xFF)
        variables.mem[variables.address + 2] = np.uint8((variables.regs[rs2] >> 16) & 0xFF)
        variables.mem[variables.address + 3] = np.uint8((variables.regs[rs2] >> 24) & 0xFF)

def add(rd, rs1, rs2):
    variables.regs[rd] = (variables.regs[rs1] + variables.regs[rs2]) & 0xFFFFFFFF

def addi(rd, rs1, imm):
    variables.pc
    variables.regs[rd] = np.uint32(variables.regs[rs1] + imm)

def and_(rd, rs1, rs2):
    variables.regs[rd] = np.uint32(variables.regs[rs1] & variables.regs[rs2])

def andi(rd, rs1, imm):
    variables.regs[rd] = np.uint32(variables.regs[rs1] & imm)

def auipc(rd, imm):
    variables.regs[rd] = np.uint32(variables.pc + imm)

def sub(rd, rs1, rs2):
    variables.regs[rd] = np.uint32(variables.regs[rs1] - variables.regs[rs2])    

def bge(rs1, rs2, imm):
    variables.pc
    if np.int32(variables.regs[rs1]) >= np.int32(variables.regs[rs2]):
        variables.pc += imm
    else:
         variables.pc += 0x00000004   

def bgeu(rs1, rs2, imm):
    variables.pc
    if variables.regs[rs1] >= variables.regs[rs2]:
        variables.pc += imm
    else:
         variables.pc += 0x00000004 

def blt(rs1, rs2, imm):
    variables.pc
    if np.int32(variables.regs[rs1]) < np.int32(variables.regs[rs2]):
        variables.pc += imm
    else:
         variables.pc += 0x00000004 

def bltu(rs1, rs2, imm):
    variables.pc
    if variables.regs[rs1] < variables.regs[rs2]:
        variables.pc += imm
    else:
         variables.pc += 0x00000004 

def beq(rs1, rs2, imm):
    variables.pc
    if variables.regs[rs1] == variables.regs[rs2]:
        variables.pc += imm
    else:
        variables.pc += 0x00000004 

def bne(rs1, rs2, imm):
    variables.pc
    if variables.regs[rs1] != variables.regs[rs2]:
        variables.pc += imm
    else:
         variables.pc += 0x00000004 

def jal(rd, imm):
    variables.pc
    variables.regs[rd] = variables.pc + 4 
    variables.pc += np.int32(imm)

def jalr(rd, rs1, imm):
    variables.pc
    temp = variables.pc
    variables.pc = (variables.regs[rs1] + imm) & ~1
    variables.regs[rd] = temp + 4

def or_(rd, rs1, rs2):
    variables.regs[rd] = np.uint32(variables.regs[rs1] | variables.regs[rs2])

def ori(rd, rs1, imm):
    variables.regs[rd] = np.uint32(variables.regs[rs1] | imm)

def slt(rd, rs1, rs2):
    variables.regs[rd] = np.uint32(1 if np.int32(variables.regs[rs1]) < np.int32(variables.regs[rs2]) else 0)

def sltu(rd, rs1, rs2):
    variables.regs[rd] = np.uint32(1 if variables.regs[rs1] < variables.regs[rs2] else 0)

def slli(rd, rs1, shamt):
    variables.regs[rd] = np.uint32(variables.regs[rs1] << shamt)

def srai(rd, rs1, shamt):
    variables.regs[rd] = np.uint32(np.int32(variables.regs[rs1]) >> shamt)

def srli(rd, rs1, shamt):
    variables.regs[rd] = np.uint32(variables.regs[rs1] >> shamt)

def xor_(rd, rs1, rs2):
    variables.regs[rd] = np.uint32(variables.regs[rs1] ^ variables.regs[rs2])

def ecall():
    variables.running
    a0 = variables.regs[10]
    a7 = variables.regs[17]
    if a7 == 1:
        print(a0)
    
    elif a7 == 4:
        variables.address = a0
        string = ""
        while variables.mem[variables.address] != 0:
            string += chr(variables.mem[variables.address])
            variables.address += 1
        print(string)
    
    elif a7 == 10:
        variables.running = False