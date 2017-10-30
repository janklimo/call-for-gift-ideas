module Wizard.Msgs exposing (..)

import Animation
import Bootstrap.Modal as Modal


type Page
    = Welcome
    | Cards
    | Sort


type Msg
    = Navigate Page
    | Like Int
    | Skip Int
    | StartAgain
    | Up Int
    | Down Int
    | FadeInFadeOut Msg
    | SwapCards Msg
    | ConfirmDeletion Int
    | ToggleModalState Modal.State
    | AnimatedDelete
      -- private messages
    | Animate Animation.Msg
    | Delete Int
