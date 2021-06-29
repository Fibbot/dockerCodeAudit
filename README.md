# dockerCodeAudit
Docker makefile for a collection of static code analysis tools packaged together

## Tools included
* [semgrep](https://github.com/returntocorp/semgrep)
** If this container needs to be brought to a non-internet connected box, you'll need the rules list downloaded and brought into the container in order to specify the rules location (normally it will pull from the internet). That can be found [here](https://github.com/returntocorp/semgrep-rules)
* [graudit](https://github.com/wireghoul/graudit)
* [Ripgrep](https://github.com/BurntSushi/ripgrep)
* [OWASP Dependency Check](https://github.com/jeremylong/DependencyCheck)

## Languages covered
#### Semgrep
* Go, Java, JS, JSON, Python, Ruby, TS, JSX, TSX
* Alpha: OCaml, PHP, C, YAML
#### graudit
* actionscript, android, asp, c, cobol, dotnet, exec, fruit, go, ios, java, js, perl, php, python, nim, ruby, secrets, spsqli, sql, strings, xss
#### DependencyCheck
* Java
#### ripgrep
* Really, all... Ripgrep provides dummy fast grepping through huge codebases, I use this **every time** for source code review.

## Install
* copy install.sh
* chmod +x install.sh
* ./install.sh

or 

* git clone https://github.com/Fibbot/dockerCodeAudit.git
* mkdir -p scan/repos
* mkdir scan/results
* docker build -t staticaudit .

## Usage

Throw the source files to be scanned into the scan/repos folder

`docker run -v ${PWD}/scan:/scan --rm -i -t staticaudit bash`

This drops you into /scan, throw any results into /scan/results to keep the results around on the host.

Inside the /scan folder you can run `sg languageName` eg. `sg python` that will run semgrep with WARNING severity with all rules particular to that language on code in the /repos folder then output json results to the /results folder (how I use it most often)

Graudit is symlinked to be run with `graudit` with `$GRDIR` at the signatures folder and `$RES` for the /scan/results folder, so you could run something like `graudit -d $GRDIR/python.db repos/ >> $RES/grauditResults.txt`

DependencyCheck is symlinked with `depcheck`.

### alias/export tl;dr
* `sg`: `semgrep --config=r/\$1 repos/ --severity WARNING -o results/semgrepOutput.json --json`
* `$RES`: `/scan/results`
* `$GRDIR`: `/tools/graudit/signatures`
* `graudit`: `/bin/graudit`
* `depcheck`: /tools/dependency-check/bin/dependency-check.sh
