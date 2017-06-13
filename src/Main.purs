module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Parse as P

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log (show (P.string "x" (P.ParseState { inp: "x", out: "x"})))
