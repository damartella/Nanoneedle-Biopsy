
%AFTER IMPORTING THE FILES IN MATLAB, CHANGE THE STRING "section" TO YOUR FILENAME, CHECK AND CHANGE NUMBER OF POINTS AND NUMBER OF M/Z POSITIONS
%CHANGE OUTPUT FILEPATH, THEN RUN

numpoints = 5590;		%CHANGE NUMBER OF POINTS
nummz = 8279;		%CHANGE NUMBER OF M/Z

xsection_ = section{:,1};
ysection_ = section{:,2};
x_ = xsection_([2:end]);
y_ = ysection_([2:end]);

secsection = section ([2:end],[3:end]);
Msec = secsection{:,:};

mz = section{1,[3:end]};
m = zeros(numpoints*nummz,4);	%WE HAVE TO CHANGE THE NUMBER OF ROWS BEFORE RUNNING THIS COMMAND
temp=1;
temp2=1;
for i = 1:numpoints	
for k = 1:nummz
m(temp,1)=x_(i);
m(temp,2)=y_(i);
m(temp,3)=mz(k);
m(temp,4)=Msec(temp2,k);
temp=temp+1;
end
temp2=temp2+1;
end
msection=m;

dlmwrite('output_filepath\section_prec7.txt', msection, 'delimiter', '\t', 'precision', 7);
