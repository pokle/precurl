module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

import Recurl.Parse (inp)
import Recurl.Demo (serp)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log $ show $ serp $ inp "/cafe-jobs-in-accounting"
