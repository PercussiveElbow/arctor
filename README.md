# Arctor

[![Amber Framework](https://img.shields.io/badge/using-amber_framework-orange.svg)](https://amberframework.org)

### WIP DON'T USE :((((((

Arctor is a recon suite designed to provide easy to use oversight of a domain's presence on the web. To achieve this a combination of OSINT resources (Shodan, Crobat API), automated reconaissance modules written in Crystal and parsers for existing security tooling.  

## Features


## Architectural Design

This project is written in Crystal where possible for performance reasons.

The core component of this, the Arctor server is written in using the Amber framework. For those unfamilar the closest parallel to this is the Ruby on Rails framework - a MVC.

Worker agents are used to handle the recon jobs in the background. These agents pull from a Redis queue using [Mosquito](). These agents are built to be scalable manner, depending on hardware resources this should enable fast parallel recon across instances. 


## Installation


#### Manual 
This project requires [Crystal 0.36](https://crystal-lang.org/) ([installation guide](https://crystal-lang.org/docs/installation/)).

Install Crystal, Redis, Amber and Postgres.
Create a DB for Postgres


```
git clone https://github.com/PercussiveElbow/Arctor
cd arctor
shards install
amber db create && amber db migrate
crystal run src/arctor.cr # To start the server
crystal run src/arctor_worker.cr
```

#### Docker

todo: A Docker-compose alternative 




## License
MIT License

Copyright (c) 2020 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
