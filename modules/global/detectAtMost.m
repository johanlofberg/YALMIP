function p = detectAtMost(p)
atmostgroups = {};
atmostbounds = [];
atmostvariables = [];
integers = unique([p.integer_variables p.binary_variables]);
if p.K.l > 0 & ~isempty(integers)
    nint = length(integers);
    Aineq = -p.F_struc(p.K.f + (1:p.K.l),2:end);
    bineq = p.F_struc(p.K.f + (1:p.K.l),1);
    notinteger_var_index = setdiff(1:length(p.lb),integers);
    only_integer = ~any(Aineq(:,notinteger_var_index),2);
    Aineq_bin = Aineq(find(only_integer),integers);
    bineq_bin = bineq(find(only_integer),:);
    % Detect groups with constraints #(d_i ~= 0) <= k (for binaries)
    atmostgroups = {};
    for i = 1:size(Aineq_bin,1)
        if bineq_bin(i) >= 1
            [ix,jx,sx] = find(Aineq_bin(i,:));
            % 0/1 or -1/0 variables with with bounded cardinality
            case1 = all(sx == -1) && all(p.lb(integers(jx))==-1) && all(p.ub(integers(jx))==0);
            case2 = all(sx ==  1) && all(p.lb(integers(jx))==0) && all(p.ub(integers(jx))==1);               
            if case1 || case2
                atmostgroups{end+1} = integers(jx);
                atmostbounds = [atmostbounds floor(bineq_bin(i))];
                atmostvariables = [atmostvariables integers(jx)];
            end
        end
    end
end
p.atmost.groups = atmostgroups;
p.atmost.bounds = atmostbounds;
p.atmost.variables = atmostvariables;