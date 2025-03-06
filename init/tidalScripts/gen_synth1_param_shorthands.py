import pandas as pd
import random
import os
from io import TextIOWrapper

# presets: https://archive.org/download/synth1_202202
# parameter indeces in presets + default values from: https://sound.eti.pg.gda.pl/student/eim/doc/Synth1.pdf

parameters = {
    "osc1_shape": {"index": 0, "default": 2, "min": 0, "max": 3},
    "osc1_FM": {"index": 45, "default": 0, "min": 0, "max": 127},
    "osc1_detune": {"index": 76, "default": 0, "min": 0, "max": 127},
    "osc2_shape": {"index": 1, "default": 1, "min": 1, "max": 4},
    "osc2_pitch": {"index": 2, "default": 64, "min": 0, "max": 127},
    "osc2_fine_tune": {"index": 3, "default": 81, "min": 0, "max": 127},
    "osc2_kbd_track": {"index": 4, "default": 1, "min": 0, "max": 1},
    "osc_mix": {"index": 5, "default": 64, "min": 0, "max": 127},
    "osc2_sync": {"index": 6, "default": 0, "min": 0, "max": 1},
    "osc2_ring_modulation": {"index": 7, "default": 0, "min": 0, "max": 1},
    "osc_pulse_width": {"index": 8, "default": 64, "min": 0, "max": 127},
    "osc_key_shift": {"index": 9, "default": 0, "min": -24, "max": 24},
    "osc_mod_env_on_off": {"index": 10, "default": 0, "min": 0, "max": 1},
    "osc_mod_env_amount": {"index": 11, "default": 64, "min": 0, "max": 127},
    "osc_mod_env_attack": {"index": 12, "default": 0, "min": 0, "max": 127},
    "osc_mod_env_decay": {"index": 13, "default": 0, "min": 0, "max": 127},
    "osc_mod_dest": {"index": 71, "default": 0, "min": 0, "max": 2},
    "osc1_2_fine_tune": {"index": 72, "default": 64, "min": 0, "max": 127},
    "osc_phase_shift": {"index": 91, "default": 0, "min": 0, "max": 127},
    "osc1_sub_gain": {"index": 95, "default": 0, "min": 0, "max": 127},
    "osc1_sub_shape": {"index": 96, "default": 1, "min": 0, "max": 3},
    "osc1_sub_octave": {"index": 97, "default": 1, "min": 0, "max": 1},
    "filter_type": {"index": 14, "default": 1, "min": 0, "max": 3},
    "filter_attack": {"index": 15, "default": 0, "min": 0, "max": 127},
    "filter_decay": {"index": 16, "default": 64, "min": 0, "max": 127},
    "filter_sustain": {"index": 17, "default": 32, "min": 0, "max": 127},
    "filter_release": {"index": 18, "default": 64, "min": 0, "max": 127},
    "filter_freq": {"index": 19, "default": 81, "min": 0, "max": 127},
    "filter_resonance": {"index": 20, "default": 14, "min": 0, "max": 127},
    "filter_amount": {"index": 21, "default": 65, "min": -63, "max": 64},
    "filter_kbd_track": {"index": 22, "default": 64, "min": 0, "max": 127},
    "filter_saturation": {"index": 23, "default": 0, "min": 0, "max": 127},
    "filter_velocity_switch": {"index": 24, "default": 0, "min": 0, "max": 1},
    "amp_attack": {"index": 25, "default": 64, "min": 0, "max": 127},
    "amp_decay": {"index": 26, "default": 64, "min": 0, "max": 127},
    "amp_sustain": {"index": 27, "default": 107, "min": 0, "max": 127},
    "amp_release": {"index": 28, "default": 64, "min": 0, "max": 127},
    "amp_gain": {"index": 29, "default": 64, "min": 0, "max": 127},
    "amp_velocity_sens": {"index": 30, "default": 64, "min": 0, "max": 127},
    "arpeggiator_on_off": {"index": 59, "default": 0, "min": 0, "max": 1},
    "arpeggiator_type": {"index": 31, "default": 0, "min": 0, "max": 4},
    "arpeggiator_oct_range": {"index": 32, "default": 0, "min": 0, "max": 3},
    "arpeggiator_beat": {"index": 33, "default": 11, "min": 0, "max": 18},
    "arpeggiator_gate": {"index": 34, "default": 64, "min": 0, "max": 127},
    "delay_on_off": {"index": 65, "default": 1, "min": 0, "max": 1},
    "delay_type": {"index": 82, "default": 0, "min": 0, "max": 2},
    "delay_time": {"index": 35, "default": 8, "min": 0, "max": 19},
    "delay_time_spread": {"index": 83, "default": 66, "min": 0, "max": 127},
    "delay_feedback": {"index": 36, "default": 40, "min": 0, "max": 127},
    "delay_tone": {"index": 98, "default": 64, "min": 0, "max": 127},
    "delay_dry_wet": {"index": 37, "default": 20, "min": 0, "max": 127},
    "chorus_on_off": {"index": 66, "default": 1, "min": 0, "max": 1},
    "chorus_type": {"index": 64, "default": 2, "min": 1, "max": 4},
    "chorus_delay_time": {"index": 52, "default": 64, "min": 0, "max": 127},
    "chorus_depth": {"index": 53, "default": 64, "min": 0, "max": 127},
    "chorus_rate": {"index": 54, "default": 50, "min": 0, "max": 127},
    "chorus_feedback": {"index": 55, "default": 64, "min": 0, "max": 127},
    "chorus_level": {"index": 56, "default": 40, "min": 0, "max": 127},
    "equalizer_tone": {"index": 60, "default": 64, "min": 0, "max": 127},
    "equalizer_freq": {"index": 61, "default": 64, "min": 0, "max": 127},
    "equalizer_level": {"index": 62, "default": 64, "min": 0, "max": 127},
    "equalizer_Q": {"index": 63, "default": 64, "min": 0, "max": 127},
    "pan": {"index": 90, "default": 64, "min": 0, "max": 127},
    "effect_on_off": {"index": 77, "default": 0, "min": 0, "max": 1},
    "effect_type": {"index": 78, "default": 0, "min": 0, "max": 9},
    "effect_control1": {"index": 79, "default": 64, "min": 0, "max": 127},
    "effect_control2": {"index": 80, "default": 64, "min": 0, "max": 127},
    "effect_level_mix": {"index": 81, "default": 64, "min": 0, "max": 127},
    "play_mode_type": {"index": 38, "default": 0, "min": 0, "max": 2},
    "polyphony": {"index": 94, "default": 16, "min": 1, "max": 32},
    "portament_time": {"index": 39, "default": 0, "min": 0, "max": 127},
    "portament_auto_mode": {"index": 74, "default": 0, "min": 0, "max": 1},
    "unison_mode": {"index": 73, "default": 0, "min": 0, "max": 1},
    "unison_voice_num": {"index": 93, "default": 2, "min": 2, "max": 8},
    "unison_detune": {"index": 75, "default": 22, "min": 0, "max": 127},
    "unison_pan_spread": {"index": 84, "default": 64, "min": 0, "max": 127},
    "unison_pitch": {"index": 85, "default": 24, "min": 0, "max": 48},
    "unison_phase_shift": {"index": 92, "default": 0, "min": 0, "max": 127},
    "pitch_bend_range": {"index": 40, "default": 12, "min": 0, "max": 24},
    "midi_ctrl_src1": {"index": 86, "default": 45057, "min": 45057, "max": 57344},
    "midi_ctrl_sens1": {"index": 50, "default": 74, "min": -100, "max": 100},
    "midi_ctrl_assign1": {"index": 87, "default": 44, "min": -1, "max": 98},
    "midi_ctrl_src2": {"index": 88, "default": 45057, "min": 45057, "max": 57344},
    "midi_ctrl_sens2": {"index": 51, "default": 74, "min": -100, "max": 100},
    "midi_ctrl_assign2": {"index": 89, "default": 43, "min": -1, "max": 98},
    "lfo1_on_off": {"index": 57, "default": 0, "min": 0, "max": 1},
    "lfo1_destination": {"index": 41, "default": 0, "min": 0, "max": 7},
    "lfo1_type": {"index": 42, "default": 0, "min": 0, "max": 4},
    "lfo1_speed": {"index": 43, "default": 0, "min": 0, "max": 127},
    "lfo1_depth": {"index": 44, "default": 0, "min": 0, "max": 127},
    "lfo1_tempo_sync": {"index": 67, "default": 0, "min": 0, "max": 1},
    "lfo1_key_sync": {"index": 68, "default": 0, "min": 0, "max": 1},
    "lfo2_on_off": {"index": 58, "default": 0, "min": 0, "max": 1},
    "lfo2_destination": {"index": 46, "default": 5, "min": 0, "max": 7},
    "lfo2_type": {"index": 47, "default": 0, "min": 0, "max": 4},
    "lfo2_speed": {"index": 48, "default": 0, "min": 0, "max": 127},
    "lfo2_depth": {"index": 49, "default": 0, "min": 0, "max": 127},
    "lfo2_tempo_sync": {"index": 69, "default": 0, "min": 0, "max": 1},
    "lfo2_key_sync": {"index": 70, "default": 0, "min": 0, "max": 1},
}

