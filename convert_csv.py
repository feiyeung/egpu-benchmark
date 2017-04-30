import re, sys, os.path, os
# find -name "CableTest*.txt" | python3 convert_csv.py
taskinfo = [
    ('2. CL copy of copyBuffer to inputBuffer', 'clEnqueueCopyBuffer', 'H2D'),
    ('5. CL copy of outputBuffer to copyBuffer', 'clEnqueueCopyBuffer', 'D2H'),
    ('1. Host mapped write to inputBuffer','clEnqueueUnmapMemObject','H2D'),
    ('4. Host mapped read of outputBuffer','clEnqueueMapBuffer','D2H'),
    ('5. Host mapped write to inputSVMBuffer','clEnqueueSVMUnmap','H2D'),
    ('8. Host mapped read of outputSVMBuffer','clEnqueueSVMMap','D2H'),
    ('1. Host CL write to inputBuffer','clEnqueueWriteBuffer','H2D'),
    ('4. Host CL read of outputBuffer','clEnqueueReadBuffer','D2H'),
    ('2. Host CL write from mappedPtr to inputBuffer','clEnqueueWriteBuffer','H2D'),
    ('5. Host CL read of outputBuffer to mappedPtr','clEnqueueReadBuffer','D2H'),
]
re_end = re.compile('^AVERAGES ')

for praw in sys.stdin:
    pin = praw.strip()
    assert os.path.exists(pin), pin
    (head, tail) = os.path.split(pin)
    (name, ext) = os.path.splitext(tail)
    pout = head + '/output/' + name + '_out.csv'
    try:
        os.makedirs(head + '/output')
    except:
        pass
    assert not(os.path.exists(pout)), pout
    results = {'H2D':[], 'D2H':[]}
    with open(pin, 'r') as fin:
        expecting = False
        for line in fin:
            line = line.strip()
            if line == '':
                expecting = False
            if re_end.match(line):
                break
            for (kw1, kw2, type) in taskinfo:
                if line.startswith(kw1):
                    expecting = (kw2, type)
            if expecting:
                hit = re.match(r'^\s*%s[^\|]*\|\s*([0-9\.]+)\s*$' % expecting[0], line)
                if hit:
                    value = hit.group(1)
                    results[expecting[1]].append(value)
                    expecting = False
                    
    assert len(results['H2D']) == len(results['D2H']), results
    with open(pout, 'w') as fout:
        fout.write('H2D,D2H\n')
        for i in range(len(results['H2D'])):
            fout.write('%s,%s\n' % (results['H2D'][i], results['D2H'][i]))
    
