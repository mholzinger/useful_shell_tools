curl -s https://support-sp.apple.com/sp/product?cc=$(
  system_profiler SPHardwareDataType \
    | awk '/Serial/ {print $4}' \
    | cut -c 9-
) | sed 's|.*<configCode>\(.*\)</configCode>.*|\1|'

system_profiler SPHardwareDataType | grep "Model Identifier"

