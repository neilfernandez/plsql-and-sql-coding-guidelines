# ngena PL/SQL &amp; SQL Coding Guidelines

## Introduction

In 2021, Neil Fernandez of ngena forked these from Insum to comply with ngena coding standards.

In 2019, Rich Soule of Insum forked these guidelines from the Trivadis guidlines and changed most of the rules to comply with Insum coding standards and added many new guidelines. New rules were also suggested in the Trivadis Issues, and while many were adopted, some (and some we consider very important) were not.

Trivadis published their guidelines for PL/SQL &amp; SQL in 2009 in the context of the DOAG conference in Nuremberg. Since then these guidelines have been continuously extended and improved. Now they are managed as a set of markdown files. This makes the the guidelines more adaptable for individual application needs and simplifies the continous improvement.

Link                                                                 | Content
-------------------------------------------------------------------- | -------
[v1.0](https://neilfernandez.github.io/plsql-and-sql-coding-guidelines/) | Latest Release
[Snapshot](https://neilfernandez.github.io/plsql-and-sql-coding-guidelines/master/) | Current version based on the master branch, typically a snapshot version of the coming release

## Issues
Please file your bug reports, enhancement requests, questions and other support requests within [Github's issue tracker](https://help.github.com/articles/about-issues/).

* [Submit new issue](https://github.com/neilfernandez/plsql-and-sql-coding-guidelines/issues)

## How to Contribute

1. Describe your idea by [submitting an issue](https://github.com/neilfernandez/plsql-and-sql-coding-guidelines/issues)
2. [Create a branch](https://help.github.com/articles/creating-and-deleting-branches-within-your-repository/), commit and publish your changes and enhancements
3. [Create a pull request](https://help.github.com/articles/creating-a-pull-request/)

## How to Build the HTML Site

### About the HTML site and process

HTML is the primary output format. [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) is used to generate static HTML files and [Mike](https://github.com/jimporter/mike) to publish version specific variants.

### PDF format

PDF is the secondary output format. [wkhtmltopdf](https://wkhtmltopdf.org/) is used to generate the [ngena-PLSQL-and-SQL-Coding-Guidelines.pdf](https://github.com/neilfernandez/plsql-and-sql-coding-guidelines/raw/master/ngena-PLSQL-and-SQL-Coding-Guidelines.pdf)

### Build Steps

1. Install Docker in your environment
   * [Install Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/install/)
   * [Install Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/)
   * [Install Docker Server on Linux](https://docs.docker.com/install/#server)
2. [Fork this respository](https://github.com/neilfernandez/plsql-and-sql-coding-guidelines/fork)
3. For Windows users only
   * Install [Git for Windows](https://gitforwindows.org/), it provides Git command line tools, a GUI and a Bash emulator
4. Check/change the version in [mkdocs.yml](mkdocs.yml)
5. Open a terminal window in the [tools](tools) folder 
   * Build/update the PDF file
     run `./genpdf.sh`.
   * Test the HTML site locally
     run `./serve.sh` and open [http://localhost:8000](http://localhost:8000)
   * Deploy HTML site
     run `./mike.sh deploy {version here}`.
   * Set default version (HTML redirect)
     run `./mike.sh set-default {version here}`.
6. `commit` changes and `push` all branches.
   * `git commit`
   * `git push --all origin`


## License

The ngena PL/SQL & SQL Coding Guidelines are licensed under the Apache License, Version 2.0. You may obtain a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0>.
