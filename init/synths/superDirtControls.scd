// OSCFunc to receive file paths and load them into SuperDirt
(
OSCFunc({ |msg, time, addr, recvPort|
    var filePath = msg[1].asString;
    
    // Log the received path
    ("Received request to load samples from: " ++ filePath).postln;
    
    // Check if the path exists
    if(File.exists(filePath) || filePath.contains("*"), {
        // Load the sound files from the received path
        ("Loading sound files from: " ++ filePath).postln;
        ~dirt.loadSoundFiles(filePath);
        ("Successfully loaded sound files from: " ++ filePath).postln;
    }, {
        ("Warning: Path does not exist: " ++ filePath).postln;
    });
}, '/tidal/loadSamples', nil, 57209);



"OSCFunc for loading samples is now active on port 57209".postln;
)