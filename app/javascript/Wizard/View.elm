module Wizard.View exposing (..)

-- external modules

import Html exposing (..)


-- internal modules

import Wizard.Models exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.Screens.Welcome exposing (viewWelcomeScreen)
import Wizard.Screens.Cards exposing (viewCardsScreen)
import Wizard.Screens.Sort exposing (viewSortScreen)
import Wizard.Screens.Failure exposing (viewFailureScreen)
import Wizard.Screens.Success exposing (viewSuccessScreen)


view : Model -> Html Msg
view model =
    case model.currentPage of
        Welcome ->
            viewWelcomeScreen model.recipientName

        Cards ->
            viewCardsScreen model

        Sort ->
            viewSortScreen model

        Failure ->
            viewFailureScreen model

        Success ->
            viewSuccessScreen model