# synth1_param_dict = {
#     "osc1_shape": 0,
#     "osc1_fm": 45,
#     "osc1_detune": 76,
#     "osc2_shape": 1,
#     "osc2_pitch": 2,
#     "osc2_fine_tune": 3,
#     "osc2_kbd_track": 4,
#     "osc_mix": 5,
#     "osc2_sync": 6,
#     "osc2_ring_modulation": 7,
#     "osc_pulse_width": 8,
#     "osc_key_shift": 9,
#     "osc_mod_env_on_off": 10,
#     "osc_mod_env_amount": 11,
#     "osc_mod_env_attack": 12,
#     "osc_mod_env_decay": 13,
#     "osc_mod_dest": 71,
#     "osc1_2_fine_tune": 72,
#     "osc phase shift": 91,
#     "osc1_sub_gain": 95,
#     "osc1_sub_shape": 96,
#     "osc1_sub_octave": 97,
#     "filter_type": 14,
#     "filter_attack": 15,
#     "filter_decay": 16,
#     "filter_sustain": 17,
#     "filter_release": 18,
#     "filter_freq": 19,
#     "filter_resonance": 20,
#     "filter_amount": 21,
#     "filter_kbd_track": 22,
#     "filter_saturation": 23,
#     "filter_velocity_switch": 24,
#     "amp_attack": 25,
#     "amp_decay": 26,
#     "amp_sustain": 27,
#     "amp_release": 28,
#     "amp_gain": 29,
#     "amp_velocity sens": 30,
#     "arpeggiator_on/off": 59,
#     "arpeggiator_type": 31,
#     "arpeggiator_oct_range": 32,
#     "arpeggiator_beat": 33,
#     "arpeggiator_gate": 34,
#     "delay_on_off": 65,
#     "delay_type": 82,
#     "delay_time": 35,
#     "delay_time_spread": 83,
#     "delay_feedback": 36,
#     "delay_tone": 98,
#     "delay_dry/wet": 37,
#     "chorus on/off": 66,
#     "chorus_type": 64,
#     "chorus_delay time": 52,
#     "chorus_depth": 53,
#     "chorus_rate": 54,
#     "chorus_feedback": 55,
#     "chorus_level": 56,
#     "equalizer_tone": 60,
#     "equalizer_freq": 61,
#     "equalizer_level": 62,
#     "equalizer_q": 63,
#     "pan": 90,
#     "effect_on_off": 77,
#     "effect_unit": 78,
#     "play_mode_type": 38,
#     "polyphony": 94,
#     "portament_time": 39,
#     "portament_auto_mode": 74,
#     "unison_mode": 73,
#     "unison_voice_num": 93,
#     "unison_detune": 75,
#     "unison_pan spread": 84,
#     "unison_pitch": 85,
#     "unison_phase_shift": 92,
#     "pitch_bend_range": 40,
#     "midi_ctrl_src1": 86,
#     "midi_ctrl_sens1": 50,
#     "midi_ctrl_assign1": 87,
#     "midi_ctrl_src2": 88,
#     "midi_ctrl_sens2": 51,
#     "midi_ctrl_assign2": 89,
#     "lfo1_on/off": 57,
#     "lfo1_destination": 41,
#     "lfo1_type": 42,
#     "lfo1_speed": 43,
#     "lfo1_depth": 44,
#     "lfo1_tempo_sync": 67,
#     "lfo1_key_sync": 68,
#     "lfo2_on_off": 58,
#     "lfo2_destination": 46,
#     "lfo2_type": 47,
#     "lfo2_speed": 48,
#     "lfo2_depth": 49,
#     "lfo2_tempo_sync": 69,
#     "lfo2_key_sync": 70
# }



