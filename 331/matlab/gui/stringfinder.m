function [ stringtext ] = stringfinder( stringid )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

fid = fopen('polymertext.txt'); %opens file

while 1
    tline = fgetl(fid); %Takes the NEXT Line and assigns it to tline
    if ischar(tline) & length(tline) > 1; %If it's not an empty space...
        tline = cellstr(tline); %transform string into a 1 x 1 cell
        if isequal(tline, stringid); %if the current line matches the desired string
            
            stringtext=fgetl(fid); %set the next line as the desired text
            break
            
        end
        
    elseif ~ischar(tline)
        % print a message that stringid wasn't found
        
        infofig = figure('position', [100, 100, 400, 300], 'color', [0.3 .9 .9]);
        
        infotext1 = uicontrol('style','text', 'fontsize', 12, 'fontweight', 'bold','horizontalalignment', 'left','backgroundcolor', [0.3 .9 .9]);
        set(infotext1, 'string', 'Error, The Heading Title has been Changed in the Main Text File and cannot be found.');
        set(infotext1, 'position', [50 150 300 100]);
        
        break
    end
end

end

