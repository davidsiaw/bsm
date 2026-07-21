Bitfield syntax lets you specify individual bits wrapped in angle brackets. Eight bits make one byte.

```bash command
echo ';<01000001> <01000010> <01000011>' | bundle exec bsm
```

You should get this output

```text expected stdout
ABC
```

Dots inside a bitfield are treated as zero bits, so you can use them as visual separators. The total must still be eight characters.

```bash command
echo ';<1.1.1.1.>' | bundle exec bsm | od -An -tx1
```

You should get this output

```text expected stdout
 aa
```