def format_param(param_name, param_val, min_val, max_val):
    # Skip the 'name' parameter
    if param_name == 'name':
        return None
        
    normalized_val = (param_val - int(min_val)) / (int(max_val) - int(min_val))
    normalized_val = round(normalized_val, 3)

    # Clean parameter name: replace spaces and special chars with underscore
    clean_name = param_name.replace(' ', '_').replace('.', '_').replace('/', '_')
    clean_name = ''.join(c if c.isalnum() or c == '_' else '_' for c in clean_name)
    # Remove repeated underscores and trailing underscores
    clean_name = '_'.join(filter(None, clean_name.split('_')))
    
    # Format parameter in Tidalcycles style
    return f"# {clean_name} ({normalized_val})"


def parse_sy1_file(file_input):
    """Parse a .sy1 preset file and return a dictionary of parameter values.
    Args:
        file_input: Either a file path string or a BytesIO object
    """
    preset_data = {}
    
    # Handle both file paths and BytesIO objects
    if isinstance(file_input, (str, bytes, os.PathLike)):
        f = open(file_input, 'r')
    else:  # BytesIO object
        f = TextIOWrapper(file_input)
    
    try:
        lines = f.readlines()
        
        # Skip header lines (name, color, version)
        data_lines = [line.strip() for line in lines[3:] if line.strip()]
        
        # Parse parameter values
        for line in data_lines:
            try:
                index, value = map(int, line.split(','))
                # Find parameter name by index
                param_name = None
                for name, info in parameters.items():
                    if info['index'] == index:
                        param_name = name
                        break
                
                if param_name:
                    preset_data[param_name] = value
            except ValueError:
                continue  # Skip malformed lines
    
    finally:
        f.close()
    
    return preset_data



