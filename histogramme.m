function res = histogramme (I)
[m, n, can] = size(I);  % m=nb lignes, n=nb colonnes, can=nb canaux
if(can > 1)
    I = rgb2gray(I);    % si l’image est en couleur, la transformer en NG
end
histArray=zeros(1,256);  % prealocate
for i=1:m
    for j=1:n
        histArray(1,I(i,j)+1)=histArray(1,I(i,j)+1)+1; % every time you meet the particular value, you add 1 into to corresponding bin
    end
end
