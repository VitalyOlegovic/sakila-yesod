module Handler.Test where

import Import

getTestR :: Handler Html
getTestR = do
    userList <- runDB $ selectList ([] :: [Filter User]) []
    defaultLayout $ do
        --Set the title
        let title = "Prova" :: String
        setTitle (toHtml title)
        --Set the view to use to show data to the user
        $(widgetFile "test")
