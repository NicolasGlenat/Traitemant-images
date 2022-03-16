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
## @deftypefn {} {@var{retval} =} 3dPlot (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: kirby <kirby@LAPTOP-CEU752M7>
## Created: 2022-03-14

function retval = troisdPlot (rgbImage)


  % Get the dimensions of the image.  numberOfColorBands should be = 3.
  [rows columns numberOfColorBands] = size(rgbImage);
  % Display the original color image.
  figure;
  imshow(rgbImage);
  title("Original Color Image");
  % Enlarge figure to full screen.
  set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

  % Extract the individual red, green, and blue color channels.
  redChannel = rgbImage(:, :, 1);
  greenChannel = rgbImage(:, :, 2);
  blueChannel = rgbImage(:, :, 3);

  % Construct the 3D color gamut (3D histogram).
  gamut3D = zeros(256,256,256);
  for column = 1: columns
    for row = 1 : rows
      rIndex = redChannel(row, column) + 1;
      gIndex = greenChannel(row, column) + 1;
      bIndex = blueChannel(row, column) + 1;
      gamut3D(rIndex, gIndex, bIndex) = gamut3D(rIndex, gIndex, bIndex) + 1;
    end
  end

  % Get a list of non-zero colors so we can put it into scatter3()
  % so that we can visualize the colors that are present.
  r = zeros(256, 1);
  g = zeros(256, 1);
  b = zeros(256, 1);
  nonZeroPixel = 1;
  for red = 1 : 256
    for green = 1: 256
      for blue = 1: 256
        if (gamut3D(red, green, blue) > 1)
          % Record the RGB position of the color.
          r(nonZeroPixel) = red;
          g(nonZeroPixel) = green;
          b(nonZeroPixel) = blue;
          nonZeroPixel = nonZeroPixel + 1;
        end
      end
    end
  end
  figure;
  scatter3(r, g, b, 3);
  xlabel("R");
  ylabel("G");
  zlabel("B");
  msgbox("Click the rotation icon to change your point of view.");

