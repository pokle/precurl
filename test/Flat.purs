--| Flat parse attempt like:
--|   https://news.ycombinator.com/item?id=15047703
--|   http://www.westpoint.edu/eecs/SiteAssets/SitePages/Faculty%20Publication%20Documents/Okasaki/jfp03flat.pdf
--|
--| Well, not exactly like that, but I'm starting with just operators
--| and I'll see where I get.

module Test.Flat where

import Prelude (($))
import Recurl (Parser,  string, param, and, optional, complete)
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.String.Regex.Flags (ignoreCase)

infixl 1 and as +

company :: Parser
company = param "company" (unsafeRegex "^[^/]+" ignoreCase)

location :: Parser
location = param "location" (unsafeRegex "^[^/]+" ignoreCase)

flat :: Parser
flat =  complete $
          string "/jobs" 
          + optional (string "/at-" + company)
          + optional (string "/in-" + location)
