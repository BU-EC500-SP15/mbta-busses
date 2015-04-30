function parseTripDur(infile)
%function to parse trip duration data into separate files
%infile = 'RunTime201208.tsv';
fid = fopen(infile);
if fid==-1
    disp('File open failed');
else
    file_array = textscan(fid,'%d %s %d %d');
    result = fclose(fid);
    if result~=0
        disp('File close unsuccessful')
    end
end

keyRoutes = [1,15,22,23,28,32,39,57,66,71,73,77,111,116,117];

for i=1:length(keyRoutes)
    routeIndecies=find(file_array{1} == keyRoutes(i));
    inout=file_array{2}(routeIndecies);
    inIndex=find(strcmp(inout,'Inbound'));
    outIndex=find(strcmp(inout,'Outbound'));
    
    inHr = file_array{3}(inIndex);
    inVal = file_array{4}(inIndex);
    outHr = file_array{3}(outIndex);
    outVal = file_array{4}(outIndex);
    
    inFile = sprintf('%d-%s.tsv',keyRoutes(i),'inbound');
    outFile = sprintf('%d-%s.tsv',keyRoutes(i),'outbound');
    wifid=fopen(inFile,'w');
    wofid=fopen(outFile,'w');
    
    fprintf(wifid,'date\tclose\n');
    fprintf(wofid,'date\tclose\n');
    
    for j=1:length(inHr)
        fprintf(wifid,'%d\t%d\n',inHr(j),inVal(j));
    end
    for k=1:length(outHr)
        fprintf(wofid,'%d\t%d\n',outHr(k),outVal(k));
    end
    fclose(wifid);
    fclose(wofid);
    
end
end