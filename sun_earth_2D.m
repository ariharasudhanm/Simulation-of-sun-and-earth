% Clear the variable from previous run
clear
clc

% Input paramters, mass of sun and Earth, distance, etc.
me =  6e24;   % mass of Earth = 5.97219 × 10^24 kilograms, Ref: Google
ms = 2e30; % mass of the sun = 1.9891 × 10^30 kilograms, Ref: Google
distance = 1.5e11 * 1.0 ;   % Typical distance between sun and earth
% 149.6 million kilometers, Ref: http://wiki.answers.com/Q/What_is_the_distance_between_Earth_and_the_Sun

% dt = one day  = 24 x 60 x 60 seconds
one_day = 86400 ; 

sf= 3 ;
dt = one_day /sf %  100 step in one day
end_t =  365 * sf  ; % Number of time steps
% Gravitational forces vector formula
% http://physics.stackexchange.com/questions/17285/split-gravitational-force-into-x-y-and-z-componenets
% F(vector) = G m1 m2 r(vector) / r^3

G = 6.674e-11 ; % constant of gravity
% G =  6.674×10^?11 N m2 kg   , Ref: http://en.wikipedia.org/wiki/Newton's_law_of_universal_gravitation


% Initial condition, position of the earth, velocities, etc.
% Orbital speed: 7.89 km/s
velocity = 7.89e3 * 3;  % Again this is typical velocity

xe = distance ; 
ye = 0 ; 
vxe = - velocity /1000 ; 
vye = velocity ; 

data_x=zeros(end_t,1);
data_y=zeros(end_t,1);
% Main Loop

for t=1:end_t
    % Calculate the distance r
    r= sqrt(xe^2+ye^2); 

    % Calculation of forces
    % Ref: http://physics.stackexchange.com/questions/17285/split-gravitational-force-into-x-y-and-z-componenets

    fxe = -1 * G * me * ms * xe / r^3 ; 
    fye = -1 * G * me * ms * ye / r^3 ; 

    % calculation of accelerations

    axe= fxe / me ; 
    aye= fye / me ; 

    % calculation of velocities
    % New velocity = Old Velocity + acceleration x Delta t
    vxe = vxe + dt*axe ; 
    vye = vye + dt*aye ; 

    %Backup the previous position
    old_xe=xe ;
    old_ye=ye ;
    
    % calculation of positions
    % New position = Old position + velocity x Delta t
    xe = xe + dt*vxe ; 
    ye = ye + dt*vye ; 
    
    % Update the plot / Animation
    % plot(0,0,10,5,xe,ye,'o',old_xe,old_ye,'.')
    
    data_x(t,1)=xe ;
    data_y(t,1)=ye ;
    
%plot(0,0,'o',data_x(1:end_t,1),data_y(1:end_t,1),data_x(1:end_t,1),data_y(1:end_t,1),'.')
%plot(0,0,'o',data_x(1:end_t,1),data_y(1:end_t,1))


	%Plot trajectory
	axis equal
	M(t) = getframe;

    %plot(-2e11,-2e11,2e11,2e11,0,0,'o',data_x(1:end_t,1),data_y(1:end_t,1))
 
    % animation
    prev=t-20;
    if (prev<1)
       prev = 1;
    end;

    plot(-2e11,-2e11,2e11,2e11,0,0,'o',data_x(prev:t,1),data_y(prev:t,1))
    

% End of the main loop
end

%plot(data_x(1:end_t,1),data_y(1:end_t,1),'.')

