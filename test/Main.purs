module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Either (Either(..))
import Recurl.Parse (ParseState(..),parseState)
import Recurl.Demo (serp)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (RunnerEffects, run)

main :: Eff (RunnerEffects ()) Unit
main = run [consoleReporter] do
  describe "serp demo" do

    it "can parse a minimal /jobs path" do
      (serp $ parseState "/jobs") `shouldEqual` (Right (parseState ""))

    it "can parse a keywords path" do
      (serp $ parseState "/cafe-jobs") `shouldEqual` (Right $ ParseState {inp: "", out: ",keyword=cafe"})

    it "can parse a classification path" do
      (serp $ parseState "/jobs-in-accounting") `shouldEqual` (Right (ParseState { inp: "", out: ",classification=accounting"}))
