#!/bin/fish

for file in *
  if test $file != 'script.fish'
    echo $file
    rm ~/flash/Внутренний\ общий\ накопитель/DCIM/Camera/$file
    echo $file
  end
end





