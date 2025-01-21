# ssz_serialization
# Copyright (c) 2018-2025 Status Research & Development GmbH
# Licensed and distributed under either of
#   * MIT license (license terms in the root directory or at https://opensource.org/licenses/MIT).
#   * Apache v2 license (license terms in the root directory or at https://www.apache.org/licenses/LICENSE-2.0).
# at your option. This file may not be copied, modified, or distributed except according to those terms.

{.push raises: [].}

import ./types

type
  BatchIndexRef* = uint8
    ## Refers to an individual entry within a batch request.

  BatchRequest*[Q: static[int]] = object
    when Q > 0:
      indices*: array[Q, GeneralizedIndex]
        ## Up through `BatchIndexRef.high` entries that each contain a
        ## `GeneralizedIndex` for which the corresponding `Digest` is queried.
      loopOrder*: array[Q, BatchIndexRef]
        ## Order in which `indices` will be visited while fulfilling queries.
        ## Refers to index of indices, e.g., `indices[loopOrder[i]]` for access.
    elif Q == -1:  # Dynamic length
      indices*: seq[GeneralizedIndex]
      loopOrder*: seq[BatchIndexRef]
