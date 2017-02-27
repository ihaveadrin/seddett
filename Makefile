PREFIX=${HOME}

install:
	chmod +x seddett.sh
	chmod +x multiply.sh
	cp seddett.sh ${PREFIX}/bin/zsc
	cp multiply.sh ${PREFIX}/bin/zmul
	
.PHONY: install
