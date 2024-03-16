import asm6502
import sim6502
import dis6502

		
		
src = """ ORG  $2000

	  LDA #$0
	  LDX #$0
	  LDY #$0
	  JSR  $A528
	  JMP GOTOLOOPROUT
	  NOP
GOTOLOOPROUT:
	   JSR $A52B
	NOP
DONELOOP: JMP DONELOOP
"""
lines = src.splitlines()

# Assemble the code in a list called lines.
a = asm6502.asm6502(debug=0)

# set start address

for i in range(0x0000, 0x1FFF, 1):
	a.object_code[i] = 0
	
a.object_code[0xFFFC:0xFFFD] = [0x00, 0x20]
a.assemble(lines)
with open("crispylettuce.nsf", "rb") as nsffile:
	nsfcont = nsffile.read()
	contbytesasints = [int(a) for a in nsfcont]

loadaddr = 0x8CD9
for byte in contbytesasints[0x80:]:
	a.object_code[loadaddr] = byte
	loadaddr += 1



	
	
object_code = a.object_code[:]
# Then instantiate the simulator.
# Also pass it the symbol table so it can know addresses
s = sim6502.sim6502(object_code, symbols=a.symbols)

# And instantiate the disassembler:
d = dis6502.dis6502(object_code, symbols=a.symbols)

# Now
# s.reset() will reset the simulation
# s.execute() will execute the current instruction
# The 6502 state will be in
#   s.pc  Program Counter
#   s.a   Accumulator
#   s.x   X registers
#   s.y   Y register
#   s.sp  stack pointer
#   s.cc  Flags
# d.disassemble(address) will disassemble the instruction as the address and
#                        will return a text string of the disassembly
#
# E.G.

s.reset()

print
print ("SIMULATION START")
print
# Print a header for the simulator/disassembler output
print ("  PC   A  X  Y  SP   Status")

print (" =========== INIT ==============")
# initialisation
for i in range(2000):
    # Disassemble the current instruction
    distxt = d.disassemble_line(s.pc)

    # Execute that instruction
    s.execute()

    # Print out the disassembled instruction followed by the simulator state
    print (" %04x %02x %02x %02x %04x %02x" % (s.pc,s.a,s.x,s.y,s.sp,s.cc) + str(distxt[0]))
    if "jmp  $200d" in str(distxt[0]):
    	break
   

print(s.memory_map.Dump(address=0x0, length=0x7FF))


print (" =========== PLAY ==============")    	
# initialisation
for i in range(2000):
    # Disassemble the current instruction
    distxt = d.disassemble_line(s.pc)

    # Execute that instruction
    s.execute()

    # Print out the disassembled instruction followed by the simulator state
    print (" %04x %02x %02x %02x %04x %02x" % (s.pc,s.a,s.x,s.y,s.sp,s.cc) + str(distxt[0]) + "    " +  str(s.memory_map.Dump(address=0x0, length=0x8)))
    if "jmp  $2009"  in str(distxt[0]) or "brk" in str(distxt[0]):
    	break

print(s.memory_map.Dump(address=0x0, length=0x7FF))
