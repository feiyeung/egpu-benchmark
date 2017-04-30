BufferBandwidth.exe --testType 0 --numBytes 2048 --numLoops 2000 --printLog --deviceId 2 > "AT_2KiB_type0_eGPU_idle.txt"
timeout 2
BufferBandwidth.exe --testType 1 --numBytes 2048 --numLoops 2000 --printLog --deviceId 2 > "AT_2KiB_type1_eGPU_idle.txt"
timeout 2
BufferBandwidth.exe --testType 2 --numBytes 2048 --numLoops 2000 --printLog --deviceId 2 > "AT_2KiB_type2_eGPU_idle.txt"
timeout 2
BufferBandwidth.exe --testType 3 --numBytes 2048 --numLoops 2000 --printLog --deviceId 2 > "AT_2KiB_type3_eGPU_idle.txt"
timeout 2


BufferBandwidth.exe --testType 0 --numBytes 2048 --numLoops 2000 --printLog --deviceId 1 > "AT_2KiB_type0_dGPU_idle.txt"
timeout 2
BufferBandwidth.exe --testType 1 --numBytes 2048 --numLoops 2000 --printLog --deviceId 1 > "AT_2KiB_type1_dGPU_idle.txt"
timeout 2
BufferBandwidth.exe --testType 2 --numBytes 2048 --numLoops 2000 --printLog --deviceId 1 > "AT_2KiB_type2_dGPU_idle.txt"
timeout 2
BufferBandwidth.exe --testType 3 --numBytes 2048 --numLoops 2000 --printLog --deviceId 1 > "AT_2KiB_type3_dGPU_idle.txt"
timeout 2


BufferBandwidth.exe --testType 0 --numBytes 2048 --numLoops 2000 --printLog --deviceId 0 > "AT_2KiB_type0_iGPU_active.txt"
timeout 2
BufferBandwidth.exe --testType 1 --numBytes 2048 --numLoops 2000 --printLog --deviceId 0 > "AT_2KiB_type1_iGPU_active.txt"
timeout 2
BufferBandwidth.exe --testType 2 --numBytes 2048 --numLoops 2000 --printLog --deviceId 0 > "AT_2KiB_type2_iGPU_active.txt"
timeout 2
BufferBandwidth.exe --testType 3 --numBytes 2048 --numLoops 2000 --printLog --deviceId 0 > "AT_2KiB_type3_iGPU_active.txt"

  