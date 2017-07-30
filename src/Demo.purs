module Recurl.Demo where

import Prelude

import Recurl.Parse (Parser, seq, optional, string, param)
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.String.Regex.Flags (ignoreCase)

keyword :: Parser
keyword = param "keyword" (unsafeRegex "^[^/]+(?=-jobs)" ignoreCase)

classification :: Parser
classification = param "classification" (unsafeRegex "^[^/]+" ignoreCase)

--| DEMO parser for the Search Results Page (serp)
--| of www.seek.com.au.
serp :: Parser
serp = seq [ 
  string "/",
  optional $ seq [ keyword, string "-" ],
  string "jobs",
  optional $ seq [ string "-in-", classification]
]
