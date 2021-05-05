@echo off
set /p id="Enter levels you want, spaced apart, without the .room.gmx extension: "
python3 ./listUnreferencedSelective.py "../*.project.gmx" --generate-lightweight %id%