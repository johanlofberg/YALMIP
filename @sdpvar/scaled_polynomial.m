function [p,c,v] = scaled_polynomial(x,dmax,dmin)
%SCALED_POLYNOMIAL Creates parameterized polynomial with scaled monomial basis
%
% [p,c,v] = scaled_polynomial(x,dmax,dmin)
%
% SCALED_POLYNOMIAL defines a parameterized polynomial p=c'*v,
% with all monomials of dmin <= degree(p,x) <= dmax. The coefficients in
% the polynomial are c while v is the scaled monomial basis.
%
% Example:
%
% Parameterized quartic
%  x = sdpvar(2,1);
%  p = scaled_polynomial(x,4);
%
% See also POLYNOMIAL

if (length(dmax) > 1) && (length(dmax) ~= length(x))
    error('Dimension mismatch: The second argument should be the max degree for each variable, or a sclar');
end

if nargin > 2
    if (length(dmin) > 1) && (length(dmin) ~= length(x))
        error('Dimension mismatch: The second argument should be the max degree for each variable, or a sclar');
    end
end

if any(dmax < 0)
    error('Only non-negative polynomial degrees possible')
end

if nargin<3
    dmin = 0;
end

if any(dmin > dmax)
    error('Third argument (dmin) should not be larger than second argument (dmax)');
end

if any(dmin < 0)
    error('Only non-negative polynomial degrees possible')
end

v = monolist(x,dmax);
sc = scaledcoefflist(x, dmax);

% Rescale polynomials
v = sc'*v;

if dmin <= dmax & dmin>0
    s = nchoosek(length(x) + dmin-1,dmin-1);
    v = extsubsref(v,s+1:length(v));
end
c = sdpvar(length(v),1);
p = c'*v;