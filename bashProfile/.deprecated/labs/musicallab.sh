#^ MusicalLab
export musical="$labs"/MusicalLab
export musicallab="$musical"
function musicallab_lestwork {
	cd "$musicallab"; clear;
	stn .dev/MusicalLab.sublime-project
}

#^ Ucho Rosiczki
export rosetaear="$labs"/MusicalLab/RosetaEar
function rosetaear_letswork {
	cd "$rosetaear"; clear;
	xcode Earing/Earing.xcodeproj
	stn "$rosetaear"/Earing/UCHO_ROSICZKI.sublime-project
}

#^ PyMidiComposer
export pymidicomposer="$musicallab"/PyMidiComposer
export pmc="$pymidicomposer"
function pmc_letswork {
	cd "$pmc"; clear;
	stn .dev/PyMidiComposer.sublime-project
}
export font0="/home/felidadae/Downloads/fluid-soundfont/FluidR3 GM2-2.SF2"

export rosetus="$musical/RosetusSynth"
