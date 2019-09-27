Given a funny file

```text file:meow
41 42 43 45
```

If I run a command

```bash command
bundle exec bsm meow
```

I should get in my stdout this

```text expected stdout
ABCD
```

```regex expected stdout
[A-Z]{4}
```

```text expected exitcode
1
```

```bash command
bundle exec bsm meow
```

I should get in my stdout this

```text expected stdout
ABCD
```


