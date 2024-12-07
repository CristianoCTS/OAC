#imports
import numpy as np
import warnings
warnings.simplefilter("ignore", category=RuntimeWarning)

#base
mem = np.zeros(16384, dtype = np.uint8)
pc = 0x00000000
ri = 0x00000000
sp = 0x00003ffc
gp = 0x00001800
regs = np.zeros(32, dtype=np.uint32)
regs[2] = sp
regs[3] = gp
path = r"C:\Users\Usuário\Desktop\Escritório\Disciplinas\OAC\Trabalho2\code.bin"
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

def load_mem(file_path, start_address):
    global mem
    try:
        with open(file_path, "rb") as f:
            data = f.read()
            mem[start_address:start_address + len(data)] = np.frombuffer(data, dtype=np.uint8)
    except FileNotFoundError:
        print(f"Erro: {file_path} não encontrado.")
    except Exception as e:
        print(f"Erro ao carregar o arquivo")

def fetch(pc):
    instruction = (
        mem[pc]             |
        (mem[pc + 1] << 8)  |
        (mem[pc + 2] << 16) |
        (mem[pc + 3] << 24) )   
    return (instruction)

def decode(binary_instruction):
    # print(binary_instruction)
    opcode = binary_instruction & 0x7F
    rd = (binary_instruction >> 7) & 0x1F
    funct3 = (binary_instruction >> 12) & 0x7
    rs1 = (binary_instruction >> 15) & 0x1F
    rs2 = (binary_instruction >> 20) & 0x1F
    funct7 = (binary_instruction >> 25) & 0x7F
    shamt = (binary_instruction >> 20) & 0x1F
    imm12_i = (binary_instruction >> 20) & 0xFFF
    imm12_i = imm12_i if imm12_i < 0x800 else imm12_i - 0x1000    
    imm12_s = ((binary_instruction >> 7) & 0x1F) | ((binary_instruction >> 25) & 0x7F) << 5
    imm12_s = imm12_s if imm12_s < 0x800 else imm12_s - 0x1000    
    imm13 = (
        ((binary_instruction >> 8) & 0xF) << 1
        | ((binary_instruction >> 25) & 0x3F) << 5
        | ((binary_instruction >> 7) & 0x1) << 11
        | ((binary_instruction >> 31) & 0x1) << 12
    )
    imm13 = imm13 if imm13 < 0x1000 else imm13 - 0x2000    
    imm20_u = binary_instruction & 0xFFFFF000    
    imm21 = (
        ((binary_instruction >> 12) & 0xFF) << 12
        | ((binary_instruction >> 20) & 0x1) << 11
        | ((binary_instruction >> 21) & 0x3FF) << 1
        | ((binary_instruction >> 31) & 0x1) << 20
    )
    if imm21 & 0x100000:
        imm21 -= 0x200000

    parameters = {
    "opcode": opcode,
    "rd": rd,
    "funct3": funct3,
    "rs1": rs1,
    "rs2": rs2,
    "funct7": funct7,
    "shamt": shamt,
    "imm12_i": (imm12_i),
    "imm12_s": (imm12_s),
    "imm13": (imm13),
    "imm20_u": (imm20_u),
    "imm21": (imm21),}

    return parameters

