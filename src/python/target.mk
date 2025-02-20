
.PHONY: pip publish python_clean
pip : all
	echo "----------------- BUILD -------------------------"
	# Copy Build
	rm -rf src/python/code/gnoll/c_build/
	rm -rf src/python/code/gnoll/c_includes/
	rm -rf src/python/code/gnoll.egg-info/

	cp -r build/  src/python/code/gnoll/c_build/
	cp -r src/grammar/  src/python/code/gnoll/c_includes/

	cd src/python/ ; python3 -m build
	echo "------------------INSTALL------------------------"
	python3 -m pip install -vvv --user --no-index --find-links=src/python/dist/ --force-reinstall --ignore-installed gnoll
	echo "-------------------- TEST ----------------------"
	python3 -c "from gnoll import parser as dt; dt.roll('2')"

publish: test
	#twine upload --repository-url https://test.pypi.org/legacy/ src/python/dist/*
	twine upload src/python/dist/*

python_clean: 
# Python Packaging can create extraoneous files
	rm src/python/src/ | true
	rm src/python/dist/ | true
	rm src/python/build/ | true
	rm src/python/LICENSE | true
	rm src/python/Makefile | true
