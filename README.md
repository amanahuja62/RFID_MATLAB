# RFID_MATLAB
This project is about the simulation of communication between RFID tag and reader.
To start communication with tag, first authentication is done. Reader sends PIE encoded tag code by modulating it with RF carrier. 
Tag demodulates the ASK signal it receives from reader, to get PIE encoded tag code. After that tag decodes the code and compares it 
with its own code. If the code matches with tag’s own code, then it is successful authentication. Then tag sends an acknowledgement signal
to the reader. After receiving acknowledgement signal reader sends carrier modulated pie encoded command requesting tag to send data. 
Upon receipt of this command tag sends the FM0 encoded digital data to reader by modulating it with RF carrier. Reader demodulates the 
signal and decodes the data it gets from tag and saves it in its memory.
