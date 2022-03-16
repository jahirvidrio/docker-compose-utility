#!/bin/sh

shopt -s nocasematch

for file in *.compose.yml; do
    if [ $file == "*.compose.yml" ]; then
        continue
    fi
    composeFiles+=($file)
done

for file in *.compose.yaml; do
    if [ $file == "*.compose.yaml" ]; then
        continue
    fi
    composeFiles+=($file)
done

echo ${composeFiles[@]}

python - << EOF
import sys, signal, yaml


composeFiles = [$(printf "'%s'," "${composeFiles[@]}")]
composeServices = {}

def signal_handler(sig, frame):
    print('\n\n[*] Cancelado\n')
    sys.exit(0)

def appendService(serviceName, composeOwnerFilename):
    if serviceName in composeServices.keys():
        print('[!!] "%s" service is defined in "%s" and "%s"' % (serviceName, composeServices[serviceName], composeOwnerFilename))
        print('[!!] Check for duplicate service names before proceeding ')
        sys.exit(1)
        return

    composeServices[serviceName] = composeOwnerFilename

signal.signal(signal.SIGINT, signal_handler)

for file in composeFiles:
    stream = open(file, 'r')
    data = yaml.load(stream, Loader=yaml.Loader)

    if "services" in data.keys() and isinstance(data["services"], dict):
        for serviceName, _ in data["services"].items():
            appendService(serviceName, file)
EOF

if [ $? -ne 0 ]; then
    exit 1
fi

for i in ${!composeFiles[@]}; do
    composeFiles[$i]="-f ${composeFiles[i]}"
done


if [ "$1" == "-y" ]; then
    echo -e "[$] docker compose ${composeFiles[@]} ${*:2}\n"
    docker compose ${composeFiles[*]} ${*:2}
    exit 0
fi

echo "[$] docker compose ${composeFiles[@]} $@"
echo -n "  > Confirm? [y/N]: "
read canProceed
echo ""

if [ "y" == $canProceed ]; then
    docker compose ${composeFiles[*]} $@
fi