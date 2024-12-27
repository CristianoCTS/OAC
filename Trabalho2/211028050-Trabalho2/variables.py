#imports
import numpy as np
import warnings
warnings.simplefilter("ignore", category=RuntimeWarning)

#variaveis
mem = np.zeros(16384, dtype = np.uint8)
pc = 0x00000000
ri = 0x00000000
sp = 0x00003ffc
gp = 0x00001800
regs = np.zeros(32, dtype=np.uint32)
regs[2] = sp
regs[3] = gp
path = r"C:\Users\Usuário\Desktop\Escritório\Disciplinas\OAC\Trabalho2\211028050-Trabalho2\code.bin"
address = 0x00000000
running = None
resultado = []
memoria = [
    ["zero", 0, f"0x{regs[0]:08x}"], 
    ["ra", 1, f"0x{regs[1]:08x}"], 
    ["sp", 2, f"0x{regs[2]:08x}"], 
    ["gp", 3, f"0x{regs[3]:08x}"], 
    ["tp", 4, f"0x{regs[4]:08x}"], 
    ["t0", 5, f"0x{regs[5]:08x}"], 
    ["t1", 6, f"0x{regs[6]:08x}"], 
    ["t2", 7, f"0x{regs[7]:08x}"], 
    ["s0", 8, f"0x{regs[8]:08x}"], 
    ["s1", 9, f"0x{regs[9]:08x}"], 
    ["a0", 10, f"0x{regs[10]:08x}"], 
    ["a1", 11, f"0x{regs[11]:08x}"], 
    ["a2", 12, f"0x{regs[12]:08x}"], 
    ["a3", 13, f"0x{regs[13]:08x}"], 
    ["a4", 14, f"0x{regs[14]:08x}"], 
    ["a5", 15, f"0x{regs[15]:08x}"], 
    ["a6", 16, f"0x{regs[16]:08x}"], 
    ["a7", 17, f"0x{regs[17]:08x}"], 
    ["s2", 18, f"0x{regs[18]:08x}"], 
    ["s3", 19, f"0x{regs[19]:08x}"], 
    ["s4", 20, f"0x{regs[20]:08x}"], 
    ["s5", 21, f"0x{regs[21]:08x}"], 
    ["s6", 22, f"0x{regs[22]:08x}"], 
    ["s7", 23, f"0x{regs[23]:08x}"], 
    ["s8", 24, f"0x{regs[24]:08x}"], 
    ["s9", 25, f"0x{regs[25]:08x}"], 
    ["s10", 26, f"0x{regs[26]:08x}"], 
    ["s11", 27, f"0x{regs[27]:08x}"], 
    ["t3", 28, f"0x{regs[28]:08x}"], 
    ["t4", 29, f"0x{regs[29]:08x}"], 
    ["t5", 30, f"0x{regs[30]:08x}"], 
    ["t6", 31, f"0x{regs[31]:08x}"], 
    ["pc", " ", f"0x{pc:08x}"]
]