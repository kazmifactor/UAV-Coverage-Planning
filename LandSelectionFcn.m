function [Lat, Lon] = LandSelectionFcn(geoaxes, cacheLimitsLat, cacheLimitsLon)
% LandSelectionFcn: Allows the user to select a landing position on a map.
%
% INPUTS:
%   geoaxes         - The geographic axes where the selection will be made.
%   cacheLimitsLat  - Latitude limits for the geographic axes (2-element vector).
%   cacheLimitsLon  - Longitude limits for the geographic axes (2-element vector).
%
% OUTPUTS:
%   Lat             - Selected latitude of the landing position.
%   Lon             - Selected longitude of the landing position.

    % Display instructions to the user
    title("Select Landing Position"); % Set the title for the geographic axes

    % Allow the user to click on the map to select a single point
    [Lat, Lon] = ginput(1); % Get latitude and longitude from user input

    % Hold the current plot to overlay the selection marker
    hold(geoaxes, "on");
    
    % Plot the selected landing position with a red star marker
    geoplot(geoaxes, Lat, Lon, 'r*', 'MarkerSize', 4);
    
    % Release the hold to ensure subsequent plots do not overwrite unnecessarily
    hold(geoaxes, "off");
    
    % Adjust the geographic limits of the axes to stay within the specified bounds
    geolimits(cacheLimitsLat, cacheLimitsLon);

    % Reset the title to indicate completion of the selection
    title("Coverage Space");
end
