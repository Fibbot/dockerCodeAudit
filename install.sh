git clone https://github.com/Fibbot/dockerCodeAudit.git
cd dockerCodeAudit
mkdir -p scan/repos
mkdir scan/results
docker build -t staticaudit .
