import os
import math


SONGROMFOLDER = "songromnsfs"
OUTFILE = "songROMcontentsmultiple.mif"

MIFFILEHEADER = """
DEPTH = {depth};                   -- The size of data in bits
WIDTH = {width};                    -- The size of memory in words
ADDRESS_RADIX = HEX;          -- The radix for address values
DATA_RADIX = HEX;             -- The radix for data values
CONTENT                       -- start of (address : data pairs)
BEGIN
"""

MIFFILEFOOTER = "END"


memoryImage = [0] * (2**18 + 2**17)
nsffilecontents = []

nsffiles = sorted(os.listdir(SONGROMFOLDER))
print("Combining the following .nsfs into {}: {}".format(OUTFILE, ", ".join(nsffiles)))



for nsffilename in nsffiles:
	nsffile = open(os.path.join(SONGROMFOLDER, nsffilename), "rb")
	nsffilecontents.append(nsffile.read())
	
totalnsfs = len(nsffilecontents)


with open("songs.txt", "w") as reportfile:
	i = 0
	for nsffile in nsffiles:
		reportfile.write("{} : {} : {} Bytes\n".format(i, nsffile, len(nsffilecontents[i])))
		i += 1
		
		
freememindex = 1 + totalnsfs*4
memoryImage[0] = totalnsfs
for nsfnum in range(len(nsffilecontents)):
	
	memoryImage[nsfnum*4 + 2] = freememindex & 0xFF
	memoryImage[nsfnum*4 + 3] = (freememindex >> 8) & 0xFF
	memoryImage[nsfnum*4 + 4] = (freememindex >> 16) & 0xFF
	

	for byte in nsffilecontents[nsfnum]:
		try:
			memoryImage[freememindex] = int(byte)
		except IndexError:
			print(" =========== NSF files dont fit into memory...aborting ================")
			exit(-1)
		freememindex += 1
		
		
print("Total MIF image size is {} Bytes of which {} Bytes ({:.1f} %) are used".format(len(memoryImage), freememindex, (freememindex*100/len(memoryImage))))

miffile = open(OUTFILE, "w")
miffile.write(MIFFILEHEADER.format(depth=math.ceil(len(memoryImage)/8), width=64))

for firstbyteinwordindex in range(len(memoryImage)//8):
	
	word = 0
	for i in range(8):
		word = word + (memoryImage[firstbyteinwordindex*8 + i] << ((i)*8))
	
	miffile.write('{:X} : {:016X};\n'.format(firstbyteinwordindex, word))
miffile.write(MIFFILEFOOTER)
miffile.close()