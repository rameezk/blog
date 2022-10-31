#!/usr/bin/env python

if __name__ == "__main__":
    with open(".changelog-posts-counter", "r+") as f:
        counter = int(f.read())
        f.seek(0)
        counter += 1
        f.write(f"{counter}\n")
        f.truncate()
