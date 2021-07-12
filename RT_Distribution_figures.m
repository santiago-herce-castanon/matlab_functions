x = linspace(0,50,1000);
y1 = poisspdf(20,x);
%y2 = poisspdf(20,x);
y3 = poisspdf(30,x);
figure, 
area(x,y1,'facecolor','g','facealpha',0.7)
hold on,
%plot(x,y2,'k')
area(x,y3,'facecolor',[1 .5 0],'facealpha',0.7)
box off
set(gca,'visible','off')

figure,
area(x,(y1+y3),'facecolor','k','facealpha',0.7)
hold on,
area(x,(y1),'facecolor','g','facealpha',0.7)
area(x,(y3),'facecolor',[1 .5 0],'facealpha',0.7)
box off
set(gca,'visible','off')
