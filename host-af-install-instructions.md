1. Install Anaconda
2. Create an Arrayfire environment (e.g. `conda create --name af`)
3. Switch to Arrayfire environment `conda activate af`
4. Install development version of Arrayfire

   pip install git+git://github.com/arrayfire/arrayfire-python.git@dev

5. Clone Arrayfire

   https://github.com/arrayfire/arrayfire-python.git@dev

6. `export LD_LIBRARY_PATH=$HOME/arrayfire/lib64:$LD_LIBRARY_PATH`
7. `export LD_PRELOAD=$HOME/anaconda3/lib/lib_mkl_core.so:$HOME/anaconda3/lib/libmkl_sequential.so`

8. Test development version of Arrayfire

   cd arrayfire-python
   python -m tests
