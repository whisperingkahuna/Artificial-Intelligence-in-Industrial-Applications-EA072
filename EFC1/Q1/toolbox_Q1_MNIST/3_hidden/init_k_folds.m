% 28/05/2017 - FEEC/Unicamp
% Random generation of the neural network weights, with uniform distribution in the interval [-0.1,+0.1]
% function [w1,w2,w3,w4,eq,CERv,stw1,stw2,stw3,stw4,rms_w,CER_min,niter_v,niter,nitermax,error_per_class_v] = init_k_folds(n_in,n_hid,n_out,fold,resp)
% n_in = number of inputs
% n_hid = number of neurons at the 3 hidden layers
% n_out = number of neurons at the output layer
% w1, w2, w3, w4: Matrices of weights (one for each layer)
% w1: n_hid(1) x (n_in+1)   w2: n_hid(2) x (n_hid(1)+1)   w3: n_hid(3) x (n_hid(2)+1)   w4: n_out x (n_hid(3)+1)
% Type of weight generation:
% Option 1 -> Start the training from a random initial condition
% Option 2 -> Restart the training from the same initial condition
% Option 3 -> Restart the training from the last set of weights obtained after training
%
function [w1,w2,w3,w4,eq,CERv,stw1,stw2,stw3,stw4,rms_w,CER_min,niter_v,niter,nitermax,error_per_class_v] = init_k_folds(n_in,n_hid,n_out,fold,resp)
if resp == 1;
	w1 = -0.1 + 0.2*rand(n_hid(1),n_in+1);
	w2 = -0.1 + 0.2*rand(n_hid(2),n_hid(1)+1);
	w3 = -0.1 + 0.2*rand(n_hid(3),n_hid(2)+1);
	w4 = -0.1 + 0.2*rand(n_out,n_hid(3)+1);
    save(strcat('w10',sprintf('%d',fold)),'w1');
    save(strcat('w20',sprintf('%d',fold)),'w2');
    save(strcat('w30',sprintf('%d',fold)),'w3');
    save(strcat('w40',sprintf('%d',fold)),'w4');
	eq = [];CERv = [];stw1 = [];stw2 = [];stw3 = [];stw4 = [];rms_w = [];CER_min = [];niter_v = 0;niter = 1;error_per_class_v = [];
    nitermax = input('Maximum number of iterations = ');
elseif resp == 2,
    load(strcat('w10',sprintf('%d',fold)));
    load(strcat('w20',sprintf('%d',fold)));
    load(strcat('w30',sprintf('%d',fold)));
    load(strcat('w40',sprintf('%d',fold)));
	eq = [];CERv = [];stw1 = [];stw2 = [];stw3 = [];stw4 = [];rms_w = [];CER_min = [];niter_v = 0;niter = 1;error_per_class_v = [];
    nitermax = input('Maximum number of iterations = ');
elseif resp == 3,
    load(strcat('w1',sprintf('%d',fold)));
    load(strcat('w2',sprintf('%d',fold)));
    load(strcat('w3',sprintf('%d',fold)));
    load(strcat('w4',sprintf('%d',fold)));
    load(strcat('evol',sprintf('%d',fold)));
    niterad = input('Additional number of iterations = ');
    nitermax = niter+niterad;
else
	error('Not a valid option!');
end
