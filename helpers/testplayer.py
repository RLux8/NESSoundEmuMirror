# This shows how to simply feed in straight text
# by passing it through splitlines()

from py6502.src.asm6502 import asm6502


MIFFILEHEADER = """
DEPTH = {depth};                   -- The size of data in bits
WIDTH = {width};                    -- The size of memory in words
ADDRESS_RADIX = HEX;          -- The radix for address values
DATA_RADIX = HEX;             -- The radix for data values
CONTENT                       -- start of (address : data pairs)
BEGIN
"""

lines = open("player6502.asm")

a = asm6502()
(l,s) = a.assemble(lines)

for line in l:
    print (line)
print


for line in s:
    print (line)

hexdata = a.object_code[0x2000:0x3000]

with open("bootROM4kx8.mif", "w") as miffile:
	miffile.write(MIFFILEHEADER.format(width=8, depth=0x1000*8))

	for i in range(0x1000):
		if hexdata[i] != -1:
			miffile.write("{0:x} : {1:x};\n".format(i, hexdata[i]))
		else:
			miffile.write("{0:x} : {1:x};\n".format(i, 0))
			
	miffile.write("END")