def process_sy1_file(filepath):
    # Add test for sy1 parsing
    try:
        preset = parse_sy1_file(filepath)
        # print(f"\nParsed .sy1 preset:")
        # for param, value in preset.items():
        #     print(f"{param}: {value}")
    except Exception as e:
        print(f"Error parsing .sy1 file: {e}")
    # print("\nRandom parameters in Tidalcycles format:")
    # print(generate_random_params(param_min_max_dict))

    param_preset_string = ''

    # print("\nNormalized preset values in Tidalcycles format:")
    for param, param_info in parameters.items():
        # Get parameter info
        # param_info = parameters[param]
        param_min = param_info['min']
        param_max = param_info['max']

        if(param == "polyphony"):
            # polyphony is sadly not a mappable parameter :(
            continue;

        value = 0
        if param in preset:
            value = preset[param]
        else:
            value = param_info['default']

        # Normalize value between 0 and 1
        normalized_val = (value - param_min) / (param_max - param_min)

        clean_name = param.lower()
        param_preset_string += f"# {clean_name} (\"{normalized_val:.3f}\")"

    # print(param_preset_string)

    return

def process_sy1_zip(zip_filepath):
    """Process all .sy1 files within a zip file and return their parameter settings"""
    import zipfile
    from io import BytesIO
    
    all_presets = []
    
    try:
        with zipfile.ZipFile(zip_filepath, 'r') as zip_ref:
            # Get list of all .sy1 files in zip
            sy1_files = [f for f in zip_ref.namelist() if f.lower().endswith('.sy1')]
            
            for sy1_file in sy1_files:
                try:
                    # Read .sy1 file contents from zip
                    with zip_ref.open(sy1_file) as f:
                        # Create BytesIO object to handle binary data
                        sy1_data = BytesIO(f.read())
                        
                        # Parse the .sy1 file contents
                        preset = parse_sy1_file(sy1_data)
                        
                        param_preset_string = '['

                        for param, param_info in parameters.items():
                            if param == "polyphony":
                                continue
                                
                            param_min = param_info['min']
                            param_max = param_info['max']
                            
                            value = preset.get(param, param_info['default'])
                            normalized_val = (value - param_min) / (param_max - param_min)
                            
                            clean_name = param.lower()
                            param_preset_string += f"({normalized_val:.3f}),"

                        param_preset_string = param_preset_string[:-1] + ']'

                        all_presets.append(param_preset_string)
                        
                except Exception as e:
                    print(f"Error processing {sy1_file}: {e}")
                    continue
                    
    except Exception as e:
        print(f"Error opening zip file: {e}")
        return []
        
    return all_presets


