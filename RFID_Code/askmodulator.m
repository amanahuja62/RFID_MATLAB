function[t3,m]=askmodulator(pie,t3,bitrate)
%XXXXXXXXXXXXXXXXXXXXXXX Binary-ASK modulation XXXXXXXXXXXXXXXXXXXXXXXXXXX%
f=bitrate*10;                                          
m=zeros(1,length(pi));
for i=1:1:length(pie)    
        m(i)=pie(i)*cos(2*pi*f*t3(i));    
end

