cd gpdb5-source;
make distclean
./configure --silent \
	    --prefix=$HOME/gpdb5-installation \
	    --disable-orca \
	    --disable-gpfdist
make -j 8 -s
make -s install
