module Main where

import Control.Monad.Eff
import Debug.Trace (trace)
import Data.Array (map)
import React
import React.DOM

todoHeader = mkUI spec do
  pure $ header [ idProp "header" ]
    [ h1' [ text "todos" ]
    , input
      [ idProp "new-todo"
      , placeholder "What needs to be done?"
      , autoFocus "true"
      ] []
    ]

exampleItems =
  [ { id: 0
    , todo: "Go to Paris"
    , editing: false
    , completed: true
    },
    { id: 1
    , todo: "Write PureScript TodoMVC"
    , editing: false
    , completed: false
    },
    { id: 2
    , todo: "Find the Hotel"
    , editing: true
    , completed: false
    }
  ]

todoList = mkUI spec do
  -- TODO: Write a helper for converting [(String, Bool)] -> [ClassName]
  let todoItems = flip map exampleItems (\i ->
    let checked' = if i.completed then "checked" else ""
        class' = if i.completed then "completed" else "" in
      li [ className class' ]
        [ div [ className "view" ]
          [ input
              [ className "toggle"
              , typeProp "checkbox"
              , checked checked'
              ] []
          , label' [ text i.todo ]
          ]
        , input
          [ className "edit"
          , value i.todo
          ] []
        ])
  pure $ ul [ idProp "todo-list" ] todoItems

todoMain = mkUI spec do
  pure $ section [ idProp "main" ]
    [ input
      [ idProp "toggle-all"
      , typeProp "checkbox"
      ] []
    , todoList []
    ]

todoFooter = mkUI spec do
  pure $ footer [ idProp "footer" ]
    [ span [ idProp "todo-count" ]
      [ strong' [ text "0" ]
      , text " item(s) left"
      ]
    ]

-- Only temporarily
renderUI el = mkUI spec el []

main :: Eff (dom :: React.DOM) React.UI
main = do
  renderToElementById "todoapp" $ renderUI do
    pure $ div'
      [ todoHeader []
      , todoMain []
      , todoFooter []
      ]
