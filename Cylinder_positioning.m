function [ TR ] = Cylinder_positioning( R,L,vt )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Create unit cylinder mesh 
a = 0:pi/6:2*pi;
x = 1*cos(a);
y = 1*sin(a);
x(1) = 0; y(1) = 0;
v = [[x' y' zeros(size(x))'];[x' y' 1*ones(size(x))']];
DT = delaunayTriangulation(v);
[F,V] = freeBoundary(DT);
TR = triangulation(F,V);

% parametrised by radius (R) & length (L)
Vp = bsxfun(@times,V,[R R L]);

% rotate
vs = [0 0 1];
rota = vrrotvec2mat(vrrotvec(vs,vt));
Vp = (rota*Vp')';
Vp = bsxfun(@plus,Vp,disp);

% combining meshes
FF = [F;F+26];
VV = [V;Vp];
end

