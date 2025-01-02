# r36s-fs-tester
Love2D filesystem tester for R36S running ArkOS Community Build

# Initial issue discovered
.love bundles can read but not write files in R36S - 1 Jan 2025

# Workaround tested

- 2 Jan 2025
force creation of game directory using os.execute
and then use LUA I/O to write files
LOVE FS can still be used to read files

- 1 Jan 2025
use LUA I/O instead of love2d filesystem functions
