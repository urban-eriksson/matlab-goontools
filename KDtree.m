classdef KDtree
    % KDtree
    % Assumes input where number of points >> dimensions
    % i.e. low dimensional data

    properties(Access=private)
        root, dimensions, pre, post
    end
    
    methods
        % Constructor
        function obj = KDtree(pointarray)
            if size(pointarray,2) > size(pointarray,1)
                obj.pre = @(x) x';
                obj.post = @(x) x';
            else
                obj.pre = @(x) x;
                obj.post = @(x) x;
            end
            pointarray = obj.pre(pointarray);
            [points, obj.dimensions] = size(pointarray);
            indexarray = (1:points)';
            obj.root = KDtree.create_tree(pointarray, indexarray, 1, obj.dimensions);
        end
        
        function neighbors = neighborhood(obj, point, radius)
            point = obj.pre(point);
            radius2 = radius^2;
            neighbors = KDtree.get_neighborhood(obj.root, point, radius2, 1, obj.dimensions);
            neighbors = obj.post(neighbors);
        end

        function indices = neighborhood_indices(obj, point, radius)
            point = obj.pre(point);
            radius2 = radius^2;
            [~, indices] = KDtree.get_neighborhood(obj.root, point, radius2, 1, obj.dimensions);
            indices = obj.post(indices);
        end
        
        function nearestpoint = nearestneighbor(obj, point)
            point = obj.pre(point);
            nearestpoint = KDtree.find_nearest_node(obj.root, point, 1, obj.dimensions,[],-1, inf);
            nearestpoint = obj.post(nearestpoint);
        end
        
        function nearestindex = nearestneighbor_index(obj, point)
             point = obj.pre(point);
            [~, nearestindex] = KDtree.find_nearest_node(obj.root, point, 1, obj.dimensions,[],-1, inf);
            nearestindex = obj.post(nearestindex);
        end
        
        function points_in_range = rangesearch(obj, lowerlimit, upperlimit)
            lowerlimit = obj.pre(lowerlimit);
            upperlimit = obj.pre(upperlimit);
            centerpoint = (upperlimit + lowerlimit) / 2;
            halfrange = (upperlimit - lowerlimit) / 2;
            points_in_range = KDtree.perform_range_search(obj.root, centerpoint, halfrange, 1, obj.dimensions);
            points_in_range = obj.post(points_in_range);
        end

        function indices_in_range = rangesearch_indices(obj, lowerlimit, upperlimit)
            lowerlimit = obj.pre(lowerlimit);
            upperlimit = obj.pre(upperlimit);
            centerpoint = (upperlimit + lowerlimit) / 2;
            demirange = (upperlimit - lowerlimit) / 2;
            [~, indices_in_range] = KDtree.perform_range_search(obj.root, centerpoint, demirange, 1, obj.dimensions);
            indices_in_range = obj.post(indices_in_range);
        end

    end
    
    methods(Static,Access=private)
        
        function node = create_tree(pointarray, indexarray, depth, dimensions)
            if isempty(pointarray)
                node = [];
                return;
            end
            
            points = size(pointarray,1);
            middle = 1 + floor(points / 2);
            dimension = mod(depth-1, dimensions) + 1;
            [sortedarray, index] = sortrows(pointarray, dimension);
            sortedindex = indexarray(index);

            node.left = KDtree.create_tree(sortedarray(1:middle-1,:), sortedindex(1:middle-1), depth + 1, dimensions);
            node.right = KDtree.create_tree(sortedarray(middle+1:points,:), sortedindex(middle+1:points), depth + 1 , dimensions);
            node.point = sortedarray(middle,:);
            node.index = sortedindex(middle);
        end
        
        function [points, indices] = get_neighborhood(node, refpoint, radius2, depth, dimensions)

            if isempty(node)
                points = [];
                indices = [];
                return
            end

            if KDtree.distance2(node.point, refpoint) <= radius2
                points = node.point;
                indices = node.index;
            else
                points = [];
                indices = [];
            end

            dimension = mod(depth-1, dimensions) + 1;
            delta = node.point(dimension) - refpoint(dimension);
            if delta > 0
                primary = node.left;
                secondary = node.right;
            else
                primary = node.right;
                secondary = node.left;
            end

            [points_primary, indices_primary] = KDtree.get_neighborhood(primary, refpoint, radius2, depth+1, dimensions);
            points = [points ; points_primary];
            indices = [indices ; indices_primary];

            if delta^2 < radius2
                [points_secondary, indices_secondary] = KDtree.get_neighborhood(secondary, refpoint, radius2, depth+1, dimensions);
                points = [points ; points_secondary];
                indices = [indices ; indices_secondary]; 
            end
        end
        
        
        function [nearestpoint, nearestindex, smallestdistance] = find_nearest_node(node , refpoint, depth, dimensions, nearestpoint, nearestindex, smallestdistance  )
            
            if isempty(node)
                nearestpoint = [];
                nearestindex = -1;
                smallestdistance = inf;
                return
            end
            
            distance = KDtree.distance2(node.point, refpoint);
            if distance < smallestdistance
                nearestpoint = node.point;
                nearestindex = node.index;
                smallestdistance = distance;
            end
            
            dimension = mod(depth-1, dimensions) + 1;
            delta = node.point(dimension) - refpoint(dimension);
            if delta > 0
                primary = node.left;
                secondary = node.right;
            else
                primary = node.right;
                secondary = node.left;
            end
            
            [point_primary, index_primary, distance_primary] = KDtree.find_nearest_node(primary, refpoint, depth+1, dimensions, nearestpoint, nearestindex, smallestdistance);
            if distance_primary < smallestdistance
                nearestpoint = point_primary;
                nearestindex = index_primary;
                smallestdistance = distance_primary;
            end
            if delta^2 < smallestdistance
                [point_secondary, index_secondary, distance_secondary] = KDtree.find_nearest_node(secondary, refpoint, depth+1, dimensions, nearestpoint, nearestindex, smallestdistance);
                if distance_secondary < smallestdistance
                    nearestpoint = point_secondary;
                    nearestindex = index_secondary;
                    smallestdistance = distance_secondary;
                end
            end
        end


        function [points_in_range, indices_in_range] = perform_range_search(node, centerpoint, demirange, depth, dimensions)

            if isempty(node)
                points_in_range = [];
                indices_in_range = [];
                return
            end

            if KDtree.inside(node.point, centerpoint, demirange)
                points_in_range = node.point;
                indices_in_range = node.index;
            else
                points_in_range = [];
                indices_in_range = [];
            end

            dimension = mod(depth-1, dimensions) + 1;
            delta = node.point(dimension) - centerpoint(dimension);
            
            if delta > 0
                primary = node.left;
                secondary = node.right;
            else
                primary = node.right;
                secondary = node.left;
            end

            [points_primary, indices_primary] = KDtree.perform_range_search(primary, centerpoint, demirange, depth+1, dimensions);
            points_in_range = [points_in_range; points_primary];
            indices_in_range = [indices_in_range; indices_primary];

            if abs(delta) < demirange(dimension)
                [points_secondary, indices_secondary] = KDtree.perform_range_search(secondary, centerpoint, demirange, depth+1, dimensions);
                points_in_range = [points_in_range ; points_secondary];
                indices_in_range = [indices_in_range; indices_secondary];
            end
        end

        function d = distance2(p1,p2)
            d = sum((p2-p1).^2);
        end

        function b = inside(p, centerpoint, halfrange)
            b = all(p <= centerpoint + halfrange & p >= centerpoint - halfrange);
        end
        
    end
end

