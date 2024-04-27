import std.file;
import std.stdio;

immutable FILE_NAME = "inputs/day1.txt";

// This is called a UFCS, for future reference (being able to call it like number.between)
bool between(T)(T n, T lb, T ub)
{
    // Might be a semi-hard bug to find, but it's *technically* not between the numbers
    if(ub < lb) {
        return false;
    }

    return n >= lb && n <= ub;
}

int main()
{
    // Input setup
    ubyte[] inputbuf;
    ubyte[] numbers;
    size_t halflen;
    ulong sum1, sum2;

    try {
        inputbuf = cast(ubyte[])read(FILE_NAME);
    }
    catch(Exception e) {
        stderr.writefln("Could not read file '%s'", FILE_NAME);
        return 1;
    }

    foreach(n; inputbuf) {
        if(n.between(48, 57)) { // Ignore this ugly mess
            numbers ~= cast(ubyte)(n - 48);
        }
    }

    halflen = numbers.length / 2;

    // The logic savings here just makes me better tbh
    for(size_t i = 1; i < numbers.length; ++i) {
        if(numbers[i] == numbers[i - 1]) {
            sum1 += numbers[i];
        }

        if(numbers[i] == numbers[(i + halflen) % numbers.length]) {
            sum2 += numbers[i];
        }
    }
    if(numbers[0] == numbers[$-1]) {
        sum1 += numbers[0];
    }
    if(numbers[0] == numbers[halflen]) {
        sum2 += numbers[0];
    }

    writeln("Part 1: ", sum1);
    writeln("Part 2: ", sum2);

    return 0;
}