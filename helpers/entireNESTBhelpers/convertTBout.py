import wave, struct, math, random
sampleRate = 44100.0 # hertz
obj = wave.open('output.wav','w')
obj.setnchannels(1) # mono
obj.setsampwidth(2) # 2 bytes per sample
obj.setframerate(sampleRate)
infile = open("TBout.rwav", "r")
for line in infile.readlines():
   value = int(line)
   data = struct.pack('<h', 2**15 - 1 - value*256)
   obj.writeframesraw( data )
obj.close()
