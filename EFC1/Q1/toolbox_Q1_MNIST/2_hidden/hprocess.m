% FEEC/Unicamp
% 31/05/2017
% function [s] = hprocess(X,S,w1,w2,w3,p1,p2,p3)
% s = product H*p (computed exactly)
%
function [s] = hprocess(X,S,w1,w2,w3,p1,p2,p3)
[N,m] = size(X);
n(1,1) = length(w1(:,1));
n(2,1) = length(w2(:,1));
n_out = length(S(1,:));
x1 = [X ones(N,1)];
rx1 = zeros(N,m+1);
y1 = tanh(x1*w1');
ry1 = (x1*p1'+rx1*w1').*(1.0-y1.*y1);
x2 = [y1 ones(N,1)];
rx2 = [ry1 zeros(N,1)];
y2 = tanh(x2*w2');
% y2 = x2*w2';
ry2 = (x2*p2'+rx2*w2').*(1.0-y2.*y2);
% ry2 = x2*p2'+rx2*w2';
x3 = [y2 ones(N,1)];
rx3 = [ry2 zeros(N,1)];
% y3 = tanh(x3*w3');
y3 = x3*w3';
% ry3 = (x3*p3'+rx3*w3').*(1.0-y3.*y3);
ry3 = x3*p3'+rx3*w3';
erro = y3-S;
% erro3 = erro.*(1.0-y3.*y3);
erro3 = erro;
% rerro3 = ry3.*(1.0-y3.*y3) + erro.*(-2*y3.*ry3);
rerro3 = ry3;
rw3 = erro3'*rx3+rerro3'*x3;
erro2 = (erro3*w3(:,1:n(2))).*(1.0-y2.*y2);
% erro2 = erro3*w3(:,1:n(2));
rerro2 = (rerro3*w3(:,1:n(2))+erro3*p3(:,1:n(2))).*(1.0-y2.*y2)+(erro3*w3(:,1:n(2))).*(-2*y2.*ry2);
% rerro2 = rerro3*w3(:,1:n(2))+erro3*p3(:,1:n(2));
rw2 = erro2'*rx2+rerro2'*x2;
erro1 = (erro2*w2(:,1:n(1))).*(1.0-y1.*y1);
rerro1 = (rerro2*w2(:,1:n(1))+erro2*p2(:,1:n(1))).*(1.0-y1.*y1)+(erro2*w2(:,1:n(1))).*(-2*y1.*ry1);
rw1 = erro1'*rx1+rerro1'*x1;
rEw = [reshape(rw1',n(1)*(m+1),1);reshape(rw2',n(2)*(n(1)+1),1);reshape(rw3',n_out*(n(2)+1),1)];
s = rEw;
