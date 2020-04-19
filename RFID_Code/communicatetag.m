function[authresult,data,time]=communicatetag(m,authrequired,fc,t3,senddata)
data=[];
time=[];
authresult=1;
bp=10e-6;
mycode=[1 0 1 0 1 1 0 1];
n=bp/(t3(2)-t3(1));
if(authrequired==1)
      m=2*m.^2;
    [xr]=lowpassfilter(m,t3,0.5*fc);
    x=xr;
    for i=1:length(xr)
        if xr(i)<=0.03
            xr(i)=0;
        end
        if xr(i)>=0.29
            xr(i)=0.29;
        end
    end
      xr=xr*(1/0.29);
      
      count=0;
      eval=[];
  for i=1:length(xr)
      if(xr(i)==1)
          count=count+1;
      else
          if count>0.74*n
              eval=[eval 1];
        
          elseif count>0.46*n 
              eval=[eval 0];
          end
          count=0;
      end
      
  end
 
  count=length(mycode);
  for i=1:length(mycode)
      if mycode(i)==eval(i)
          count=count-1;
      end
  end
  if count==0
      authresult=1;
  else
      authresult=0;
  end
  figure(2)
   subplot(2,1,1)
    plot(t3,x)
    xlabel('time')
    ylabel('amplitude')
    title('output of low pass filter')
     subplot(2,1,2)
    plot(t3,xr)
    xlabel('time')
    ylabel('amplitude')
    title('output of comparator (reveived pie encoded tag code from reader)')
      
else
    if senddata==1
        
        d=[1 0 1 0 1 1 0 0];
        bp=10e-6;
        d1=[];
        t1=0:bp/100:0.99*bp;
        t=[];
        c=0;
        for i=1:length(d)
            if i==1
                t=[t t1];
            else
                t=[t t(length(t))+0.01*bp+t1];
            end
            
           if d(i)==1
               
               for i1=1:100
                                     
                   if rem(c,2)==0
                       x=1;
                   else
                       x=0;
                   end
                   d1=[d1 x];           
               end
               c=c+1;
           else
            
               for i1=1:50
                   d1=[d1 1];
               end
                 for i1=1:50
                   d1=[d1 0];
                 end
           end
                        
        end
        [time,data]=askmodulator(d1,t,1/bp);
            
 
    end
    
end



