function [y1] = cascadeRainModel(x1)
%CASCADERAINMODEL neural network simulation function.
%
% Auto-generated by MATLAB, 13-Feb-2022 00:10:39.
% 
% [y1] = cascadeRainModel(x1) takes these arguments:
%   x = 5xQ matrix, input #1
% and returns:
%   y = 1xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [0;0;0;0;0];
x1_step1.gain = [0.0208333333333333;0.0202020202020202;0.00193423597678917;0.00192529842125529;0.0350877192982456];
x1_step1.ymin = -1;

% Layer 1
b1 = [2.6831454915040593434;2.6068382666764979838;1.9154943182189871909;1.2049983280138634179;-1.7133078610481291548;1.3267133893024063429;-0.8110644379171583207;0.40080550367399891964;2.4380356238639691036;1.7735266672150424849];
IW1_1 = [-0.4003432664622367243 -0.94731789744887917593 -2.9041714235467952498 0.93441777651093627099 -0.42417081882952961669;-1.3303913618915030881 0.34271618623910138357 0.81568231675828717364 1.5773214027684148153 -0.90467243423235566002;0.79059866778189447079 2.5655043723635451158 -0.53380387874373147472 -1.4105331551365212217 -0.014768080733544266397;-0.67098419058759239952 -2.3462602203844120652 0.6440432484909137667 0.83495819946500438036 0.47551786152225644644;-1.4666083711057262828 0.033518499941679928689 3.8402850430502031287 0.90259288030867190766 0.82293269092560972222;-0.86461980392718396082 -1.9046362075661320556 -0.32097673885428029683 -0.37968441326739743591 0.69276867656682517005;1.0216730961429685287 0.74506996703966366091 2.5405612539528092952 1.735613576273919989 0.48103778828236259946;-0.3146905949483161935 -1.3906223097752334894 -1.6682976366441280014 -0.95216422748021700695 2.9907099851202034735;0.61655439491091112991 1.082770709681998289 0.45378264034089316192 -1.2398194418563306396 1.6929148739587880357;0.95349692833531363156 -1.9304882203713016331 -0.36316833201274650866 -0.0044100102875111414288 -1.0230806958400373574];

% Layer 2
b2 = 0.43543415233808130393;
IW2_1 = [-0.58038946298767124521 -0.28193588585391970991 -1.8483720275789083942 -0.28218887535435294156 2.2588606420834400623];
LW2_1 = [2.1733001259005821915 0.69566597547626607412 -1.0687741517694344662 -1.1818591094266024388 -2.1593423222552585727 -1.99878452242569149 3.5396951336092610241 0.49693258958908043121 -0.33007880979290249446 0.61662707280833450874];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 0.0350877192982456;
y1_step1.xoffset = 0;

% ===== SIMULATION ========

% Dimensions
Q = size(x1,2); % samples

% Input 1
xp1 = mapminmax_apply(x1,x1_step1);

% Layer 1
a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*xp1);

% Layer 2
a2 = repmat(b2,1,Q) + IW2_1*xp1 + LW2_1*a1;

% Output 1
y1 = mapminmax_reverse(a2,y1_step1);
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
  y = bsxfun(@minus,x,settings.xoffset);
  y = bsxfun(@times,y,settings.gain);
  y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
  a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
  x = bsxfun(@minus,y,settings.ymin);
  x = bsxfun(@rdivide,x,settings.gain);
  x = bsxfun(@plus,x,settings.xoffset);
end
