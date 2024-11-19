function [Lat,Lon] = TakeoffSelectionFcn(geoaxes,cacheLimitsLat,cacheLimitsLon)
title("Select Takeoff Position")
[Lat,Lon] = ginput(1);
hold on;
geoplot(geoaxes,Lat, Lon,'g*','MarkerSize',4);
hold off;
geolimits(cacheLimitsLat,cacheLimitsLon);
end