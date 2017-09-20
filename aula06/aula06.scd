s.boot

~b0 = Buffer.read(s, "/Users/Magno/Desktop/sons/drumLoop2.wav");
~b1 = Buffer.read(s, "/Users/Magno/Desktop/sons/drumLoop.aif");
~b0.play;
~b1.play;

~pastaAtual = thisProcess.nowExecutingPath.dirname;

~b0 = Buffer.read(s, ~pastaAtual +/+ "sons/drumLoop2.wav");
~b1 = Buffer.read(s, ~pastaAtual +/+ "sons/drumLoop.aif");
~b0.play;
~b1.play;

////
//// ATRIBUTOS DE UM BUFFER
////

// FRAMES
//como frames de video: subdivisões no tempo
~b0.numFrames
~b1.numFrames

// CHANNELS
~b0.numChannels
~b1.numChannels

// carregar no buffer só um dos canais de um arquivo multicanal
~b2 = Buffer.readChannel(s, ~pastaAtual +/+ "sons/drumLoop.aif", channels:[0]);
~b2.play
~b2.numChannels

// DURATION
~b0.duration
~b1.duration;

// BUFFER NUMBERS (bufnums)
~b0.bufnum
~b1.bufnum
~b2.bufnum

// SAMPLE RATE
~b0.sampleRate
s.sampleRate

// RESUMÃO
~b0.query
~b1.query

////
//// CARREGANDO PARTES DE UM ARQUIVO
////

//só início
~b2 = Buffer.read(s, ~pastaAtual +/+ "sons/voice2.wav", startFrame:0, numFrames:s.sampleRate * 5); // s.sampleRate = 1 segundo
~b2.query
~b2.play

//só final
~b3 = Buffer.read(s, ~pastaAtual +/+ "sons/voice3.wav");
~b3.query
~b3.play

// pq precisei carregar essa parte em um 2o buffer?
~b3_final = Buffer.read(s, ~pastaAtual +/+ "sons/voice3.wav", startFrame:~b3.numFrames - (s.sampleRate * 7), numFrames:~b3.numFrames)
~b3_final.play


////
//// MANIPULANDO PLAYBACK
////

PlayBuf.ar()

{PlayBuf.ar(2, ~b3.bufnum)}.play

(
SynthDef("basicoPlayBuf", {
	arg amp = 1, qualBuffer;
	var som = PlayBuf.ar(numChannels:2, bufnum:qualBuffer, doneAction:2); //lembram do doneAction?
	som = som * amp;
	Out.ar(0, som);
}).add
)

Synth("basicoPlayBuf", [qualBuffer: ~b1.bufnum]);
Synth("basicoPlayBuf", [qualBuffer: ~b0.bufnum]); //erro... pq?

//
(
SynthDef("usandoStartPos", {
	arg amp = 1, qualBuffer, pontoInicio = 0;
	var som = PlayBuf.ar(1, qualBuffer, startPos:pontoInicio, doneAction:2);
	som = som * amp;
	Out.ar(0, Pan2.ar(som)); // lembram do Pan2?
}).add
)

~b0.query
Synth("usandoStartPos", [qualBuffer: ~b0.bufnum, pontoInicio: s.sampleRate * 6]);
Synth("usandoStartPos", [qualBuffer: ~b0.bufnum, pontoInicio: s.sampleRate * rrand(1,8).postln]);
Synth("usandoStartPos", [qualBuffer: ~b0.bufnum, pontoInicio: s.sampleRate * [2.5, 3.5, 5.5].choose]);


//
(
SynthDef("usandoLoop", {
	arg amp = 1, qualBuffer, estahLoopando = 0;
	var som = PlayBuf.ar(2, qualBuffer, loop:estahLoopando, doneAction:2);
	som = som * amp;
	Out.ar(0, som);
}).add
)

Synth("usandoLoop", [qualBuffer: ~b1.bufnum, estahLoopando: 1]);
// como desligar? só mudar "estahLoopando" para 0 funciona?

x = Synth("usandoLoop", [qualBuffer: ~b1.bufnum, estahLoopando: 1]);
x.set(\estahLoopando, 0);


(
SynthDef("usandoLoop02", {
	arg amp = 1, qualBuffer, estahLoopando = 0, pontoInicio;
	var som = PlayBuf.ar(2, qualBuffer, startPos:pontoInicio, loop:estahLoopando, doneAction:2);
	som = som * amp;
	Out.ar(0, som);
}).add
)

Synth("usandoLoop02", [qualBuffer: ~b1.bufnum, pontoInicio: s.sampleRate * 3, estahLoopando: 0]);
Synth("usandoLoop02", [qualBuffer: ~b3_final.bufnum, pontoInicio: 0, estahLoopando: 1]);
// fazer exemplo com um buffer grande (~b3) de onde retira vários buffers menores (como ~b3_final)
// e liga/desliga cada um individualmente
// talvez exercício de gravação...


//
(
SynthDef("rate", {
	arg amp = 1, qualBuffer, velo = 1, pontoInicio = 0;
	var som = PlayBuf.ar(2, qualBuffer, rate:velo, startPos:pontoInicio, doneAction:2);
	som = som * amp;
	Out.ar(0, som);
}).add
)

~b4 = Buffer.read(s, "/Users/Magno/Desktop/temp/voice2.wav");
~b5 = Buffer.read(s, "/Users/Magno/Desktop/temp/cigarra.wav");

Synth("rate", [qualBuffer: ~b1.bufnum, velo: 2]);
Synth("rate", [qualBuffer: ~b4.bufnum, velo: 0.8]);
Synth("rate", [qualBuffer: ~b5.bufnum, velo: 0.2]);

 //coral de monges bêbados...
5.do{Synth("rate", [qualBuffer: ~b4.bufnum, velo: rrand(0.9, 1.1)])};


// tocando ao contrário
Synth("rate", [qualBuffer: ~b1.bufnum, velo: -1]); // não funciona...
Synth("rate", [qualBuffer: ~b1.bufnum, velo: -1, pontoInicio: ~b1.numFrames - 2]); //agora sim!


// para transposição cromática
~b6 = Buffer.read(s, "/Users/Magno/Desktop/temp/notaPiano.wav");

Synth("rate", [qualBuffer: ~b6.bufnum, velo: 1.midiratio]);
Synth("rate", [qualBuffer: ~b6.bufnum, velo: 2.midiratio]);
Synth("rate", [qualBuffer: ~b6.bufnum, velo: 3.midiratio]);
Synth("rate", [qualBuffer: ~b6.bufnum, velo: 4.midiratio]);
Synth("rate", [qualBuffer: ~b6.bufnum, velo: 5.midiratio]);




// não funciona...
(
SynthDef.new("startPosTrigger", {
	arg amp = 1, qualBuffer, pontoInicio = 0, trig = 1;
	var som = PlayBuf.ar(1, qualBuffer, trigger:trig, startPos:pontoInicio, doneAction:0);
	som = som * amp;
	Out.ar(0, Pan2.ar(som)); // lembram do Pan2?
}).add
)

Synth.new("startPosTrigger", [qualBuffer: ~b0.bufnum, pontoInicio: s.sampleRate * 6, trig: 1]);