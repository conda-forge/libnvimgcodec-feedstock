
if "%cuda_compiler_version%"=="11.8" (
    set NVIMG_CTK_ARGS= ^
        "-DCUDAToolkit_ROOT=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8" ^
        "-DCMAKE_CUDA_COMPILER=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8\bin\nvcc.exe"
    set CUDAARCHS=35-real;50-real;60-real;70-real;80-real;90
)

if "%PKG_NAME%"=="libnvimgcodec-dev" (
    cmake %CMAKE_ARGS% -GNinja %NVIMG_CTK_ARGS% test
    cmake --build .
)

