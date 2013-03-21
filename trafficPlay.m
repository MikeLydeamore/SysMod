stopPoint=12;
noPassengers=3;
loadTime=1;
passengersOnBus=4;

roads=[0 50 5];
for i=5:0.1:45
%     plot(5*ones(1,50),'k','LineWidth',20)
%     hold on
%     plot(i:i+2,[5 5 5],'b','LineWidth',5)
%     text(i+1,5.1,int2str(passengersOnBus),'color','r');
    redraw(roads,i,passengersOnBus);
    if i==stopPoint %Pick up passengers
        for j=1:noPassengers
            pause(loadTime)
            passengersOnBus=passengersOnBus+1;
            redraw(roads,i,passengersOnBus);
        end
    end
    pause(0.01)
    hold off
end