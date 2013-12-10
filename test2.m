[y,fs,nbits] = wavread('1.wav');
player = audioplayer(y, fs);
play(player);