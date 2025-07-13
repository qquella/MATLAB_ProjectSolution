## Solution to MATLAB and Simulink Challenge Project <1234> – “Generative Melody Composer”

This repository contains a complete, end-to-end solution for the Generative Melody Composer challenge.

The project trains an LSTM network on the JSB Chorales data set (symbolic, monophonic) and generates new chorale-style melodies, outputting them as MIDI files that can be auditioned inside MATLAB® or any DAW.

⸻

### 📂 Program Link

➡ Repository: https://github.com/qquella/MATLAB_ProjectSolution

⸻

### 📄 Project Description Link

➡ Challenge page: https://github.com/mathworks/MATLAB-Simulink-Challenge-Project-Hub/tree/main/projects/Music%20Composition%20with%20Deep%20Learning#music-composition-with-deep-learning
⸻

### 🛠️ Project Details

File Purpose
preprocess_jsb.m Reads every CSV in train/, valid/, and test/, converts pitch rows (-1 = rest) into integer-token sequences, and saves them to jsb_data.mat.
train_jsb.m Builds and trains a two-layer LSTM (512 units each) plus embedding and projection head on the sequences; saves the network as jsb_net.mat.
generate_jsb.m Samples from the trained model with temperature and length controls, converts tokens back to MIDI messages, and writes chorale_sample.mid.
notes2midimsg.m Helper that maps tokens → midimsg array for playback or file writing.
run_jsb.m One-click pipeline: preprocess → train → generate.
main.m Minimal entry point showing typical arguments.

#### Approach Highlights

    •	Symbolic Representation Each note is a single integer token (128 pitches + rest + BOS/EOS).
    •	Sequence Modelling A standard seq-to-seq LSTM is the baseline; you can drop in a Transformer or diffusion model later without touching the data pipeline.
    •	Pure MATLAB Workflow No external Python or TensorFlow calls—just Deep Learning Toolbox™ and Audio Toolbox™.

⸻

### ▶️ How to Run

1. Requirements
   • MATLAB R2021b or later
   • Deep Learning Toolbox™
   • Audio Toolbox™ (for MIDI I/O and optional real-time playback)
2. Clone the repo

```bash
git clone https://github.com/your-org/generative-melody-composer
cd generative-melody-composer

```

3. Download the data

JSB_Chorales/
├── train/_.csv
├── valid/_.csv
└── test/\*.csv

Each CSV must have one row of comma-separated MIDI pitches; use -1 for rests.

4. Run the pipeline

% In MATLAB
run_jsb("full/path/to/JSB_Chorales", 0.9, 640); % (rootDir, temperature, maxLen)

Output: chorale_sample.mid in the current working folder.

5. Listen

msgs = midiread("chorale_sample.mid");
audio = midi2audio(msgs,"Instrument",'Acoustic Grand Piano');
soundsc(audio,44100)

or open the MIDI file in your favourite DAW / software synth.

Optional switches

Parameter Effect
temperature > 1 = more random; < 1 = more conservative
maxLen Upper bound on generated tokens (roughly notes/rests)
