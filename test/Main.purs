module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Either (Either(..))
import Recurl.Parse (ParseState(..))
import Recurl.Demo (serp)
import Recurl.Parse (inp)
import Test.Spec (pending, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (RunnerEffects, run)

main :: Eff (RunnerEffects ()) Unit
main = run [consoleReporter] do
  describe "serp demo" do

    it "can parse a minimal /jobs path" do
      (serp $ inp "/jobs") `shouldEqual` (Right (inp ""))

    it "can parse a keywords path" do
      (serp $ inp "/cafe-jobs") `shouldEqual` (Right $ ParseState {inp: "", out: ",keyword=cafe"})

    it "can parse a classification path" do
      (serp $ inp "/jobs-in-accounting") `shouldEqual` (Right (ParseState { inp: "", out: ",classification=accounting"}))
