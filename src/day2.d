// Yet another episode of "Insane Man Refuses to use the Language's String Functionality"
// WARNING: THIS CODE IS REALLY REALLY REALLY BAD

import std.file;
import std.math;
import std.stdio;

immutable FILE_NAME = "inputs/day2.txt";

immutable ASCII_TAB = 9;
immutable ASCII_NEWLINE = 10;
immutable ASCII_NUM_0 = 48;

// DOES NOT CHECK IF THE WHOLE THING IS A NUMBER!!!
uint ubyteAtoui(ubyte[] str)
{
    uint value = 0;

    for(size_t i = 0; i < str.length; ++i) {
        value += (str[i] - ASCII_NUM_0) * pow(10, str.length - i - 1);
    }

    return value;
}

ubyte[][] splitBy(ubyte[] buffer, ubyte sep)
{
    ubyte[][] segments;
    ubyte[] current;

    foreach(c; buffer) {
        if(c == sep) {
            if(current.length != 0) {
                segments ~= current;
            }

            current = new ubyte[0];
        }
        else {
            current ~= c;
        }
    }

    if(current.length != 0) {
        segments ~= current;
    }

    return segments;
}

int main()
{
    ubyte[] inputbuf;
    ubyte[][] lines;
    uint[][] values;

    ulong sum1, sum2;

    try {
        inputbuf = cast(ubyte[])read(FILE_NAME);
    }
    catch(Exception e) {
        stderr.writefln("Could not read file '%s'!", FILE_NAME);
        return 1;
    }

    lines = inputbuf.splitBy(ASCII_NEWLINE);

    foreach(line; lines) {
        ubyte[][] linestrs;
        uint[] linevals;

        linestrs = line.splitBy(ASCII_TAB);

        foreach(str; linestrs) {
            linevals ~= str.ubyteAtoui();
        }

        values ~= linevals;
    }

    foreach(lineval; values) {
        uint min = lineval[0], max;

        foreach(val; lineval) {
            min = val < min ? val : min;
            max = val > max ? val : max;
        }

        sum1 += (max - min);
    }

    foreach(lineval; values) {
        uint val;
        bool found = false;

        for(size_t i = 0; i < lineval.length - 1; ++i) {
            for(size_t j = i + 1; j < lineval.length; ++j) {
                uint imj, jmi;

                imj = lineval[i] % lineval[j];
                jmi = lineval[j] % lineval[i];

                if(imj == 0) {
                    sum2 += lineval[i] / lineval[j];
                    found = true;
                }
                if(jmi == 0) {
                    sum2 += lineval[j] / lineval[i];
                    found = true;
                }

                if(found) {
                    break;
                }
            }

            if(found) {
                break;
            }
        }
    }

    writeln("Part 1: ", sum1);
    writeln("Part 2: ", sum2);

    return 0;
}