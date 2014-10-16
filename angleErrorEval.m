function [m, m_vec]= angleErrorEval(gp_output, yTest, wrap_flag)

if wrap_flag==1
    % column major
    % convert to column vector for wrap
    gp_output_dewrap=gp_output';
    % wrap use column vector
    gp_output_wrap=wrap(gp_output');
    % angle_error use column vecotr
    %gp_output_wrap=gp_output_wrap;
     yTest_wrap=yTest';   
    [m, m_vec] = angle_error(yTest_wrap, gp_output_wrap); % note angle_error use column vector
else 
    % row major
    error=yTest-gp_output;
    error_square=error.*error;
    m_vec=sqrt(mean(error_square,1));
    m=mean(m_vec);
end


end