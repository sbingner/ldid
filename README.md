# ldid

This is simply a small update to [xerub's unofficial fork](https://github.com/xerub/ldid), originally from saurik's repo `git://git.saurik.com/ldid.git`. This has been updated to support sha256 hashing which is necessary for some iOS jailbreaks.

`ldid` macOS binariy is provided for convenience.

# Compiling

To compile from source:
```
make
```

# Troubleshooting

If you're trying to install something like [Electra jailbreak](https://github.com/coolstar/electra) from source, you'll want to:
```
cp ldid /usr/local/bin/ldid2
```
