
**Building SWI-Prolog on Repl.it**

The git repository is downloaded (cloned) using the commands,
```
git clone https://github.com/SWI-Prolog/swipl-devel.git
cd swipl-devel
git submodule update --init
```

Once the repo is complete we can build the software,
```
cd swipl-devel
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/home/runner/prolog ..
make -i
ctest -j 4
make -i install
```

**Note** This does *not* build the manual. However, the manual is available online at
[manual](https://www.swi-prolog.org/pldoc/doc_for?object=manual).