#!/usr/bin/env python

import struct
from sys import argv

DEBUG_MODE = False

def debug(*args):
    if DEBUG_MODE:
        print(args)

class Point(object):
    def __init__(self, x, y, z):
        self.x = x; self.y = y; self.z = z

class VoxelMap(object):
    def __init__(self, x_dim, y_dim, z_dim):
        self.x_dim = x_dim
        self.y_dim = y_dim
        self.z_dim = z_dim

        self.map = [[[0 for k in xrange(z_dim)] \
            for j in xrange(y_dim)] for i in xrange(x_dim)]
        self.poi = [[[0 for k in xrange(z_dim)] \
            for j in xrange(y_dim)] for i in xrange(x_dim)]

    def get(self, x, y, z):
        return self.map[z][y][x]

    def set(self, x, y, z, i):
        self.map[z][y][x] = i

    def set_flag(self, x, y, z):
        self.poi[z][y][x] = 1

    def dump(self):
        print(self.poi)
        print(self.map)

def int32(buffer, offset):
    return struct.unpack("I", buffer[offset:offset+4])[0]

def build_map(buffer, flag_pos):
    if len(buffer) > 4 and buffer[0:4] != "VOX ":
        print("File is not valid .vox")
        return False

    # 1) Parse SIZE chunk to get dimensions
    size_chunk = buffer.find("SIZE")
    if size_chunk == -1:
        print("Could not find size chunk")
        return False

    x_dim = ord(buffer[size_chunk + 12 + 4 * 0])
    y_dim = ord(buffer[size_chunk + 12 + 4 * 1])
    z_dim = ord(buffer[size_chunk + 12 + 4 * 2])

    debug(x_dim, y_dim, z_dim)

    # 2) Parse XYZI chunk to get voxel data
    xyzi_chunk = buffer.find("XYZI")
    if xyzi_chunk == -1:
        print("Could not find xyzi chunk")
        return False

    voxel_count = int32(buffer, xyzi_chunk + 12)
    voxels_offset = xyzi_chunk + 12 + 4

    debug(xyzi_chunk, voxel_count)

    # 3) Build up our in-memory representation of the .vox
    map = VoxelMap(x_dim, y_dim, z_dim)
    debug("offset @ %d" % voxels_offset)
    debug("start with %d" % ord(buffer[voxels_offset]))

    k = 0
    while k < voxel_count * 4:
        x, y, z, i = buffer[voxels_offset + k], buffer[voxels_offset + k+1], \
            buffer[voxels_offset + k+2], buffer[voxels_offset + k+3]
        x, y, z, i = ord(x), ord(y), ord(z), ord(i)
        k += 4

        map.set(x, y, z, i)
        debug(map.get(x, y, z))

    map.set_flag(flag_pos.x, flag_pos.y, flag_pos.z)
    map.dump()

    return True

def main():
    def usage():
        print("%s <input .vox> x y z" % argv[0])
        exit(1)

    argc = len(argv)
    if argc != 5:
        usage()

    vox_path = argv[1]
    x, y, z = int(argv[2]), int(argv[3]), int(argv[4])
    vox_buffer = open(vox_path, "rb").read()

    if not build_map(vox_buffer, Point(x, y, z)):
        print("Failed to parse .vox file")
        exit(1)


if __name__ == "__main__":
    main()