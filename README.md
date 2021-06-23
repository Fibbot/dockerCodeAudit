# dockerCodeAudit
Docker makefile for a collection of static code analysis tools packaged together

## Install
* git clone https://github.com/Fibbot/dockerCodeAudit.git
* chmod +x install.sh
* ./install.sh

or 

* git clone https://github.com/Fibbot/dockerCodeAudit.git
* docker build -t staticaudit .
* mkdir -p scan/repos
* mkdir scan/results
## Usage

Throw the source files to be scanned into the scan/repos folder

`docker run -v ${PWD}/scan:/scan --rm -i -t staticaudit bash`

This drops you into /scan, throw any results into /scan/results to keep the results around on the host.

Inside the /scan folder you can run `sg languageName` eg. `sg python` that will run semgrep with WARNING severity with all rules particular to that language on code in the /repos folder then output json results to the /results folder (how I use it most often)

Graudit is symlinked to be run with `graudit` with `$GRDIR` at the signatures folder and `$RES` for the /scan/results folder, so you could run something like `graudit -d $GRDIR/python.db repos/ >> $RES/grauditResults.txt`

### alias/export tl;dr
* `sg`: `semgrep --config=r/\$1 repos/ --severity WARNING -o results/semgrepOutput.json --json`
* `$RES`: `/scan/results`
* `$GRDIR`: `/tools/graudit/signatures`
* `graudit`: `/bin/graudit`
