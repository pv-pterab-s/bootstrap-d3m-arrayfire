# Bootstrap Arrayfire D3M Dev Environment

## Amazon EC2

To get started with Arrayfire work on D3M, get a clean arch linux AMI
instance running on Amazon. Copy this repository to the image.

Run `./setup-host.sh` on the instance. This will pull all D3M
repositories to the home directory. Docker will be installed and will
run the canonical D3M baseball example. A successful run verifies host
setup.

Arrayfire is installed on the `arrayfire:0.1` container on Gallagher's
Amazon ECR. Pull the image by logging in and invoking docker:

    ./get-arrayfire-docker.sh

The script is the equivalent to the form:

    ./login_docker.sh
    sudo docker pull 074785606929.dkr.ecr.us-east-1.amazonaws.com/arrayfire:0.1

Arrayfire D3M primitives are cloned to the host filesystem at
`$HOME/d3m-arrayfire-primitives`. The `$HOME` directory is, by
convention, mounted at `/mnt/d3m` in the container.

    ./bash_docker.sh
    pip3 install -e /mnt/d3m/d3m-arrayfire-primitives

Test the installation from inside the docker container (from prompt
initiated by the `bash_docker.sh` invocation, above):

    /mnt/d3m/gdp-docs/af-example.sh -it



## Belle

0. pick directory (should be clean) to work in --> $D3M_DIR <--
    export D3M_DIR=$HOME
       ..e.g. export D3M_HOME=~/my-d3m

1. setup host-side dirs with attached my-d3m-dir-setup.sh

2. prove d3m is working with (attached) ./d3m-example.sh

THIS IS WHERE docker -it .. pip3 install -e /mnt/d3m-arrayfire-primitives needed
  ... i suppose cannot run from a clean checkout...
  ... i'll fix it later, but we can start from here i suppose...

3. prove arrayfire is working with (attached) ./af-example.sh

4. on success, both should end with a line matching /^F1_MACRO/



## TODO

Finish Arrayfire docker by integrating the Arrayfire primitives
package into the base D3M at canonical paths. Emulate the installation
of d3m's official primitives. _This will not work at the moment
because d3m-arrayfire-primitives are not packaged as a pip_.
