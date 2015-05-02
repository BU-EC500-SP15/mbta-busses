function parseWaitTime(infile)
%function to parse wait time data into separate files
fid = fopen(infile);
if fid==-1
    disp('File open failed');
else
    file_array = textscan(fid,'%d %s %d %d %d');
    result = fclose(fid);
    if result~=0
        disp('File close unsuccessful')
    end
end

keyRoutes = [1,15,22,23,28,32,39,57,66,71,73,77,111,116,117];

for i=1:length(keyRoutes)
    routeIndecies=find(file_array{1} == keyRoutes(i));
    inout=file_array{2}(routeIndecies);
    
    Hrs=file_array{3}(routeIndecies);
    Val=file_array{4}(routeIndecies);
    Val2=file_array{5}(routeIndecies);
    
    inIndex=find(strcmp(inout,'Inbound'));
    outIndex=find(strcmp(inout,'Outbound'));
    
    inHr = Hrs(inIndex);
    inVal = Val(inIndex);
    inVal2 = Val2(inIndex);
    outHr = Hrs(outIndex);
    outVal = Val(outIndex);
    outVal2 = Val2(outIndex);
    
    inFile = sprintf('%d-%s.tsv',keyRoutes(i),'inbound');
    outFile = sprintf('%d-%s.tsv',keyRoutes(i),'outbound');
    wifid=fopen(inFile,'w');
    wofid=fopen(outFile,'w');
    
    fprintf(wifid,'date\tclose\tactual\n');
    fprintf(wofid,'date\tclose\tactual\n');
    
    for j=1:length(inHr)
        if(cast(inHr(j),'double') < 144)
            fprintf(wifid,'%s\t%d\t%d\n',minutesToHrMin(cast(inHr(j),'double')),inVal(j),inVal2(j));
        end
    end
    for k=1:length(outHr)
        if (cast(outHr(k),'double') < 144)
            fprintf(wofid,'%s\t%d\t%d\n',minutesToHrMin(cast(outHr(k),'double')),outVal(k),outVal2(k));
        end
    end
    fclose(wifid);
    fclose(wofid);
    
end
end