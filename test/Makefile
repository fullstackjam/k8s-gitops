.POSIX:

filter=.

default: test

test:
	gotestsum --format testname -- -timeout 120m -run "${filter}"
