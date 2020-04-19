function[y]=lowpassfilter(x,t1,cutofffrequency)
dt=t1(2)-t1(1);
y=zeros(1,length(t1));
t=t1;
for i=1:length(t1)
 ft1=x.*(2*cutofffrequency*sinc(2*pi*cutofffrequency*(-t+t1(i))));
 y(i)=dt*(sum(ft1)-0.5*ft1(1)-0.5*ft1(length(ft1)));
 
 
end
