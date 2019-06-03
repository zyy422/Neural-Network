function avg=func_get_avg(in_data)
% get daily average data for 12 months,such as global horizontal irradiance,
% direct normal irradiance,diffuse irradiance, titled global irradiance,
% 5kw array titled 15 deg S
% 15kw array titled 15 deg S
% avg wind speed
% avg temperature


avg=zeros(1,365);
for i=0:364
   daily_data=in_data((288*i+1):288*(i+1)); % one day all data
   avg(1,i+1)=mean(daily_data); % get daily average GHI -> tmp
end