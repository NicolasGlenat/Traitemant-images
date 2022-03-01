function res = Egalisation (I1,I2)

  [m, n, can] = size(I1);  % m=nb lignes, n=nb colonnes, can=nb canaux
  [m2, n2, can2] = size(I2);  % m=nb lignes, n=nb colonnes, can=nb canaux
  if(can > 1)
      I1 = rgb2gray(I1);    % si l’image est en couleur, la transformer en NG
  end
  if(can2 > 1)
      I2 = rgb2gray(I2);    % si l’image est en couleur, la transformer en NG
  end

  
  hist1 = imhist(I1);
  hist2 = imhist(I2);
  
  cumhist1 = cumsum(hist1) / numel(I1);
  cumhist2 = cumsum(hist2)/ numel(I2);
  
  LUTSpe = zeros(256,1);
  for i = 1 : 256
    abcs1 = i;
    abcs2 = i;
    
    while cumhist2(abcs2) < cumhist1(abcs1)
      abcs2 = abcs2+1;
      if abcs2 == 256;
        abcs2 = max(LUTSpe);
        break;
      endif
    end
    
    
    
    if (abcs2-1 != 0)
     if(abs(cumhist2(abcs2-1)-cumhist1(abcs1)) < abs(cumhist2(abcs2)-cumhist1(abcs1)))
       abcs2 = abcs2-1;
     end   
    end
    
    LUTSpe(i) = abcs2; 
  endfor
  
  nouvelleImage = zeros(m,n);
  for i = 1 : m
    for j = 1 : n
      nouvelleImage(i,j) = LUTSpe(I1(i,j)+1); 
    endfor
  endfor
  
  subplot(3,3,1);
  imshow(I1);
  subplot(3,3,2);
  imhist(rescale(I1));
  subplot(3,3,3);
  bar(cumhist1);
  
  subplot(3,3,4);
  imshow(I2);
  subplot(3,3,5);
  imhist(rescale(I2));
  subplot(3,3,6);
  bar(cumhist2);
  
  subplot(3,3,7);
  imshow(nouvelleImage,[]);
  colormap(gray);
  subplot(3,3,8);
  imhist(rescale(nouvelleImage));
