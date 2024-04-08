module Main where

import Graphics.UI.Gtk
import Control.Monad.IO.Class (liftIO)
import Control.Monad (forM_)
import System.Random
import Data.List (transpose)

-- Definir el tamaño del tablero
boardSize :: Int
boardSize = 4

-- Definir el tamaño de la celda
cellSize :: Int
cellSize = 150

-- Definir el tipo de dato para el estado del juego
data GameState = GameState [[Int]]

-- Función para mover hacia arriba
moveUp :: GameState -> GameState
moveUp (GameState board) = GameState (transpose (map moveRowUp (transpose board)))

-- Función para mover una fila hacia arriba
moveRowUp :: [Int] -> [Int]
moveRowUp = undefined -- Implementa la lógica para mover una fila hacia arriba aquí

-- Función para generar un número aleatorio (2 o 4) con probabilidades
randomNumber :: IO Int
randomNumber = do
    rand <- randomRIO (0, 9 :: Int)
    return $ if rand < 8 then 2 else 4 -- Probabilidad de 80% para 2 y 20% para 4

-- Función principal
main :: IO ()
main = do
    -- Inicializar GTK
    _ <- initGUI

    -- Obtener la pantalla predeterminada
    screen <- screenGetDefault

    -- Calcular el tamaño de la ventana
    let windowWidth = boardSize * cellSize
        windowHeight = boardSize * cellSize
        windowPosX = (1920 - windowWidth) `div` 2
        windowPosY = (1080 - windowHeight) `div` 2

    -- Crear una nueva ventana
    window <- windowNew
    set window [ windowTitle := "2048 Game"
               , windowDefaultWidth := windowWidth
               , windowDefaultHeight := windowHeight
               , windowResizable := False
               ]

    -- Establecer el fondo de la ventana en blanco
    widgetModifyBg window StateNormal (Color 65535 65535 65535)

    -- Conectar la señal de "destroy" de la ventana para salir del bucle principal de GTK cuando se cierre la ventana
    _ <- window `on` deleteEvent $ liftIO mainQuit >> return False

    -- Crear un marco para el tablero
    frame <- frameNew
    set frame [ frameShadowType := ShadowIn ]

    -- Crear una tabla para el tablero
    table <- tableNew boardSize boardSize True
    set table [tableHomogeneous := True]

    -- Rellenar el tablero con etiquetas (simulando las celdas del juego)
    forM_ [0..boardSize-1] $ \row ->
        forM_ [0..boardSize-1] $ \col -> do
            label <- labelNew (Nothing :: Maybe String)
            labelSetMarkup label "<span foreground='black'>0</span>"
            -- Establecer el tamaño de la etiqueta
            widgetSetSizeRequest label cellSize cellSize
            -- Establecer el margen interno de la etiqueta
            set label [miscXalign := 0.5, miscYalign := 0.5]
            -- Agregar la etiqueta a la tabla
            tableAttachDefaults table label col (col+1) row (row+1)

    -- Agregar la tabla al marco
    containerAdd frame table

    -- Agregar el marco a la ventana
    containerAdd window frame

    -- Centrar la ventana en la pantalla
    windowMove window windowPosX windowPosY

    -- Mostrar todos los widgets
    widgetShowAll window

    -- Entrar al bucle principal de GTK
    mainGUI
    