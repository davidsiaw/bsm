Bsm caters to multiple files too. If you specify two files in order, they will be concatenated in that order.

For file1.bsm,

```text file:file1.bsm
44 45 46 47
```

And file2.bsm

```text file:file2.bsm
48 49 4A 4B
```

We can execute bsm with this command

```bash command
bundle exec bsm file1.bsm file2.bsm
```

And the result should be this:

```text expected stdout
DEFGHIJK
```
