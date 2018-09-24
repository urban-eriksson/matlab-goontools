function [c,pr] = constants()
% Speed of light, 299792458 m/s
% Vaccuum permittivity, 8.854187817620391e-012 F/m
% Planck constant, 6.62606957e-34 J*s
% Reduced Planck constant, 1.05457148e-34 J*s
% Boltzmann constant, 1.38065e-23 J/K
% Vacuum permeability, 4e-7 * pi N/A^2
% Elementary charge, 1.602176565e-19 C
% 0C expressed in Kelvin, 273.15 K
% Electron volt, 1.602176565e-19J
% Y, 1e24;
% Z, 1e21;
% E, 1e18;
% P, 1e15;
% T, 1e12;
% G, 1e9;
% M, 1e6;
% k, 1e3;
% m, 1e-3;
% u, 1e-6;
% n, 1e-9;
% p, 1e-12;
% f, 1e-15;
% a, 1e-18;
% z, 1e-21;
% y, 1e-24;

c.c0 = 299792458;
c.eps0 = 8.854187817620391e-012;
c.h = 6.62606957e-34;
c.hbar = 1.05457148e-34;
c.kB = 1.38065e-23;
c.mu0 = 4e-7 * MathConst.pi;
c.q = 1.602176565e-19;
c.T0 = 273.15;
c.eV = 1.602176565e-19;

pr.yotta = 1e24;
pr.zetta = 1e21;
pr.exa = 1e18;
pr.peta = 1e15;
pr.tera = 1e12;
pr.giga = 1e9;
pr.mega = 1e6;
pr.kilo = 1e3;
pr.milli = 1e-3;
pr.micro = 1e-6;
pr.nano = 1e-9;
pr.pika = 1e-12;
pr.femto = 1e-15;
pr.atto = 1e-18;
pr.zepto = 1e-21;
pr.yocto = 1e-24;	
