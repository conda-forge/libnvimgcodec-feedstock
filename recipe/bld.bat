@echo on
REM Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
REM Licensed under the Apache License, Version 2.0 (the "License");

setlocal enabledelayedexpansion

mkdir build

cd build

if errorlevel 1 exit 1

if "%cuda_compiler_version%"=="11.8" (
    set NVIMG_CTK_ARGS= ^
        "-DCUDAToolkit_ROOT=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8" ^
        "-DCMAKE_CUDA_COMPILER=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8\bin\nvcc.exe" ^
        "-DNVJPEG_INCLUDE=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8\include"
    set CUDAARCHS=35;50;60;70;80;90
    set NVIMG_USE_NVJPEG=OFF
) else (
    set NVIMG_USE_NVJPEG=ON
)

set NVIMG_BUILD_ARGS= ^
    -DBUILD_DOCS:BOOL=OFF ^
    -DBUILD_SAMPLES:BOOL=OFF ^
    -DBUILD_TEST:BOOL=OFF ^
    -DCUDA_TARGET_ARCHS=%CUDAARCHS%

set NVIMG_LIBRARY_ARGS= ^
    -DBUILD_LIBRARY:BOOL=ON ^
    -DBUILD_SHARED_LIBS:BOOL=ON ^
    -DBUILD_STATIC_LIBS:BOOL=OFF ^
    -DWITH_DYNAMIC_LINK:BOOL=OFF

set NVIMG_EXT_ARGS= ^
    -DBUILD_EXTENSIONS:BOOL=ON ^
    -DBUILD_LIBJPEG_TURBO_EXT:BOOL=ON ^
    -DBUILD_LIBTIFF_EXT:BOOL=ON ^
    -DBUILD_NVBMP_EXT:BOOL=ON ^
    -DBUILD_NVJPEG_EXT:BOOL=%NVIMG_USE_NVJPEG% ^
    -DBUILD_NVJPEG2K_EXT:BOOL=ON ^
    -DBUILD_NVPNM_EXT:BOOL=ON ^
    -DBUILD_NVTIFF_EXT:BOOL=%NVIMG_USE_NVJPEG% ^
    -DBUILD_OPENCV_EXT:BOOL=ON

set NVIMG_PYTHON_ARGS= ^
    -DPython_EXECUTABLE=%PYTHON% ^
    -DBUILD_PYTHON:BOOL=OFF ^
    -DPYTHON_VERSIONS=%PY_VER% ^
    -DBUILD_WHEEL:BOOL=OFF ^
    -DNVIMGCODEC_COPY_LIBS_TO_PYTHON_DIR:BOOL=OFF ^
    -DNVIMGCODEC_BUILD_PYBIND11:BOOL=OFF ^
    -DNVIMGCODEC_BUILD_DLPACK:BOOL=OFF

cmake %CMAKE_ARGS% -GNinja -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    %NVIMG_BUILD_ARGS% %NVIMG_LIBRARY_ARGS% %NVIMG_EXT_ARGS% ^
    %NVIMG_PYTHON_ARGS% %NVIMG_CTK_ARGS% %SRC_DIR%

if errorlevel 1 exit 1

cmake --build . -v

if errorlevel 1 exit 1

cmake --install .

del %LIBRARY_PREFIX%\LICENSE.txt
del %LIBRARY_PREFIX%\Acknowledgements.txt

endlocal
