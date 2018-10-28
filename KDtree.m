classdef KDtree
    % KDtree  
    
    properties
        root
    end
    
    methods
        % Constructor
        function obj = KDtree(pointarray)
            dimensions = size(pointarray,2);
            obj.root = KDtree.create_tree(pointarray,1, dimensions);
        end
        
        function neighbors = neighborhood(obj, point, radius)
            radius2 = radius^2;
            dimensions = length(point);
            neighbors = KDtree.get_neighborhood(obj.root, point, radius2, 1, dimensions);
        end
        
        function neighbor = nearestneighbor(obj, point)
            dimensions = length(point);
            neighbor = KDtree.find_nearest_neighbor(obj.root, point, 1, dimensions,[], inf);
        end

        
    end
    
    methods(Static)
        
        function node = create_tree(pointarray, depth, dimensions)
            if isempty(pointarray)
                node = [];
                return;
            end

            n_points = size(pointarray,1);
            middle = 1 + floor(n_points / 2);
            dimension = mod(depth-1, dimensions) + 1;
            sortedarray = sortrows(pointarray, dimension);

            node.left = KDtree.create_tree(sortedarray(1:middle-1,:),depth + 1, dimensions);
            node.right = KDtree.create_tree(sortedarray(middle+1:n_points,:), depth + 1 , dimensions);
            node.point = sortedarray(middle,:);
        end
        
        function neighbors = get_neighborhood(node, refpoint, radius2, depth, dimensions)

            if isempty(node)
                neighbors = [];
                return
            end

            if KDtree.distance2(node.point, refpoint) < radius2
                neighbors = node.point;
            else
                neighbors = [];
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

            neighbors_primary = KDtree.get_neighborhood(primary, refpoint, radius2, depth+1, dimensions);
            neighbors = [neighbors ; neighbors_primary];

            if delta^2 < radius2
                neighbors_secondary = KDtree.get_neighborhood(secondary, refpoint, radius2, depth+1, dimensions);
                neighbors = [neighbors ; neighbors_secondary];
            end
        end
        
        function [nearestneighbor,smallestdistance] = find_nearest_neighbor(node , refpoint, depth, dimensions, nearestneighbor, smallestdistance  )
            
            if isempty(node)
                nearestneighbor = [];
                return
            end

            distance = KDtree.distance2(node.point, refpoint);
            if distance < smallestdistance
                smallestdistance = distance;
                nearestneighbor = node.point;
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

            neighbor_primary = KDtree.find_nearest_neighbor(primary, refpoint, depth+1, dimensions, nearestneighbor, smallestdistance);
            if ~isempty(neighbor_primary)
                primarydistance = KDtree.distance2(neighbor_primary, refpoint);
                if primarydistance < smallestdistance
                    smallestdistance = primarydistance;
                    nearestneighbor = neighbor_primary;
                end
                if delta^2 < smallestdistance
                    neighbor_secondary = KDtree.find_nearest_neighbor(secondary, refpoint, depth+1, dimensions, nearestneighbor, smallestdistance);
                    if ~isempty(neighbor_secondary)
                        secondarydistance = KDtree.distance2(neighbor_secondary, refpoint);
                        if secondarydistance < smallestdistance
                            smallestdistance = secondarydistance;
                            nearestneighbor = neighbor_secondary;
                        end
                    end
                end
            end
        end


        function d = distance2(p1,p2)
            d = sum((p2-p1).^2);
        end

        
    end
end

