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
## @deftypefn {} {@var{retval} =} SpecificationColorDeux (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: kirby <kirby@LAPTOP-CEU752M7>
## Created: 2022-03-04

function retval = SpecificationColorDeux (I1, I2)

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
  cumhist2R = cumsum(hist2R) / numel(I2);
  cumhist2G = cumsum(hist2G) / numel(I2);
  cumhist2B = cumsum(hist2B) / numel(I2);
  
  LUTSpeR = zeros(256,1);
  LUTSpeG = zeros(256,1);
  LUTSpeB = zeros(256,1);
  for i = 1 : 256
    differencesRouge = abs(cumhist1R(i)-cumhist2R);
    [~,indexeR] = min(differencesRouge);
    LUTSpeR(i) = indexeR-1;
    
    differencesVert = abs(cumhist1G(i)-cumhist2G);
    [~,indexeG] = min(differencesVert);
    LUTSpeG(i) = indexeG-1;
    
    differencesBleu = abs(cumhist1B(i)-cumhist2B);
    [~,indexeb] = min(differencesBleu);
    LUTSpeB(i) = indexeb-1; 
  end
  
  R = LUTSpeR(double(I1(:,:,1)+1)); 
  G = LUTSpeG(double(I1(:,:,2)+1)); 
  B = LUTSpeB(double(I1(:,:,3)+1));
  
  nouvelleImage = cat(3, R, G, B);
  cumhistNouvelle = cumsum(nouvelleImage) / numel(nouvelleImage);
    
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
  imshow(rescale(nouvelleImage));
  subplot(3,4,10);
  imhist(rescale(nouvelleImage(:,:,1)));
  subplot(3,4,11);
  imhist(rescale(nouvelleImage(:,:,2)));
  subplot(3,4,12);
  imhist(rescale(nouvelleImage(:,:,3)));
