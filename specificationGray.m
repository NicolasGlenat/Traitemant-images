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
## @deftypefn {} {@var{retval} =} specificationGray (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: kirby <kirby@LAPTOP-CEU752M7>
## Created: 2022-03-04

function retval = specificationGray (I1, I2)

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
  cumhist2 = cumsum(hist2) / numel(I2);
  
  LUTSpe = zeros(256,1);
  for i = 1 : 256
    differences = abs(cumhist1(i)-cumhist2);
    [~,indexe] = min(differences);
    LUTSpe(i) = indexe-1;
  endfor
  
  nouvelleImage = LUTSpe(double(I1)+1);
  cumhistNouvelle = cumsum(imhist(rescale(nouvelleImage))) / numel(nouvelleImage);
  
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
  subplot(3,3,9);
  bar(cumhistNouvelle);

