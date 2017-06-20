module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Parse as P

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log (show (P.string "http://" (P.ParseState { inp: "http://blah", out: "x"})))
