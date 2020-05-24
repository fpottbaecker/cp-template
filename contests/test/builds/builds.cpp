#include <iostream>
#include <algorithm>
#include <numeric>
#include <vector>
#include <string>
#include <functional>
// Not standard, so uncomment at your own peril
//#include <bits/stdc++.h>

using namespace std;

#define rep(a, b)   for(int a = 0; a < (b); ++a)
#define all(v) (v).begin(), (v).end()
#define range(a, n) (a), ((a) + (n))

template <typename cT, typename Traits>
std::basic_ostream<cT, Traits>&
nl(std::basic_ostream<cT, Traits>& out)
{
    return out << out.widen('\n');
}

int main(int argc, char** argv) {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.precision(10);

    string op;
    cin >> op;

    if (op == "finish") {
        cout << 0 << nl;
        cout << 0 << nl;
    } else if (op == "error") {
        return 1;
    } else if (op == "fault") {
        vector<char> cs(100, 'a');
        for (unsigned int i = 0; i <= 100; ++i) {
            cout << cs.at(i) << nl;
        }
    } else if (op == "infinity") {
        for (int i = 0; i < 4'000'000'000; ++i) {
            cout << 0 << nl;
        }
    }

    return 0;
}
