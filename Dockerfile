from ubuntu:latest
RUN apt-get update -y && apt-get upgrade -y && apt-get install git -y && apt-get install python3-pip -y && apt-get install vim -y
RUN mkdir -p tools
WORKDIR tools
RUN git clone https://github.com/wireghoul/graudit
RUN mkdir -p /scan
WORKDIR /scan
RUN python3 -m pip install semgrep
RUN echo "sg(){\n\
semgrep --config=r/\$1 repos/ --severity WARNING -o results/semgrepOutput.json --json\n\
}" >> ~/.bashrc
RUN ln -s /tools/graudit/graudit /bin/graudit
RUN echo "export GRDIR=/tools/graudit/signatures" >> ~/.bashrc
RUN echo "export RES=/scan/results" >> ~/.bashrc
