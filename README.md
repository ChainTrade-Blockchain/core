<img
src="repo_header.png"
alt="ChainTrade Blockchain"
/>


## Getting started

To run the example `evmd` chain, run the script using `./local_node.sh`
from the root folder of the respository.

### Testing

All of the test scripts are found in `Makefile` in the root of the repository.
Listed below are the commands for various tests:

#### Unit Testing

```bash
make test-unit
```

#### Coverage Test

This generates a code coverage file `filtered_coverage.txt` and prints out the
covered code percentage for the working files.

```bash
make test-unit-cover
```

#### Fuzz Testing

```bash
make test-fuzz
```

#### Solidity Tests

```bash
make test-solidity
```

#### Benchmark Tests

```bash
make benchmark
```

## Open-source License & Credits

ChainTrade Blockchain is open-source under the Apache 2.0 license, an extension of the license of the original codebase (https://github.com/ChainTrade-Blockchain/core)
created by Tharsis and the evmOS team - who conducted the foundational work for EVM compatibility and
interoperability in Cosmos.
