- OSC - Open Sound Control. mais preciso e flexível que MIDI. sem especificação de hardware
- enviado via protocolos de transmissão de rede: udp, tcp
- enviado para um endereço de IP, numa porta específica
- sintaxe: endereço com formatação de URL, seguido de valores

s.boot // o que realmente manda e recebe os dados osc

(
OSCdef.new(\botao, //nome inventado...
	{
		arg msg, time, addr, port;
		[msg, time, addr, port].postln;
	},
	'pag1/botao'
);
)

NetAddr.langPort //porta default onde SC recebe mnsgs OSC. vai na conf do app...

//nomes dos argumentos não são default...
(
OSCdef.new(\botao,
	{
		arg mensagem, timeStamp, ipOrigem, porta;
		[mensagem, timeStamp, ipOrigem, porta].postln;
	},
	'pag1/botao'
);
)

//temos que parsear a mnsg recebida...
(
OSCdef.new(\botao,
	{
		arg mensagem, timeStamp, ipOrigem, porta;
		// mensagem.postln;
		mensagem[1].postln;
	},
	'pag1/botao'
);
)

//agora o resto dos controles...

(
OSCdef.new(\botao,
	{
		arg mensagem, timeStamp, ipOrigem, porta;
		mensagem[1].postln;
	},
	'pag1/botao'
);

OSCdef.new(\fader1,
	{
		arg mensagem, timeStamp, ipOrigem, porta;
		mensagem[1].postln;
	},
	'pag1/fader1'
);

OSCdef.new(\fader2,
	{
		arg mensagem, timeStamp, ipOrigem, porta;
		mensagem[1].postln;
	},
	'pag1/fader2'
);

OSCdef.new(\knob,
	{
		arg mensagem, timeStamp, ipOrigem, porta;
		mensagem[1].postln;
	},
	'pag1/knob'
);
)

//usando essas mnsgs recebidas para controlar um SynthDef

(
SynthDef(\drone, {
	arg freq = 40, nharm = 12, detune = 0.2, gate = 0, pan = 0, amp = 1;
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.05,0.1,0.5,3), gate);
	sig = Blip.ar(
		freq * LFNoise1.kr(0.2!16).bipolar(detune.neg,detune).midiratio,nharm

	);
	sig = sig * LFNoise1.kr(0.5!16).exprange(0.1,1);
	sig = Splay.ar(sig);
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(0, sig);
}).add
)


x = Synth(\drone, [\gate, 1]);
x.set(\freq, 80)
x.set(\nharm, 8)
x.set(\detune, 0.2)
x.set(\gate, 0)

x.free

(
OSCdef.new(\ligaSynth,
	{
		arg msg; //não preciso de timestamp, porta, IP, etc...
		msg[1].postln;
		x.set(\gate, msg[1]);
	},
	'/pag1/botao'
)
)

(
OSCdef.new(\mudaFreq,
	{
		arg msg;
		msg[1].postln; //quais os valores saindo daqui? qual o problema em mapear direto para freq?
		x.set(\freq, msg[1].linexp(0,1,20,1000)) //como função 'map' do processing. uma regra de 3...
	},
	'/pag1/fader1'
)
)

//sobraram ainda outros argumentos no SynthDef...