range = *(21..108)
short_range = *(21..30)

def midi_print_out(arr, delay=0, duration=0.9, velocity=127)
  midi_print_out = ''
  # delay = 0
  # duration = 1.5 
  # velocity = 127

  arr.each do |note_name|

    note_on = ''
    note_off = ''
 
    if note_name < 46
      duration = 0.6
    end

    note_off_delay = (delay + duration).round(2)

    note_on = "MIDI.noteOn(0, #{ note_name }, #{ velocity }, #{ delay });"
    note_off = "MIDI.noteOff(0, #{ note_name }, #{ note_off_delay });"

    midi_print_out.concat(note_on).concat(note_off)

    delay = (delay + duration).round(2)

  end

  midi_print_out
end

p midi_print_out(range)


def shark_midi(arr)
  midi_command = ''

  arr.each do |start_1, end_1, start_2, end_2|
    note_1_on = ''
    note_1_off = ''
    note_2_on = ''
    note_2_off = ''

    note_1_on = "MIDI.noteOn(0, 21, 127, #{start_1}); "
    note_1_off = "MIDI.noteOff(0, 21, #{end_1}); "

    note_2_on = "MIDI.noteOn(0, 22, 127, #{start_2}); "
    note_2_off = "MIDI.noteOff(0, 22, #{end_2}); "

    midi_command.concat(note_1_on).concat(note_1_off).concat(note_2_on).concat(note_2_off)
  end

  last_time = midi_command.split(';')[-2].split(',').last.delete(')').to_f 
  midi_command.concat("MIDI.noteOn(0, 21, 127, #{(last_time + 0.1).round(1)});")
end


puts "\n"
shark_range = [[0, 0.8, 0.9, 1.8], [3, 3.9, 3.9, 4.9], [5.3, 5.8, 5.7, 6.1], [6.4, 6.7, 6.7, 7], [7.2, 7.4, 7.4, 7.6], [7.8, 8, 8, 8.3], [8.5, 8.7, 8.7, 8.9], [9.1, 9.3, 9.3, 9.5], [9.6, 9.9, 9.9, 10.2]]
p shark_midi(shark_range)
