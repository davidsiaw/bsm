Double-quoted strings produce the bytes for each character in the string.

```bash command
echo ';"Hello!"' | bundle exec bsm
```

You should get this output

```text expected stdout
Hello!
```

You can mix strings with hex pairs and quoted characters.

```bash command
echo ';"Hi " 41 42 20 22' | bundle exec bsm
```

You should get this output

```text expected stdout
Hi AB "
```

Backslashes in double-quoted strings are literal, not escape sequences.

```bash command
printf ';"line\\n"\n' | bundle exec bsm
```

You should get this output

```text expected stdout
line\n
```
