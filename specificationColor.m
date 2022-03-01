## Copyright (C) 2022 kirby
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} specificationColor (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: kirby <kirby@LAPTOP-CEU752M7>
## Created: 2022-02-26

function retval = specificationColor (I1, I2)

  [m, n, can] = size(I1);  % m=nb lignes, n=nb colonnes, can=nb canaux
  [m2, n2, can2] = size(I2);  % m=nb lignes, n=nb colonnes, can=nb canaux
  
  hist1R = imhist(I1(:,:,1));
  hist1G = imhist(I1(:,:,2));
  hist1B = imhist(I1(:,:,3));
  hist2R = imhist(I2(:,:,1));
  hist2G = imhist(I2(:,:,2));
  hist2B = imhist(I2(:,:,3));
  
  cumhist1R = cumsum(hist1R) / numel(I1);
  cumhist1G = cumsum(hist1G) / numel(I1);
  cumhist1B = cumsum(hist1B) / numel(I1);
  cumhist2R = cumsum(hist2R)/ numel(I2);
  cumhist2G = cumsum(hist2G)/ numel(I2);
  cumhist2B = cumsum(hist2B)/ numel(I2);
  
  LUTSpeR = zeros(256,1);
  LUTSpeG = zeros(256,1);
  LUTSpeB = zeros(256,1);
  for i = 1 : 256
    abcs1 = i;
    abcs2R = i;
    abcs2G = i;
    abcs2B = i;
    
    while cumhist2R(abcs2R) < cumhist1R(abcs1)
      abcs2R = abcs2R+1;
      if abcs2R == 256;
        abcs2R = max(LUTSpeR);
        break;
      endif
    end
    while cumhist2G(abcs2G) < cumhist1G(abcs1)
      abcs2G = abcs2G+1;
      if abcs2G == 256;
        abcs2G = max(LUTSpeG);
        break;
      endif
    end
    while cumhist2B(abcs2R) < cumhist1B(abcs1)
      abcs2B = abcs2B+1;
      if abcs2B == 256;
        abcs2B = max(LUTSpeB);
        break;
      endif
    end
    
    
    
    if (abcs2R-1 != 0)
     if(abs(cumhist2R(abcs2R-1)-cumhist1R(abcs1)) < abs(cumhist2R(abcs2R)-cumhist1R(abcs1)))
       abcs2R = abcs2R-1;
     end   
    end
    if (abcs2G-1 != 0)
     if(abs(cumhist2G(abcs2G-1)-cumhist1G(abcs1)) < abs(cumhist2G(abcs2G)-cumhist1G(abcs1)))
       abcs2G = abcs2G-1;
     end   
    end
    if (abcs2B-1 != 0)
     if(abs(cumhist2B(abcs2B-1)-cumhist1B(abcs1)) < abs(cumhist2B(abcs2B)-cumhist1B(abcs1)))
       abcs2B = abcs2B-1;
     end   
    end
    
    LUTSpeR(i) = abcs2R; 
    LUTSpeG(i) = abcs2G; 
    LUTSpeB(i) = abcs2B; 
  endfor
  
  nouvelleImage = ones(m,n,3);
  R = I1(:,:,1);
  G = I1(:,:,2);
  B = I1(:,:,3);
  for i = 1 : m
    for j = 1 : n
      R(i,j,:) = LUTSpeR(I1(i,j,1)+1); 
      G(i,j,:) = LUTSpeG(I1(i,j,2)+1); 
      B(i,j,:) = LUTSpeB(I1(i,j,3)+1); 
    endfor
  endfor
  nouvelleImage = cat(3, R, G, B);

  
  subplot(3,4,1);
  imshow(I1);
  subplot(3,4,2);
  imhist(I1(:,:,1));
  subplot(3,4,3);
  imhist(I1(:,:,2));
  subplot(3,4,4);
  imhist(I1(:,:,3));
  
  subplot(3,4,5);
  imshow(I2);
  subplot(3,4,6);
  imhist(I2(:,:,1));
  subplot(3,4,7);
  imhist(I2(:,:,2));
  subplot(3,4,8);
  imhist(I2(:,:,3));
  
  subplot(3,4,9);
  imshow(nouvelleImage,[]);
  subplot(3,4,10);
  imhist(nouvelleImage(:,:,1));
  subplot(3,4,11);
  imhist(nouvelleImage(:,:,2));
  subplot(3,4,12);
  imhist(nouvelleImage(:,:,3));

