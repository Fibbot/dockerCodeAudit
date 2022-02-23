from ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get upgrade -y && apt-get install git -y && apt-get install python3-pip -y && apt-get install vim -y && apt-get install jq -y && apt-get install unzip -y && apt-get install curl -y && apt-get install wget -y && apt-get install ripgrep && apt-get install default-jre -y
RUN mkdir -p tools
WORKDIR tools
RUN git clone https://github.com/wireghoul/graudit
RUN curl --silent "https://api.github.com/repos/jeremylong/DependencyCheck/releases/latest" | jq -r '.assets[0].browser_download_url' | wget -qi -
RUN unzip *.zip
RUN rm *.zip
RUN mkdir -p /scan
WORKDIR /scan
RUN python3 -m pip install semgrep
RUN echo "sg(){\n\
semgrep --config=r/\$1 . --severity WARNING -o /scan/results/semgrepOutput.json --json\n\
}" >> ~/.bashrc
RUN ln -s /tools/graudit/graudit /bin/graudit
RUN ln -s /tools/dependency-check/bin/dependency-check.sh /bin/depcheck
RUN echo "export GRDIR=/tools/graudit/signatures" >> ~/.bashrc
RUN echo "export RES=/scan/results" >> ~/.bashrc
