function redraw(roads,busPos,passNo)

hold off;
plot(roads(1):roads(2),roads(3)*ones(1,length(roads(1):roads(2))),'k','LineWidth',20);
hold on;
plot(busPos:busPos+2,roads(3)*ones(1,3),'b','LineWidth',5);
text(busPos+1,roads(3)+0.1,int2str(passNo),'color','r');
end