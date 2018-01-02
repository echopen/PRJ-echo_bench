function acousticsOfMirrors
	% Speed of longitudinal wave propagation in the considered media.
	% we take the mean value of all source we found
	vlWater = mean([1480,1483,1484,1493,1496]);
	vlCopper = mean([4660,4760,4760,4660,3560]);
	vlPCB = mean([4726,3070,2100,2460]);

	% Speed of shear wave propagation in the considered media.
	% we take the mean value of all source we found
	vsWater = vlWater / 2;
	vsCopper = mean([2330,2325,2325]);
	vsPCB = vlPCB / 2;

	% critical angles:
	disp (strcat("critical angle of longitudinal transmission Water->Copper : ", num2str(rad2deg(criticalAngleOfTransmission(vlWater, vlCopper)))));
	disp (strcat("critical angle of shear transmission Water->Copper : ", num2str(rad2deg(criticalAngleOfTransmission(vlWater, vsCopper)))));
	
	% hereafter are computed the angles between the propagation direction and
	% the normal vector of the planar boundary between media
	% naming convention: ("P"|"S") "_" ("R"|"T") "_" <X> <N> is the angle between the normal vector
	% of the boundary X and the propagation vector
	% of the pressure (P) or shear (S) wave reflected (R) or transmitted (T) by the boundary X for the Nth time
	% example: P_R_A_2 is the pressure wave reflected by the boundary A for the second time

	incident = deg2rad(45);

	% Pressure waves
	P_T_A_1 = transmittedAngle(vlWater, vlCopper, incident);
	P_T_A_2 = transmittedAngle(vlCopper, vlWater, P_T_A_1);
	P_T_B_1 = transmittedAngle(vlCopper, vlPCB, P_T_A_1);

	% Shear waves
	S_R_A_1 = transmittedAngle(vlWater, vsWater, incident);
	S_T_A_1 = transmittedAngle(vsWater, vsCopper, incident);
	S_T_A_2 = transmittedAngle(vsCopper, vsWater, S_T_A_1);
	S_T_B_1 = transmittedAngle(vsCopper, vsPCB, S_T_A_1);

	% display in octave console
	disp(strcat("incident : ",num2str(rad2deg(incident))));
	disp(strcat("P_T_A_1 : ",num2str(rad2deg(P_T_A_1))));
	disp(strcat("P_T_A_2 : ",num2str(rad2deg(P_T_A_2))));
	disp(strcat("P_T_B_1 : ",num2str(rad2deg(P_T_B_1))));
	disp(strcat("S_R_A_1 : ",num2str(rad2deg(S_R_A_1))));
	disp(strcat("S_T_A_1 : ",num2str(rad2deg(S_T_A_1))));
	disp(strcat("S_T_A_2 : ",num2str(rad2deg(S_T_A_2))));
	disp(strcat("S_T_B_1 : ",num2str(rad2deg(S_T_B_1))));
	
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
function x = criticalAngleOfTransmission(v1, v2)
	x = asin (v1/v2);
	return;
endfunction