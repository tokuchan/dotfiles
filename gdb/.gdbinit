python
import sys
#from pathlib import Path
#sys.path.insert(0, (Path.home() / '.local' / 'share' / 'gcc-13.1.0' / 'python').resolve())
sys.path.insert(0, '/home/sspillane/.local/share/gcc-13.1.0/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end