def execute(parameters):    
    opcode = parameters["opcode"]
    rd = parameters["rd"]
    funct3 = parameters["funct3"]
    rs1 = parameters["rs1"]
    rs2 = parameters["rs2"]
    funct7 = parameters["funct7"]
    shamt = parameters["shamt"]
    imm12_i = parameters["imm12_i"]
    imm12_s = parameters["imm12_s"]
    imm13 = parameters["imm13"]
    imm20_u = parameters["imm20_u"]
    imm21 = parameters["imm21"]

    if opcode == 0x33:
        if funct3 == 0x0 and funct7 == 0x00:
            add(rd, rs1, rs2)
            return f"add x{rd}, x{rs1}, x{rs2}"
        elif funct3 == 0x0 and funct7 == 0x20:
            sub(rd, rs1, rs2)
            return f"sub x{rd}, x{rs1}, x{rs2}"
        elif funct3 == 0x2:
            slt(rd, rs1, rs2)
            return f"slt x{rd}, x{rs1}, x{rs2}"
        elif funct3 == 0x7:
            and_(rd, rs1, rs2)
            return f"and x{rd}, x{rs1}, x{rs2}"
        elif funct3 == 0x6:
            or_(rd, rs1, rs2)
            return f"or x{rd}, x{rs1}, x{rs2}"
        elif funct3 == 0x4:
            xor_(rd, rs1, rs2)
            return f"xor x{rd}, x{rs1}, x{rs2}"
    
    elif opcode == 0x03:
        if funct3 == 0x0:
            lb(rd, rs1, imm12_i)
            return f"lb x{rd}, {imm12_i}(x{rs1})"
        elif funct3 == 0x4:
            lbu(rd, rs1, imm12_i)
            return f"lbu x{rd}, {imm12_i}(x{rs1})"
        elif funct3 == 0x2:
            lw(rd, rs1, imm12_i)
            return f"lw x{rd}, {imm12_i}(x{rs1})"
    
    elif opcode == 0x13:
        if funct3 == 0x0:
            addi(rd, rs1, imm12_i)
            return f"addi x{rd}, x{rs1}, {imm12_i}"
        elif funct3 == 0x7:
            andi(rd, rs1, imm12_i)
            return f"andi x{rd}, x{rs1}, {imm12_i}"
        elif funct3 == 0x6:
            ori(rd, rs1, imm12_i)
            return f"ori x{rd}, x{rs1}, {imm12_i}"
        elif funct3 == 0x5:
            if funct7 == 0x00:
                srli(rd, rs1, shamt)
                return f"srli x{rd}, x{rs1}, {shamt}"
            elif funct7 == 0x20:
                srai(rd, rs1, shamt)
                return f"srai x{rd}, x{rs1}, {shamt}"
        elif funct3 == 0x1:
            slli(rd, rs1, shamt)
            return f"slli x{rd}, x{rs1}, {shamt}"
    
    elif opcode == 0x6F:
        jal(rd, imm21)
        return f"jal x{rd}, {imm21}"
    
    elif opcode == 0x63:
        if funct3 == 0x0:
            beq(rs1, rs2, imm13)
            return f"beq x{rs1}, x{rs2}, {imm13}"
        elif funct3 == 0x1:
            bne(rs1, rs2, imm13)
            return f"bne x{rs1}, x{rs2}, {imm13}"
        elif funct3 == 0x4:
            blt(rs1, rs2, imm13)
            return f"blt x{rs1}, x{rs2}, {imm13}"
        elif funct3 == 0x5:
            bge(rs1, rs2, imm13)
            return f"bge x{rs1}, x{rs2}, {imm13}"
        elif funct3 == 0x6:
            bltu(rs1, rs2, imm13)
            return f"bltu x{rs1}, x{rs2}, {imm13}"
        elif funct3 == 0x7:
            bgeu(rs1, rs2, imm13)
            return f"bgeu x{rs1}, x{rs2}, {imm13}"
    
    elif opcode == 0x67:
        jalr(rd, rs1, imm12_i)
        return f"jalr x{rd}, x{rs1}, {imm12_i}"
    
    elif opcode == 0x23:
        if funct3 == 0x0:
            sb(rs2, rs1, imm12_s)
            return f"sb x{rs2}, {imm12_s}(x{rs1})"
        elif funct3 == 0x2:
            sw(rs2, rs1, imm12_s)
            return f"sw x{rs2}, {imm12_s}(x{rs1})"
    
    elif opcode == 0x37:
        lui(rd, imm20_u)
        return f"lui x{rd}, {imm20_u}"
    
    elif opcode == 0x17:
        auipc(rd, imm20_u)
        return f"auipc x{rd}, {imm20_u}"
    
    elif opcode == 0x73 and funct3 == 0x0:
        if imm12_i == 0:
            ecall()
            return "ecall"    
    return "Unknown instruction"

def step(pc):
    instruction = fetch(pc)    
    parameters = decode(instruction)
    assembly_instruction = execute(parameters)
    return assembly_instruction
 
def run(fim_da_memoria=0x00002000):
    global pc  
    global running
    global instruction
    global resultado    
    running = True
    adress_modifiers = ["bge", "bgeu", "blt", "bltu", "beq", "bne", "jal", "jalr"]
    assembly_instructions = []
    while(running and (pc<(fim_da_memoria-32))):
        regs[0] = 0
        instruction = (pc,step(pc))
        regs[0] = 0
        global memoria
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
        #print(f"0x{instruction[0]:08x}: {instruction[1]}")
        resultado.append((f"0x{instruction[0]:08x}: {instruction[1]}", memoria))
        if (instruction[1].split(" ")[0]) in adress_modifiers:  
            pass
        else:          
            pc += 0x00000004
    return assembly_instructions

#instruções
def lb(rd, imm, rs1):
    address = regs[rs1] + imm
    if address < len(mem):
        byte = np.int8(mem[address])
        regs[rd] = np.uint32(byte)

def lbu(rd, imm, rs1):
    address = regs[rs1] + imm
    if address < len(mem):
        byte = np.uint8(mem[address])
        regs[rd] = np.uint32(byte)

