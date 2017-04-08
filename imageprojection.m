function [newimage] = imageprojection(image, type, scale, theta_input)
% INPUTS
% image(uint8 matrix) = image input.
% type(string) = type of transformation.
% the types are: perspective, estereographic (stereo), mercator and mobius.
% scale(int or float) = the value of zooming and distortion on complex
% plane of the hyperbolic mobius transform.
% theta_input(int or float) = the value in radians of rotation on complex 
% plane of the hyperbolic mobius transform.
% -----
% OUTPUT
% newimage  = an uint8 matrix that can be read as an image with the
% respective projection trasformation.
% -----
% SYNTAX
% B = imageprojection(A,type) 
% Will do a <type> transformation on image A, if type = 'mobius', the default
% parameters for scale and theta_input will be, respectively, 1 and 0.
% OBS.: scale and theta_input parameters affect ONLY the mobius transform.
% B = imageprojection(A,'mobius',scale)
% Will do a mobius transform in image A, with zooming and distortion of
% value <scale> and no rotation.
% B = imageprojection(A,'mobius',scale,theta_input)
% Will do a mobius transform in image A, with zooming and distortion of
% value <scale> and a rotation of value <theta_input> in radians.
% ------------------------------------------------------------------------
% version 1.3
% Leonardo Souto Ferreira, Leonardo Koller Sacht
% Federal University of Santa Catarina
% Mathematics Department
% 2016
% ------------------------------------------------------------------------
 
%checking function parameters
if nargin < 2
    error('Not suficient input values')
end  
if nargin < 3
   theta_input = 0;
   scale = 1;
end
if  strcmp(type,'mobius') == 1
    if scale == ':'; 
        scale = 1;
    end
    if nargin < 4
        theta_input = 0;
    end
end
if nargin > 4
    error('Too many arguments')
end
%unconcaneting the colors and creating the grid
R=double(image(:,:,1));
G=double(image(:,:,2));
B=double(image(:,:,3));
[nr nc]=size(R);
% Define portion of the final image
x = linspace(-2*pi,2*pi,nc);
y = linspace(-pi,pi,nr);
[X,Y]=meshgrid(x,y);
%Define the domain
aa = linspace(-pi,pi,nc);
cc = linspace(-pi/2,pi/2,nr); 
[AA,CC]=meshgrid(aa,cc);
%choosing the type of the projection
switch type
    case 'original'
        U=X;
        V=Y;
    case 'perspective'
        U = atan(X);
        V = atan(Y.*cos(U));
    case 'stereo'
%         x = linspace(-1,1,nr);
%         y = linspace(-1,1,nr);
        [X,Y]=meshgrid(x,y);
        U=atan2((4*X),(4-X.^2-Y.^2));
        V=asin(4*Y./(X.^2+Y.^2+4));
    case 'mercator'
        U=X;
        V=sign(Y).*asec((0.5).*(exp(-Y)+exp(Y)));
    case 'mobius'
        %From final perspective projection to the sphere
        x_first_sphere = sqrt(1./(1 + X.^2 + Y.^2));
        y_first_sphere = x_first_sphere.*X;
        z_first_sphere = x_first_sphere.*Y;
        %From the sphere to complex plane using stereographic projection
        x_complex = 2.*y_first_sphere./( x_first_sphere + 1 );
        y_complex = 2.*z_first_sphere./( x_first_sphere + 1 );
        %From cartesian coordinates to polar coordinates
        r_polar = sqrt(x_complex.^2 + y_complex.^2);
        theta_polar = atan2(x_complex,y_complex);
        %The mobius transform
        r_mobius = r_polar/scale;
        theta_mobius = theta_polar - theta_input + pi/2;
        %return to cartesian coordinates
        new_x_complex = r_mobius.*cos(theta_mobius);
        new_y_complex = r_mobius.*sin(theta_mobius);
        %From complex plane to sphere using inverse stereographic projection
        x_sec_sphere = (new_x_complex.^2 + new_y_complex.^2 - 4)./(new_x_complex.^2 + new_y_complex.^2 + 4);
        y_sec_sphere = (4.*new_x_complex)./(new_x_complex.^2 + new_y_complex.^2 + 4);
        z_sec_sphere = (4.*new_y_complex)./(new_x_complex.^2 + new_y_complex.^2 + 4);
        %From sphere to equirectangular domain
        U = atan(y_sec_sphere./x_sec_sphere);
        V = asin(z_sec_sphere);               
    otherwise
        error('Its not a valid expression for <type>')
end

    %matlab interpolation function
    r=qinterp2(AA,CC,R,U,V,2);
    g=qinterp2(AA,CC,G,U,V,2);
    b=qinterp2(AA,CC,B,U,V,2);
    newimage = uint8(cat(3,r,g,b));

end