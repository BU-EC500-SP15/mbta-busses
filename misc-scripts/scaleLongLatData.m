%This script is used to open files with MBTA stops, edit the longitude
%and latitudes to be scaled between -50 and 50, and write the results to
%new files.

%centerPoint = {42.348570,-71.095233};
routes = [1,15,22,23,28,32,39,57,66,71,73,77,111,116,117];

%read in file for route 1
fileName = sprintf('route%d_stops.txt',1);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray1=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end

%read in file for route 15
fileName = sprintf('route%d_stops.txt',15);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray15=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end
    
    
%read in file for route 22
fileName = sprintf('route%d_stops.txt',22);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray22=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end
  
%read in file for route 23
fileName = sprintf('route%d_stops.txt',23);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray23=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end
    
%read in file for route 28
fileName = sprintf('route%d_stops.txt',28);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray28=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end
    
%read in file for route 32
fileName = sprintf('route%d_stops.txt',32);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray32=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end    

    
%read in file for route 39
fileName = sprintf('route%d_stops.txt',39);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray39=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end
    
%read in file for route 57
fileName = sprintf('route%d_stops.txt',57);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray57=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end
  
    
%read in file for route 66
fileName = sprintf('route%d_stops.txt',66);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray66=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end
    
%read in file for route 71
fileName = sprintf('route%d_stops.txt',71);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray71=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end
    
%read in file for route 73
fileName = sprintf('route%d_stops.txt',73);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray73=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end    

%read in file for route 77
fileName = sprintf('route%d_stops.txt',77);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray77=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end
    
%read in file for route 111
fileName = sprintf('route%d_stops.txt',111);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray111=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end
    
%read in file for route 116
fileName = sprintf('route%d_stops.txt',116);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray116=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end
    
%read in file for route 117
fileName = sprintf('route%d_stops.txt',117);
fid=fopen(fileName);
    if fid==-1
        disp('File open failed')
    else
       %Read in data from routeX_stops.txt
       dataArray117=textscan(fid,'%d %s %.6f %.6f %d %d %s','HeaderLines',1, 'Delimiter',',');
       %Close the file
       result=fclose(fid);
       if result~=0
           disp('File close unsuccessful')
       end
    end

% routeStopLengths1 = length(dataArray1{3});
% routeStopLengths15 = length(dataArray15{3});
% routeStopLengths22 = length(dataArray22{3});
% routeStopLengths23 = length(dataArray23{3});
% routeStopLengths28 = length(dataArray28{3});
% routeStopLengths32 = length(dataArray32{3});
% routeStopLengths39 = length(dataArray39{3});
% routeStopLengths57 = length(dataArray57{3});
% routeStopLengths66 = length(dataArray66{3});
% routeStopLengths71 = length(dataArray71{3});
% routeStopLengths73 = length(dataArray73{3});
% routeStopLengths77 = length(dataArray77{3});
% routeStopLengths111 = length(dataArray111{3});
% routeStopLengths116 = length(dataArray116{3});
% routeStopLengths117 = length(dataArray117{3});
    
routeStopLengths = zeros(1,15);

for l=1:15
    routeStopLengths(l)=eval(sprintf('length(dataArray%d{3})',routes(l)));
end

