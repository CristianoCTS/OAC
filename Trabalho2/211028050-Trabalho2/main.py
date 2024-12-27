#Crisiano Tolentino Santos
#211028050
#Python 3, Windows 10, Vscode

#imports
import numpy as np
import warnings
import variables
import instructions
import base
warnings.simplefilter("ignore", category=RuntimeWarning)

#Rodando
base.load_mem(variables.path, variables.address)
base.run()
# with open("variables.memoria_completa.txt", "w") as file:
#     for item in variables.resultado:
#         file.write(f"{item[0]}:\n")
#         for i in item[1]:
#             file.write(f"{i[0]}, {i[1]}, {i[2]}\n")
# with open("variables.memoria_instrucoes.txt", "w") as file:
#     for item in variables.resultado:
#         file.write(f"{item[0]}:\n")
