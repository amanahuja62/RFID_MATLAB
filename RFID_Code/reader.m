tagnumber=[1 0 1 0 1 1 0 1]; %tag number
bp=10e-6;
bitrate=1/bp;
t1=0:bp/100:0.99*bp;
lt1=length(t1);
t2=0:bp/100:1.99*bp;
lt2=length(t2);
pie=[];
t=0;
ttime=[];
t3=[];
tcode=[];
%%%%%%%%%%% encoding tag number by pie encoding method%%%%%%%%%%%
for i=1:length(tagnumber)
    if i==1
        ttime=[ttime t1];
    else
        ttime=[ttime ttime(length(ttime))+0.01*bp+t1];
    end
    
    if tagnumber(i)==1
        if i==1
            t3=[t3 t2];
        else
        t3=[t3 t3(length(t3))+0.01*bp+t2];
        end
       for i1=1:0.75*lt2
           pie=[pie 1];
       end
       for i1=0.75*lt2+1:lt2
           pie=[pie 0];
       end
       for i1=1:lt1
           tcode=[tcode 1];
       end
    else
         if i==1
             t3=[t3 t1];
         else
         t3=[t3 t3(length(t3))+0.01*bp+t1];
         end
             for i1=1:0.5*lt1
           pie=[pie 1];
           tcode=[tcode 0];
             end
       for i1=0.5*lt1+1:lt1
           pie=[pie 0];
           tcode=[tcode 0];
       end
    end
     
end
[t3,m]=askmodulator(pie,t3,bitrate);
figure(1)
subplot(3,1,1)
plot(ttime,tcode)
xlabel('time')
ylabel('amplitude')
title('tag code sent by reader')
subplot(3,1,2)
plot(t3,pie)
xlabel('time')
ylabel('amplitude')
title('PIE ENCODED TAG CODE')
subplot(3,1,3)
plot(t3,m)
xlabel('time')
ylabel('amplitude')
title('Code modulated with rf carrier')
senddata=0;
[authresult]=communicatetag(m,1,bitrate*10,t3,senddata);
if authresult==0
    fprintf('Wrong tag code');
else
    senddata=1;
    [authresult,data,time]=communicatetag(m,0,bitrate*10,t3,senddata);
    x9=data;
    data=2*data.^2;
    [data]=lowpassfilter(data,time,5*bitrate);
    figure(3)
    subplot(4,1,1)
    plot(time,x9)
    xlabel('time')
    ylabel('amplitude')
    title('signal receieved from tag')
    subplot(4,1,2)
    plot(time,data)
    xlabel('time')
    ylabel('amplitude')
    title('signal after passing through low pass filter')
    
    for i=1:length(data)
        if(data(i)>0.29)
            data(i)=0.29;
        end
        if data(i)<0.05
            data(i)=0;
        end       
    end
    data=data.*(1/0.29);
    subplot(4,1,3)
    plot(time,data)
    xlabel('time')
    ylabel('amplitude')
    title('clipped waveform')
    %%%%%%%%%%%%%%decoding data received from tag%%%%%%%%%%
    count1=0;
    counto=0;
    n=100;
    eval2=[];
    length(data)
    for i=1:length(data)
        if data(i)==1
           count1=count1+1;
           counto=0;
        end
        if data(i)==0
            counto=counto+1;
            count1=0;
        end
      if count1>=0.92*n
          eval2=[eval2 1]
          count1=0;
      end
      if counto>=0.92*n
          eval2=[eval2 1];
          counto=0;
      end
      if floor(i/100)>length(eval2)
      
      
         eval2=[eval2 0];
      end
          
          
    end
   
        digitaldata=eval2;
        h=[];
        c=0;
        b=0;
        time1=0:0.01*bp:length(digitaldata)*0.99*bp;
        
        for i=1:length(time1)
            if(rem(b,100)==0)
                c=c+1;
            end
            b=b+1;
           h=[h digitaldata(c)];
        end
       subplot(4,1,4)
       plot(time1,h)
       xlabel('time')
       ylabel('amplitude')
       title('message decoded by reader')
  end
    
    
    







