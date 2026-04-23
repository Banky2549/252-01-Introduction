# Visible Tests

The visible test script:
- builds with `make`
- runs `./bin/api_bridge_lab samples/records.txt`
- checks exact output against a static expected output block
- fails if `TODO(student)` markers still exist in source files

Hidden tests may include:
- additional malformed year fields
- edge-case slug conversions
- output format strictness
