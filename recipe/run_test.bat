if "%PKG_NAME%"=="libnvimgcodec-dev" (
    cmake %CMAKE_ARGS% -GNinja %NVIMG_CTK_ARGS% test
    cmake --build .
)

