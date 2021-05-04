import sys
import re
import os

usage = """
./listDescendants.py [objects...] <objects directory/>

List all object files containing descendants of the given objects
(including the objects themselves)

Applies to Game Maker Studio 1.x object files only.
"""

import sys
import re
import os

checkParent = re.compile("<parentName>([a-zA-Z_0-9]*)</parentName>")
checkFile = re.compile("([a-zA-Z_0-9]*)\.object\.gmx")

def main(base_parents, files,pdir,d=0):
	parents = set(base_parents)

	# remove any objects that don't exist
	for parent in base_parents:
		if not os.path.exists((os.path.join(pdir, parent + ".object.gmx"))):
			print("Warning. Could not find base object: " + parent, file = sys.stderr)
			parents.remove(parent)
			
	for fn in files:
		with open(fn,"r") as f:
			match = checkFile.match(os.path.basename(fn))
			if not match:
				continue
			myName = match.group(1)
			head = "".join([next(f) for x in range(15)])
			m = checkParent.search(head)
			if m:
				prt = m.group(1)
				if prt in parents:
					parents.add(myName)

	if parents == set(base_parents):
		for parent in parents:
			print((os.path.join(pdir, parent + ".object.gmx").strip()))
	else:
		# recurse
		main(parents,files,pdir,d+1)
			
	
if len(sys.argv) > 1:
	file_list = []
	pdir = sys.argv[-1]
	for fn in os.listdir(pdir):
		if os.path.isfile(os.path.join(pdir,fn)):
			file_list.append(os.path.join(pdir,fn))
	main(set(sys.argv[1:-1]),file_list,pdir)
else:
	print(usage)