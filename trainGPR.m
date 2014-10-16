function model = trainGPR(X, y1, wrap_flag, cos_sin_flag, optimization_solver)

tic;

% if use wrap for pose representation
if wrap_flag==1
    % convert to column vector for dewrap
    y2=dewrap(y1');
    % convert back to row vector for GPLVM
    y2=y2';
else
    y2=y1;
end

% if use (cos, sin) for regresion
if cos_sin_flag==1
    y3=zeros(size(y2,1),size(y2,2)*2);
    for i=1:size(y2,2)
        y3(:,2*i-1)=cos(y2(:,i)*pi/180);
        y3(:,2*i)=sin(y2(:,i)*pi/180);
    end
    y=y3;
else
    y=y2;
end 

% Set up model
if optimization_solver==1
    options = gpOptions('dtc');
    options.numActive = 100;
elseif optimization_solver==2
    % optimization 2, fast
    options = gpOptions('fitc');
    options.numActive = 100;
    options.optimiser = 'conjgrad';
elseif optimization_solver==3
    % optimization 3
    options = gpOptions('pitc');
    options.numActive = 100;
else
    fprintf(1,'unknown solver\n');
%     break;
end

% use the deterministic training conditional.
q = size(X, 2);
d = size(y, 2);

% Training

model = gpCreate(q, d, X, y, options);
% Optimise the model.
iters = 5;
display = 1;

fprintf(1,'Training GP model with %d iterations...\n', iters);
model = gpOptimise(model, display, iters);

t2=toc;

fprintf(1,'The learning task takes %f seconds\n', t2);


end