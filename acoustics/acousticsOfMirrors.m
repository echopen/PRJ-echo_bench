function acousticsOfMirrors
	% Speed of longitudinal wave propagation in the considered media.
	% we take the mean value of all source we found
	vWater = mean([1480,1483,1484,1493,1496]);
	vCopper = mean([4660,4760,4760,4660,3560]);
	vPCB = mean([4726,3070,2100,2460]);

	% hereafter are computed the angles between the propagation direction and
	% the normal vector of the planar boundary between media
	% naming convention: angle_a_X is the angle between the propagation vector
	% "a" and the planar boundary "X"
	angle_a_B = deg2rad(19.388043);
	angle_b_B = angle_a_B;
	angle_c_B = transmittedAngle(vWater, vCopper, angle_a_B);
	angle_c_C = angle_c_B;
	angle_d_C = angle_c_C;
	angle_d_B = angle_d_C;
	angle_e_B = transmittedAngle(vCopper, vWater, angle_d_B);
	angle_f_C = transmittedAngle(vCopper, vPCB, angle_c_B);

	disp(strcat("a->B    : ",num2str(rad2deg(angle_a_B))));
	disp(strcat("   B->c : ",num2str(rad2deg(angle_c_B))));
	disp(strcat("c->C    : ",num2str(rad2deg(angle_c_C))));
	disp(strcat("   C->d : ",num2str(rad2deg(angle_d_C))));
	disp(strcat("d->B    : ",num2str(rad2deg(angle_d_B))));
	disp(strcat("   B->e : ",num2str(rad2deg(angle_e_B))));
	disp(strcat("   C->f : ",num2str(rad2deg(angle_f_C))));
	
	return;
endfunction

% Share of the energy which is reflected at the boundary between two 
% media of acoustic impedences "z1" and "z2"
function x = reflectionCoeff (z1, z2)
	x = ((z2-z1)/(z2+z1))^2;
	return;
endfunction

% Angle of the transmitted wave meeting the boundary between two 
% media  of longitudinal wave velocities "v1" and "v2" at an incendent 
% angle "incident_angle"
function x = transmittedAngle (v1, v2, incident_angle)
	x = asin (sin(incident_angle)*v2/v1);
	return;
endfunction

% returns the critical angle for longitudinal wave transmission. Any
% wave meeting the boundary with a greater angle than those returned
% will be totally reflected
function x = criticalAngleOfLongitudinalTransmission(v1, v2)
	x = asin (v1/v2)
	return;
endfunction