if __name__ == "__main__":
    zipbank_path = "/Users/will/Documents/Synth1Patches/zipbank"
    all_preset_variables = []
    all_filepaths = []

    # Process each zip file in the zipbank directory
    for zip_filename in os.listdir(zipbank_path):
        if zip_filename.endswith(".zip"):
            zip_path = os.path.join(zipbank_path, zip_filename)
            all_presets = process_sy1_zip(zip_path)
            
            # Generate param_list_string
            # cleaned_presets = [preset_str for preset_str in all_presets]
            param_list_string = '[' + ' , '.join(all_presets) + ']'



            
            # Write to text file with same name as zip
            # os.makedirs(os.path.dirname('./synth1Presets'), exist_ok=True)
            if not os.path.exists('synth1Presets'):
                os.makedirs('synth1Presets')


            cleaned_zip_filename = os.path.splitext(zip_filename)[0]

            chars_to_replace = " -()'."
            for char in chars_to_replace:
                cleaned_zip_filename = cleaned_zip_filename.replace(char, '_')

            cleaned_zip_filename = cleaned_zip_filename.replace('&','and')

            output_path = os.path.join('./synth1Presets', f"synth1Presets_{os.path.splitext(cleaned_zip_filename)[0]}.hs")

            preset_variable_name =  "synth1Presets_" + cleaned_zip_filename
            with open(output_path, 'w') as f:
                f.write(":{\nlet " + preset_variable_name + " = " + param_list_string + "\n:}")

            # print('AHHHHHHHHHHHH',cleaned_zip_filename,preset_variable_name)
            all_filepaths.append(os.path.abspath(output_path))
            all_preset_variables.append(preset_variable_name)
    
    script_block = ":{" + "\nscript".join(all_filepaths) + ":}\n"


    output_path = os.path.join('./synth1Presets', f"synth1Presets_{os.path.splitext(cleaned_zip_filename)[0]}.hs")

    preset_variable_name =  "synth1Presets_" + cleaned_zip_filename
    with open(output_path, 'w') as f:
        f.write(":{\nlet " + preset_variable_name + " = " + param_list_string + "\n:}")

    print('\nscript: '.join(all_filepaths))
    print('[' + ','.join(all_preset_variables) + ']')
