# MonAI Label Container

Docker/Singularity image to run [MonAI Label](https://docs.monai.io/projects/label/en/latest/installation.html) on a Centos 6.10 kernel


If you have used this work for a publication, you must acknowledge SIH, e.g: "The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney."


# Quickstart for Artemis

Put this repo on Artemis e.g.

```
cd /project/<YOUR_PROJECT>
git clone https://github.com/Sydney-Informatics-Hub/monai-contained.git
```
Then `cd monai-contained` and modify the `run_artemis.pbs` script and launch with `qsub run_artemis.pbs`.

Otherwise here are the full instructions for getting there....


# How to recreate

## Build with docker
Check out this repo then build the Docker file.
```
sudo docker build . -t sydneyinformaticshub/monailabel
```

## Run with docker.
To run this, mounting your current host directory in the container directory, at /project, map port 8000 (the default port monai server is hosted on) and execute an interactive shell:
```
sudo docker run -it -v `pwd`:/project -p 8000:8000 --gpus all sydneyinformaticshub/monailabel /bin/bash
```

## Push to docker hub
```
sudo docker push sydneyinformaticshub/monai
```

See the repo at [https://hub.docker.com/r/sydneyinformaticshub/monai](https://hub.docker.com/r/sydneyinformaticshub/monai)


## Build with singularity
```
export SINGULARITY_CACHEDIR=`pwd`
export SINGULARITY_TMPDIR=`pwd`

singularity build monai.img docker://sydneyinformaticshub/monai
```

## Run with singularity
To run the singularity image (noting singularity mounts the current folder by default)
```
singularity run --bind /project:/project monai.img /bin/bash -c "cd "$PBS_O_WORKDIR" && monailabel start_server --app pathology/ --studies images/"
```
