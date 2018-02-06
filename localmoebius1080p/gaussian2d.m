function G = gaussian2d(x, y, A, x_0 , y_0, sigma_x, sigma_y, theta)

alpha = (cos(theta).^2)/(2.*sigma_x.^2) + (sin(theta).^2)./(2.*sigma_y.^2);
beta = -sin(2.*theta)./(4.*sigma_x.^2) + sin(2.*theta)./(4.*sigma_y).^2;
gamma = (sin(theta).^2)/(2.*sigma_x.^2) + (cos(theta).^2)./(2.*sigma_y.^2);

G = A.*exp(-(alpha.*(x - x_0).^2 + 2.*beta.*(x - x_0).*(y - y_0) + gamma.*(y - y_0).^2));


end