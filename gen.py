#!/usr/bin/python
import os
import re
import sys

LINE = 0
IF = 1
ENDIF = 2
IF_P = re.compile('''\{\{\{\ *if *(\w+) *}\}\}''')
ENDIF_P = re.compile('''\{\{\{\ *endif *}\}\}''')
TMPL_P = re.compile('''(.*)\.tmpl$''')

class Scanner:
    def __init__(self, lines):
        self.lines = lines
        self.idx = 0
        self.cache = None

    def scan(self):
        ret = self.peek()
        self.idx = self.idx + 1
        self.cache = None
        return ret

    def get(self, l): # pure function
        if IF_P.match(l):
            result = IF_P.match(l) # TODO: DRY
            return (IF, result.group(1))
        elif ENDIF_P.match(l):
            return (ENDIF, None)
        else:
            return (LINE, l)

    def peek(self):
        if self.idx >= len(self.lines):
            return None
        if self.cache:
            return self.cache
        self.cache = self.get(self.lines[self.idx])
        return self.cache

class Parser:
    def __init__(self, scanner, env):
        self.scanner = scanner
        self.results = []
        self.env = env


    def parse_if(self, keep):
        line = self.scanner.scan()
        assert line[0] == IF
        self.parse(line[1] == env and keep)
        line = self.scanner.scan()
        assert line[0] == ENDIF
        
    def parse(self, keep=True):
        while True:
            line = self.scanner.peek()
            if not line:
                return
            if line[0] == LINE:
                self.scanner.scan()
                if keep:
                    self.results.append(line[1])
            elif line[0] == IF:
                self.parse_if(keep)
            else:
                return
        pass


if __name__ == '__main__':
    env = sys.argv[1]
    with open(sys.argv[2], 'r') as f:
        lines = f.readlines()
    scanner = Scanner(lines)
    parser = Parser(scanner, env)
    parser.parse()
    result = ''.join(parser.results)
    outfile = TMPL_P.match(sys.argv[2]).group(1)
    with open(outfile, 'w') as of:
        of.write(result)
        # print('wrote to ' + outfile)
