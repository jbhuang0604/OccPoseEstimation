function gp_output = testGPR(model, XTest, cos_sin_flag)

gp_output_raw = gpOut(model, XTest);

if cos_sin_flag==1
    for i=1:size(gp_output_raw,2)/2
        gp_output(:,i)=atan2(gp_output_raw(:,2*i),gp_output_raw(:,2*i-1));
    end
else
    gp_output=gp_output_raw;
end

end