latitudes = [dataArray1{3}' dataArray15{3}' dataArray22{3}' dataArray23{3}' dataArray28{3}' dataArray32{3}' dataArray39{3}' dataArray57{3}' dataArray66{3}' dataArray71{3}' dataArray73{3}' dataArray77{3}' dataArray111{3}' dataArray116{3}' dataArray117{3}']';
longitudes = [dataArray1{4}' dataArray15{4}' dataArray22{4}' dataArray23{4}' dataArray28{4}' dataArray32{4}' dataArray39{4}' dataArray57{4}' dataArray66{4}' dataArray71{4}' dataArray73{4}' dataArray77{4}' dataArray111{4}' dataArray116{4}' dataArray117{4}']';

normalizedLat = 2*(latitudes - min(latitudes))/(max(latitudes) - min(latitudes)) - 1;
normalizedLong = 2*(longitudes - min(longitudes))/(max(longitudes) - min(longitudes)) - 1;

normalizedLat = normalizedLat * 50;
normalizedLong = normalizedLong * 50;

%dataArray1{3} = normalizedLat(1+sum(routeStopLengths(1:(p-1))):routeStopLengths(p));


%route1
dataArray1{3} = normalizedLat(1:routeStopLengths(1));
dataArray1{4} = normalizedLong(1:routeStopLengths(1));

%route15
dataArray15{3} = normalizedLat(1+sum(routeStopLengths(1)):sum(routeStopLengths(1:2)));
dataArray15{4} = normalizedLong(1+sum(routeStopLengths(1)):sum(routeStopLengths(1:2)));

%route22
dataArray22{3} = normalizedLat(1+sum(routeStopLengths(1:2)):sum(routeStopLengths(1:3)));
dataArray22{4} = normalizedLong(1+sum(routeStopLengths(1:2)):sum(routeStopLengths(1:3)));

%route23
dataArray23{3} = normalizedLat(1+sum(routeStopLengths(1:3)):sum(routeStopLengths(1:4)));
dataArray23{4} = normalizedLong(1+sum(routeStopLengths(1:3)):sum(routeStopLengths(1:4)));

%route28
dataArray28{3} = normalizedLat(1+sum(routeStopLengths(1:4)):sum(routeStopLengths(1:5)));
dataArray28{4} = normalizedLong(1+sum(routeStopLengths(1:4)):sum(routeStopLengths(1:5)));

%route32
dataArray32{3} = normalizedLat(1+sum(routeStopLengths(1:5)):sum(routeStopLengths(1:6)));
dataArray32{4} = normalizedLong(1+sum(routeStopLengths(1:5)):sum(routeStopLengths(1:6)));

%route39
dataArray39{3} = normalizedLat(1+sum(routeStopLengths(1:6)):sum(routeStopLengths(1:7)));
dataArray39{4} = normalizedLong(1+sum(routeStopLengths(1:6)):sum(routeStopLengths(1:7)));

%route57
dataArray57{3} = normalizedLat(1+sum(routeStopLengths(1:7)):sum(routeStopLengths(1:8)));
dataArray57{4} = normalizedLong(1+sum(routeStopLengths(1:7)):sum(routeStopLengths(1:8)));

%route66
dataArray66{3} = normalizedLat(1+sum(routeStopLengths(1:8)):sum(routeStopLengths(1:9)));
dataArray66{4} = normalizedLong(1+sum(routeStopLengths(1:8)):sum(routeStopLengths(1:9)));

%route71
dataArray71{3} = normalizedLat(1+sum(routeStopLengths(1:9)):sum(routeStopLengths(1:10)));
dataArray71{4} = normalizedLong(1+sum(routeStopLengths(1:9)):sum(routeStopLengths(1:10)));

%route73
dataArray73{3} = normalizedLat(1+sum(routeStopLengths(1:10)):sum(routeStopLengths(1:11)));
dataArray73{4} = normalizedLong(1+sum(routeStopLengths(1:10)):sum(routeStopLengths(1:11)));

%route77
dataArray77{3} = normalizedLat(1+sum(routeStopLengths(1:11)):sum(routeStopLengths(1:12)));
dataArray77{4} = normalizedLong(1+sum(routeStopLengths(1:11)):sum(routeStopLengths(1:12)));

%route111
dataArray111{3} = normalizedLat(1+sum(routeStopLengths(1:12)):sum(routeStopLengths(1:13)));
dataArray111{4} = normalizedLong(1+sum(routeStopLengths(1:12)):sum(routeStopLengths(1:13)));

%route116
dataArray116{3} = normalizedLat(1+sum(routeStopLengths(1:13)):sum(routeStopLengths(1:14)));
dataArray116{4} = normalizedLong(1+sum(routeStopLengths(1:13)):sum(routeStopLengths(1:14)));

%route117
dataArray117{3} = normalizedLat(1+sum(routeStopLengths(1:14)):sum(routeStopLengths(1:15)));
dataArray117{4} = normalizedLong(1+sum(routeStopLengths(1:14)):sum(routeStopLengths(1:15)));



%WRITE MODIFIED DATA BACK TO NEW FILES

for i=1:15
    
    fileStr = sprintf('route%d_stops_normalized.txt',routes(i));
    fid = fopen(fileStr,'w');
    
    for k = 1:routeStopLengths(i)
        sub1 = eval(sprintf('dataArray%d{1}(%d)',routes(i),k));
        sub2 = char(eval(sprintf('dataArray%d{2}(%d)',routes(i),k)));
        sub3 = eval(sprintf('dataArray%d{3}(%d)',routes(i),k));
        sub4 = eval(sprintf('dataArray%d{4}(%d)',routes(i),k));
        sub5 = eval(sprintf('dataArray%d{5}(%d)',routes(i),k));
        sub6 = eval(sprintf('dataArray%d{6}(%d)',routes(i),k));
        sub7 = char(eval(sprintf('dataArray%d{7}(%d)',routes(i),k)));
        
        formatStr = sprintf('%d,%s,%.6f,%.6f,%d,%d,%s\n',sub1,sub2,sub3,sub4,sub5,sub6,sub7);
        fprintf(fid,formatStr);
    end
    fclose(fid);
end






