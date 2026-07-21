Single-quoted characters produce the byte for that character.

```bash command
echo ";'A' 'B' 'C'" | bundle exec bsm
```

You should get this output

```text expected stdout
ABC
```

You can mix quoted characters with hex pairs.

```bash command
echo ";'A' 42 43" | bundle exec bsm
```

You should get this output

```text expected stdout
ABC
```

Single quotes can contain any character, including a quote itself.

```bash command
echo ";41 42 43 27 44 45 46 27" | bundle exec bsm
```

You should get this output

```text expected stdout
ABC'DEF'
```
