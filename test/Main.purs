module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Either (Either(..))
import Precurl (ParseError(..), ParseState(..), parseState)
import Test.Flat (flat)
import Test.SERP (serp)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (RunnerEffects, run)

main :: Eff (RunnerEffects ()) Unit
main = run [consoleReporter] do
  describe "serp" do

    it "can parse a minimal /jobs path" do
      (serp $ parseState "/jobs") `shouldEqual` (Right (parseState ""))

    it "can parse a keywords path" do
      (serp $ parseState "/cafe-jobs") `shouldEqual` (Right $ ParseState {inp: "", out: ",keyword=cafe"})

    it "can parse a classification path" do
      (serp $ parseState "/jobs-in-accounting") `shouldEqual` (Right (ParseState { inp: "", out: ",classification=accounting"}))
    
  describe "flat" do
    
    it "can parse just /jobs" do
      (flat $ parseState "/jobs") `shouldEqual` (Right (parseState ""))

    it "can parse /jobs/at-company" do
      (flat $ parseState "/jobs/at-company") `shouldEqual` (Right (ParseState {inp: "", out: ",company=company"}))

    it "can parse /jobs/at-company/in-location" do
      (flat $ parseState "/jobs/at-company/in-location") `shouldEqual` (Right (ParseState {inp: "", out: ",company=company,location=location"}))

    it "but not /jobs/in-location/at-company" do
      (flat $ parseState "/jobs/in-location/at-company") `shouldEqual` (Left (ParseError "Dregs: /at-company"))