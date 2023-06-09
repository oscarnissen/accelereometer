function rawSeawatchExp22 = importBuoyData(filename, dataLines)
%IMPORTFILE Import data from a text file
%  RAWSEAWATCHEXP22 = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  RAWSEAWATCHEXP22 = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  rawSeawatchExp22 = importfile("C:\Users\oscarn\Documents\Matlab filer\Akselerometer\Datafiler\Buholmen\Real Waves\Bøya\rawSeawatchExp22.txt", [3, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 16-Feb-2023 14:58:24

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [3, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 68);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ";";

% Specify column names and types
opts.VariableNames = ["Time", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38", "Var39", "Var40", "Var41", "Var42", "Var43", "Var44", "hm0", "hm0a", "hm0b", "hmax", "Var49", "Var50", "mdir", "mdira", "mdirb", "Var54", "Var55", "Var56", "Var57", "Var58", "Var59", "Var60", "tm01", "tm02", "tm02a", "tm02b", "tp", "Var66", "Var67", "Var68"];
opts.SelectedVariableNames = ["Time", "hm0", "hm0a", "hm0b", "hmax", "mdir", "mdira", "mdirb", "tm01", "tm02", "tm02a", "tm02b", "tp"];
opts.VariableTypes = ["datetime", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "double", "double", "double", "double", "string", "string", "double", "double", "double", "string", "string", "string", "string", "string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38", "Var39", "Var40", "Var41", "Var42", "Var43", "Var44", "Var49", "Var50", "Var54", "Var55", "Var56", "Var57", "Var58", "Var59", "Var60", "Var66", "Var67", "Var68"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38", "Var39", "Var40", "Var41", "Var42", "Var43", "Var44", "Var49", "Var50", "Var54", "Var55", "Var56", "Var57", "Var58", "Var59", "Var60", "Var66", "Var67", "Var68"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "Time", "InputFormat", "dd.MM.yyyy HH:mm:ss");

% Import the data
rawSeawatchExp22 = readtable(filename, opts);

end