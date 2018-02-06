function Displace = dispvectors(inputs, outputs, center, radii, theta)

xx = linspace(-pi,pi,40);
yy = linspace(pi/2,-pi/2,20); 
[X,Y]=meshgrid(xx,yy);

input_coord = cat(2, inputs, outputs);
if size(input_coord) ~= [3 4]
    error('Wrong entries for input and output points.')
end
N = 3;
%Transform the input points in sphere points
sphere_coord = zeros(3,6);
n = 1;
while n <= N
    sphere_coord(n,1) = cos(input_coord(n,2))*cos(input_coord(n,1));
    sphere_coord(n,2) = cos(input_coord(n,2))*sin(input_coord(n,1));
    sphere_coord(n,3) = sin(input_coord(n,2));
    sphere_coord(n,4) = cos(input_coord(n,4))*cos(input_coord(n,3));
    sphere_coord(n,5) = cos(input_coord(n,4))*sin(input_coord(n,3));
    sphere_coord(n,6) = sin(input_coord(n,4));
    n = n + 1;
end
%Projects the spheric input points onto stereografic plane
stereo_coord = zeros(3,4);
n = 1;
while n <= N
    stereo_coord(n,1) = 2*sphere_coord(n,2)/(sphere_coord(n,1) +1);
    stereo_coord(n,2) = 2*sphere_coord(n,3)/(sphere_coord(n,1) +1);
    stereo_coord(n,3) = 2*sphere_coord(n,5)/(sphere_coord(n,4) +1);
    stereo_coord(n,4) = 2*sphere_coord(n,6)/(sphere_coord(n,4) +1);
    n = n + 1;
end
%transform the stereographic input points onto complex numbers
complex_coord = zeros(3, 2);
n = 1;
while n <= N
    complex_coord(n,1) = stereo_coord(n,1) + stereo_coord(n,2)*1i;
    complex_coord(n,2) = stereo_coord(n,3) + stereo_coord(n,4)*1i;
    n = n + 1;
end
%Calculates the parameters of moebius transformation using a external
%function called crossmoebius
[a b c d] = crossmoebius(complex_coord(1,1), complex_coord(2,1), complex_coord(3,1),...
    complex_coord(1,2), complex_coord(2,2), complex_coord(3,2));
if abs(c) < 1e-10
    c = 1e-10 + 1e-10*1i;
end
%from final equirectangular projection to the sphere
x_sphere = cos(X).*cos(Y);
y_sphere = sin(X).*cos(Y);
z_sphere = sin(Y);
%From sphere to stereographic plane
X_C =(2*y_sphere)./(x_sphere + 1);
Y_C =(2*z_sphere)./(x_sphere + 1);
%From stereographic plane to complex numbers
Complex = X_C + Y_C*1i;
%inverse moebius transformation
Complex = Complex - a/c;
Complex = Complex*(-(c^2/(a*d - b*c)));
Complex = 1./Complex;
Complex = Complex - d/c;
%Returning to stereographic plane
X_C_n = real(Complex);
Y_C_n = imag(Complex);
%Fixing the mirrowing
r_polar = sqrt(X_C_n.^2 + Y_C_n.^2);
theta_polar = atan2(X_C_n,Y_C_n);
theta_polar = theta_polar + pi/2;
X_C_n = r_polar.*cos(theta_polar);
Y_C_n = r_polar.*sin(theta_polar);
 
%Return to the sphere
x_sphere2 = -(X_C_n.^2 + Y_C_n.^2 - 4)./(X_C_n.^2 + Y_C_n.^2 + 4); 
y_sphere2 = -(4*X_C_n)./(X_C_n.^2 + Y_C_n.^2 + 4); 
z_sphere2 = (4*Y_C_n)./(X_C_n.^2 + Y_C_n.^2 + 4);
 
%Return to the original equirectangular domain
U = atan2(y_sphere2, x_sphere2);
V = asin(z_sphere2);
 
%applying the gaussian
Delta_X = U - X;
Delta_Y = V - Y;

new_DX = gaussian2d(X,Y./cos(Y),1,center(1),center(2),radii(1),radii(2),theta).*Delta_X;
new_DY = gaussian2d(X,Y./cos(Y),1,center(1),center(2),radii(1),radii(2),theta).*Delta_Y;
 
U_Final =  -new_DX;
V_Final =  -new_DY;

Displace = cat(3,X,Y,U_Final, V_Final);

end