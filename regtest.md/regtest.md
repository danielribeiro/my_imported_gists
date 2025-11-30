# How to get bitcoins for development using Regtest

Start bitcoind

    > bitcoind -regtest -datadir=./ -printtoconsole

Generate block chain

    > bitcoin-cli -regtest -datadir=./ generate 101

Check balance

    > bitcoin-cli -regtest -datadir=./ getbalance
    50.00000000

Spend some bitcoins

    > bitcoin-cli -regtest -datadir=./ getnewaddress
    mjBpxbvtBKwRVtdSZBHeGNydfBY2s6rNYp
    
    > $NEW_ADDRESS = mjBpxbvtBKwRVtdSZBHeGNydfBY2s6rNYp

    > bitcoin-cli -regtest -datadir=./ sendtoaddress $NEW_ADDRESS 10

Confirm transaction

    > bitcoin-cli -regtest -datadir=./ listunspent 0

## References

[bitcoin.org](https://bitcoin.org/en/developer-examples#regtest-mode)
