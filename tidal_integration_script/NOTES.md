Ableton/Tidalcycles integration

- Prefix a loop/single sound with some character/char combo, then bounce it
- Script that organizes bounced sounds as loops/drums/one-shots, etc into a new folder via symlinks
    - ex: ‘tidal_cp_{existing clip name}’
    - ‘tidal’ indicates that it’s meant to be used with tidalcycles/super_dirt
    - ‘cp’ means its a clap sound
    - NOTE: the generated symlinks should have the time the audio file was created prefixed before the clip name so they’re sorted by recency,
       - Actual structure would look something like: ’tidal_cp_{timestamp}_{existing clip name}.wav’