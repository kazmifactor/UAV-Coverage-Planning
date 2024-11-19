function [roi_points, xyz] = PolygonSelectionFcn(geoaxes, cacheLimitsLat, cacheLimitsLon, geocenter)
% PolygonSelectionFcn: Allows the user to interactively draw a polygon on a map and returns its coordinates.
%
% INPUTS:
%   geoaxes         - The geographic axes for polygon selection.
%   cacheLimitsLat  - Latitude limits for the geographic axes (2-element vector).
%   cacheLimitsLon  - Longitude limits for the geographic axes (2-element vector).
%   geocenter       - Reference point for ENU (Earth-Centered, Earth-Fixed) conversion.
%
% OUTPUTS:
%   llapoints       - Polygon coordinates in LLA (Latitude, Longitude, Altitude) format.
%   xyzpoints       - Polygon coordinates in ENU (East, North, Up) format, with altitude removed.

    % Display instructions to the user
    title(["Draw coverage space polygon", "Press Enter to finish drawing polygon"]);

    % Initialize variables for storing polygon points
    polygonSelectionLoop = true;
    polyLats = []; % Latitude points of the polygon
    polyLons = []; % Longitude points of the polygon
    l = [];        % Handle for the polygon line plot

    % Start interactive loop for defining the polygon
    if polygonSelectionLoop
        while true
            % Allow the user to select a point on the map
            [city.Lat, city.Lon] = ginput(1);

            % Break the loop if the user presses ENTER
            if isempty(city.Lat)
                break
            else
                % Cache the latitude and longitude points
                polyLats(end + 1) = city.Lat;
                polyLons(end + 1) = city.Lon;

                % Plot the selected point on the map
                hold(geoaxes, "on");
                geoplot(geoaxes, city.Lat, city.Lon, ...
                    'Marker', 'o', ...
                    'MarkerEdgeColor', 'k', ...
                    'MarkerFaceColor', 'y', ...
                    'MarkerSize', 3);

                % Update the polygon plot
                delete(l); % Delete the previous polygon line
                l = geoplot(geoaxes, [polyLats, polyLats(1)], [polyLons, polyLons(1)], 'b');
                hold(geoaxes, "off");

                % Ensure geographic limits remain consistent
                geolimits(cacheLimitsLat, cacheLimitsLon);
            end
        end
    end

    % Format UAV coordinates in LLA format (add altitude as zero)
    roi_points = [[polyLats, polyLats(1)]', [polyLons, polyLons(1)]', ...
                 zeros(length(polyLats) + 1, 1)];

    % Convert LLA coordinates to ENU coordinates
    xyz = lla2enu(roi_points, geocenter, 'flat');

    % Remove the altitude component (polygon is 2D)
    xyz(:, 3) = [];
end
