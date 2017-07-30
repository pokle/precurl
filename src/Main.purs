module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Parse (Parser, inp, seq, optional, string, param)
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.String.Regex.Flags (ignoreCase)

keyword :: Parser
keyword = param "keyword" (unsafeRegex "^[^/]+(?=-jobs)" ignoreCase)

classification :: Parser
classification = param "classification" (unsafeRegex "^[^/]+" ignoreCase)

serp :: Parser
serp = seq [ 
  string "/",
  optional $ seq [ keyword, string "-" ],
  string "jobs",
  optional $ seq [ string "-in-", classification]
]

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log $ show $ serp $ inp "/cafe-jobs-in-accounting"
