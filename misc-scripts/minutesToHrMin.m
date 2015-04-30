function hrMin=minutesToHrMin(minutes)
actualMin = minutes*10;
hrs = floor(actualMin/60);
mins = mod(actualMin,60);
if mins > 9
    hrMin = sprintf('%d:%d',hrs,mins);
else
    hrMin = sprintf('%d:0%d',hrs,mins);
end
end