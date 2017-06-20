module Main where

import Prelude
import Parse as P
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Parse (Parser)

parser :: Parser
parser = P.string "http://" 

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log (show (parser (P.ParseState { inp: "http://blah", out: "x"})))
