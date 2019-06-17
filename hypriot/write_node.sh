# get img path
IMGPATH="$1"
# get number of pi (format: 00)
NUMBER="$2"
LEADING_ZERO=$(printf "%02d" $NUMBER)

echo "Preparing pi$LEADING_ZERO"

# copy config
cp ./user-data_node.yaml ./user-data_tmp.yaml
echo "user-data_tmp.yaml created"

# change hostname
sed -i .bak "s/pi01/pi$NUMBER/g" user-data_tmp.yaml
echo "Hostname changed to $(sed -n /pi$LEADING_ZERO/p ./user-data_tmp.yaml)"

# change ip address
sed -i .bak "s/10.0.0.146/10.0.0.$((145+$NUMBER))/g" user-data_tmp.yaml
echo "IP changed to $(sed -n /10.0.0.$((145+$NUMBER))/p ./user-data_tmp.yaml)"

# write image with hypriot-flash
flash --userdata user-data_tmp.yaml $IMGPATH

# remove tmp file
rm user-data_tmp.*
echo "Cleaned up"