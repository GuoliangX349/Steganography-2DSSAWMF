%% Payload
payload = 0.4;       
params.seed = 123; % It can be a random number
H=0; % It uses optimal simulator for embedding when H=0.
C=imread('1013.pgm');
%% Parameters
% SSAWMF(C,gamma,weight,iteration,weightType,payload, H,params,u,v,s,t);
% Parameters for 2D-SSA: window width, u, height, v, starting component, s, ending component, t.
% Parameters for WMF: window radius gamma, weight, iteration;
% weightType: The weight form that defines the pixel affinity of pixel "p" and "q".
%                 'exp': exp(-|F(p)-F(q)|^2/(2*sigma^2)) [default]
%                 'iv1': (|F(p)-F(q)|+sigma)^-1 
%                 'iv2': (|F(p)-F(q)|^2+sigma^2)^-1
%                 'cos': dot(F(p),F(q))/(|F(p)|*|F(q)|)
%                 'jac': (min(r1,r2)+min(g1,g2)+min(b1,b2))/(max(r1,r2)+max(g1,g2)+max(b1,b2))
%                        where F(p)=(r1,g1,b1) and F(q)=(r2,g2,b2)
%                 'off': 1
%% Embedding
tic
stego_k3 =SSAWMF(C,5,3,2,'exp',payload, H,params,3,3,8,9);
T1=toc;
tic;
stego_k7 =  SSAWMF(C,5,3,2,'exp',payload, H,params,3,3,8,9);
T2=toc;
tic;
stego_k15 = SSAWMF(C,5,3,2,'exp',payload, H,params,3,3,8,9);
T3=toc;
subplot(2,3,1);
imshow(C);
subplot(2,3,2);
imshow(stego_k3,[]);title('k3');
subplot(2,3,3);
imshow(stego_k7,[]);title('k7');
subplot(2,3,4);
imshow(double(C)-stego_k3,[]);title('k3');
subplot(2,3,5);
imshow(double(C)-stego_k7,[]);title('k7');
subplot(2,3,6);
imshow(double(C)-stego_k15,[]);title('k15');
PL=sum(sum(abs((double(C)-stego_k15))))/(size(C,1)*size(C,2));
