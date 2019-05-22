# get img path
IMGPATH="$1"
NUMBER="$2"

echo "Preparing pi$NUMBER"

# copy config
cp ./user-data_node.yaml ./user-data_tmp.yaml
echo "user-data_tmp.yaml created"

# change hostname
sed -i .bak "s/pi01/pi$NUMBER/g" user-data_tmp.yaml
echo "Hostname changed to $(sed -n /pi$NUMBER/p ./user-data_tmp.yaml)"

# change ip address
sed -i .bak "s/10.0.0.146/10.0.0.$((145+$NUMBER))/g" user-data_tmp.yaml
echo "IP changed to $(sed -n /10.0.0.\/p ./user-data_tmp.yaml)"

flash --userdata user-data_tmp.yaml $IMGPATH

# remove tmp file
rm user-data_tmp.*
echo "Cleaned up"