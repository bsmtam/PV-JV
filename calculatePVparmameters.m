
function calculatePVparmameters(J_sol,V_PV)

Curr=J_sol;
Volts=V_PV;

zPhi=find(Curr>0,1,'last');
zPlo=find(Curr<0,1,'first');
%
% Get the slope between these points
  slopeVoc=(Curr(zPhi)-Curr(zPlo))/(Volts(zPhi)-Volts(zPlo));


% Find zero crossing, by solving with slope - This is V open-circuit
  Voc = -Curr(zPlo)/slopeVoc + Volts(zPlo)

  % approximate series resistance;
Rs=1/slopeVoc;

% short circuit is current at V=0 (converted to A)
  zind=find(Volts>0,1)-1;
  Isc = Curr(zind)
  
% make array of power from I*V, pick out the max 

   fills = (Curr).*Volts;
   [pmax,pind]=max(fills);
%
% theoretical power from the max we found
  Vmp = Volts(pind)
  Imp = Curr(pind)
  maxPow = abs(Imp*Vmp)
% 
% Must convert current to Amps
  theorPow=abs((Isc)*Voc)

% Find the fill factor
FF = maxPow/theorPow
PCE= Voc*Isc*FF

