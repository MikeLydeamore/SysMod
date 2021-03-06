function redraw(roads,busPos,passNo,pullOver,pickup,direction)
%Plots the roads, position of the buses and the passengers on the buses

numberOfBuses=size(busPos);
busVertPos=0.75+0.3*pullOver;
busHorPos=-0.3*pullOver;

for i=1:length(pickup)
    if pickup(i)==1
        plotColour(i)='r';
    else
        plotColour(i)='b';
    end
end

hold off;

numberOfRoads=size(roads);
for i=1:numberOfRoads %Plot roads
    plot([roads(i,1) roads(i,2)],[roads(i,3) roads(i,4)],'k','LineWidth',15);
    hold on;
end


for i=1:numberOfBuses
    plot([busPos(i,1) busPos(i,2)]+busHorPos(i),[busPos(i,3) busPos(i,4)]+busVertPos(i),plotColour(i),'LineWidth',3);
    text(busPos(i,1)+0.6,busPos(i,3)+2.5,int2str(passNo(i)),'color',plotColour(i));
end
axis([0 50 0 50]);
end