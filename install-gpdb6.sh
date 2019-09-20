cd gpdb6-source;
make distclean
./configure --silent \
	    --prefix=$HOME/gpdb6-installation \
	    --disable-orca \
	    --disable-gpfdist
make -j 8 -s
make -s install
