# Space Ranger Container

Docker/Singularity image to run [Space Ranger](https://support.10xgenomics.com/spatial-gene-expression/software/pipelines/latest/what-is-space-ranger) on Centos 6.9 kernel 


If you have used this work for a publication, you must acknowledge SIH, e.g: "The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney."


# Quickstart for Artemis

Put this repo on Artemis e.g.

```
cd /project/<YOUR_PROJECT>
git clone https://github.com/Sydney-Informatics-Hub/spaceranger-contained.git
```
Then `cd spaceranger-contained` and modify the `run_artemis.pbs` script and launch with `qsub run_artemis.pbs`.

Otherwise here are the full instructions for getting there....


# How to recreate

## Build with docker
Check out this repo then build the Docker file.
```
sudo docker build . -t sydneyinformaticshub/spaceranger:centos7
```

## Run with docker.
To run this, mounting your current host directory in the container directory, at /project, and execute a run on the test images (that live in the container) run:
```
sudo docker run -it -v `pwd`:/project sydneyinformaticshub/spaceranger:centos7 /bin/bash -c "spaceranger sitecheck > /project/sitecheck.txt"
```

## Push to docker hub
```
sudo docker push sydneyinformaticshub/spaceranger:centos7
```

See the repo at [https://hub.docker.com/r/sydneyinformaticshub/spaceranger](https://hub.docker.com/r/sydneyinformaticshub/spaceranger)


## Build with singularity
```
export SINGULARITY_CACHEDIR=`pwd`
export SINGULARITY_TMPDIR=`pwd`

singularity build spaceranger.img docker://sydneyinformaticshub/spaceranger:centos7
```

## Run with singularity
To run the singularity image (noting singularity mounts the current folder by default)
```
singularity run --bind /project:/project spaceranger.img /bin/bash -c "cd "$PBS_O_WORKDIR" && spaceranger sitecheck > sitecheck.txt"
```
