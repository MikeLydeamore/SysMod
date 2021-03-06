%% Setup
stopPoint=[12 25; 30 25;
        24.3 15];
noPassengers=[3; 5;
        20];
loadTime=2;
passengersOnBus=[4 ;4];

busStartingPosition=[5 7 25 25 ;
        24.3 24.3 50 48]; %1 row per bus
[numberOfBuses discard]=size(busStartingPosition);
busDirections=[1 0 ;
        0 -1]; %[1 0] for horizontal left, [-1 0] for horizontal right, similarly for vertical movement.

busPos=zeros(numberOfBuses,4); %Preallocate positions for buses

pickup=zeros(1,numberOfBuses);

busStoppedFor=zeros(1,numberOfBuses); %Time that the bus is stationary

timeStep=0.1;
maxTime=40/timeStep;

roads=[0 50 25 25;
    25 25 0 50];
busPos=busStartingPosition;
%% Iterations
while true
    pickup=zeros(1,numberOfBuses); 
    for i=1:numberOfBuses %Number of buses
        %% Determine bus position at t
        if busStoppedFor(i)==0 %If not stopped
            busPos(i,:)=[busPos(i,1:2)+(busDirections(i,1)*timeStep), busPos(i,3:4)+(busDirections(i,2)*timeStep)];
        end
        redraw(roads,busPos,passengersOnBus,pickup,pickup);
        
        %% Determine if stopping
        if sum(abs(busPos(i,1)-stopPoint(:,1))<0.01)>0 && sum(abs(busPos(i,3)-stopPoint(:,2))<0.01)>0 %Each will be nonzero if the coordinate matches a stop
            stopNumber=intersect(find(abs(busPos(i,1)-stopPoint(:,1))<0.01),find(abs(busPos(i,3)-stopPoint(:,2))<0.01)); %Determine stop number (may be empty)
            if ~isempty(stopNumber)
                pickup(i)=1;
            end
            if busStoppedFor(i) > 0 %Bus already stopped
                busStoppedFor(i)=busStoppedFor(i)-loadTime;
                if mod(busStoppedFor(i),(loadTime/timeStep))==0 %Loading every loadTime seconds
                    passengersOnBus(i)=passengersOnBus(i)+1;
                end
            elseif busStoppedFor(i) < 0 %Held for slightly too long
                busStoppedFor(i)=0;
            elseif ~isempty(stopNumber) %First time stopping, determine what stop and number of passengers if there is one
                    busStoppedFor(i)=noPassengers(stopNumber)*(loadTime/timeStep);
            end
            
        end
    end
    redraw(roads,busPos,passengersOnBus,pickup,pickup);
    pause(0.005)
    hold off
end