def lw(rd, imm, rs1):
    address = regs[rs1] + imm
    if address + 3 < len(mem):
        word = (mem[address + 3] << 24) | (mem[address + 2] << 16) | (mem[address + 1] << 8) | mem[address]
        regs[rd] = np.uint32(word)

def lui(rd, imm):
    regs[rd] = np.uint32(imm)

def sb(rs2, imm, rs1):
    address = regs[rs1] + imm
    if address < len(mem):
        mem[address] = np.uint8(regs[rs2] & 0xFF)

def sw(rs2, imm, rs1):
    address = regs[rs1] + imm
    if address + 3 < len(mem):
        mem[address] = np.uint8(regs[rs2] & 0xFF)
        mem[address + 1] = np.uint8((regs[rs2] >> 8) & 0xFF)
        mem[address + 2] = np.uint8((regs[rs2] >> 16) & 0xFF)
        mem[address + 3] = np.uint8((regs[rs2] >> 24) & 0xFF)

def add(rd, rs1, rs2):
    regs[rd] = (regs[rs1] + regs[rs2]) & 0xFFFFFFFF

def addi(rd, rs1, imm):
    global pc
    regs[rd] = np.uint32(regs[rs1] + imm)

def and_(rd, rs1, rs2):
    regs[rd] = np.uint32(regs[rs1] & regs[rs2])

def andi(rd, rs1, imm):
    regs[rd] = np.uint32(regs[rs1] & imm)

def auipc(rd, imm):
    regs[rd] = np.uint32(pc + imm)

def sub(rd, rs1, rs2):
    regs[rd] = np.uint32(regs[rs1] - regs[rs2])    

def bge(rs1, rs2, imm):
    global pc
    if np.int32(regs[rs1]) >= np.int32(regs[rs2]):
        pc += imm
    else:
         pc += 0x00000004   

def bgeu(rs1, rs2, imm):
    global pc
    if regs[rs1] >= regs[rs2]:
        pc += imm
    else:
         pc += 0x00000004 

def blt(rs1, rs2, imm):
    global pc
    if np.int32(regs[rs1]) < np.int32(regs[rs2]):
        pc += imm
    else:
         pc += 0x00000004 

def bltu(rs1, rs2, imm):
    global pc
    if regs[rs1] < regs[rs2]:
        pc += imm
    else:
         pc += 0x00000004 

def beq(rs1, rs2, imm):
    global pc
    if regs[rs1] == regs[rs2]:
        pc += imm
    else:
        pc += 0x00000004 

def bne(rs1, rs2, imm):
    global pc
    if regs[rs1] != regs[rs2]:
        pc += imm
    else:
         pc += 0x00000004 

def jal(rd, imm):
    global pc
    regs[rd] = pc + 4 
    pc += np.int32(imm)

def jalr(rd, rs1, imm):
    global pc
    temp = pc
    pc = (regs[rs1] + imm) & ~1
    regs[rd] = temp + 4

def or_(rd, rs1, rs2):
    regs[rd] = np.uint32(regs[rs1] | regs[rs2])

def ori(rd, rs1, imm):
    regs[rd] = np.uint32(regs[rs1] | imm)

def slt(rd, rs1, rs2):
    regs[rd] = np.uint32(1 if np.int32(regs[rs1]) < np.int32(regs[rs2]) else 0)

def sltu(rd, rs1, rs2):
    regs[rd] = np.uint32(1 if regs[rs1] < regs[rs2] else 0)

def slli(rd, rs1, shamt):
    regs[rd] = np.uint32(regs[rs1] << shamt)

def srai(rd, rs1, shamt):
    regs[rd] = np.uint32(np.int32(regs[rs1]) >> shamt)

def srli(rd, rs1, shamt):
    regs[rd] = np.uint32(regs[rs1] >> shamt)

def xor_(rd, rs1, rs2):
    regs[rd] = np.uint32(regs[rs1] ^ regs[rs2])

def ecall():
    global running
    a0 = regs[10]
    a7 = regs[17]
    if a7 == 1:
        print(a0)
    
    elif a7 == 4:
        address = a0
        string = ""
        while mem[address] != 0:
            string += chr(mem[address])
            address += 1
        print(string)
    
    elif a7 == 10:
        running = False



#Rodando
load_mem(path, address)
run()
# with open("memoria_completa.txt", "w") as file:
#     for item in resultado:
#         file.write(f"{item[0]}:\n")
#         for i in item[1]:
#             file.write(f"{i[0]}, {i[1]}, {i[2]}\n")
# with open("memoria_instrucoes.txt", "w") as file:
#     for item in resultado:
#         file.write(f"{item[0]}:\n")
