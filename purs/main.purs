module Main where

import Control.Monad.Eff
import Debug.Trace (trace, Trace())
import Data.Array (map)
import React
import React.DOM

enterKeyCode :: Number
enterKeyCode = 13

todoHeader = mkUI spec do
  pure $ header [ idProp "header" ]
    [ h1' [ text "todos" ]
    , input
      [ idProp "new-todo"
      , ref "newField"
      , placeholder "What needs to be done?"
      , autoFocus "true"
      , onKeyDown submitNewTodo
      ] []
    ]
  where
    submitNewTodo :: forall a b. KeyboardEvent -> Eff (trace :: Trace, refs :: ReactRefs b | a) Unit
    submitNewTodo e = do
      refs <- getRefs
      -- TODO: UGLY!! guard? Control.Monad.when?
      if e.keyCode == enterKeyCode
         then trace "hi"
         else pure unit


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
    props <- getProps
    let todoItems = (\i ->
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
          ]) <$> props.items
    pure $ ul [ idProp "todo-list" ] todoItems

todoMain = mkUI spec {
    getInitialState = return { items: exampleItems }
  } do
    state <- readState
    pure $ section [ idProp "main" ]
      [ input
        [ idProp "toggle-all"
        , typeProp "checkbox"
        ] []
        , todoList { items: state.items }
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
