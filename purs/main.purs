module Main where

import Control.Monad.Eff
import Debug.Trace (trace)
import React
import React.DOM

helloWorld = mkUI spec do
  props <- getProps
  pure $ h1 [className "hello"] [
      text $ "Hello, " ++ props.what
    ]

main = do
  renderToElementById "todoapp" $ helloWorld {what: "Paris"}
