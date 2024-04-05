# MovieApp - приложение для поиска и сохранения фильмов.

![Swift v5.9.2](https://img.shields.io/badge/swift-v5.9.2-orange.svg)
![platform iOS](https://img.shields.io/badge/platform-iOS-blue.svg)

## Экраны
|Главный|Подробная информация|Поиск в сети|Избранное|
|:-:|:-:|:-:|:-:|
|![Главный](Misc/homeScreen.gif)|![Подробная информация](Misc/detailsScreen.gif)|![Поиск](Misc/searchScreen.gif)|![Избранное](Misc/favouritesScreen.gif)|

## Инструменты
- Xcode 15.2
- UIKit
  - AutoLayout
  - CoreData
  - URLSession
  - GCD
  - WKWebView
  - SDWebImage
- Figma

## Что было реализовано:
 - Верстка с Figma макета, используя AutoLayout
 - Отправка GET запросов на [API](https://kinopoiskapiunofficial.tech/documentation/api/#/films/get_api_v2_2_films__id_) с помощью URLSession
 - Обработка и декодирование запросов в JSON, по средствам JSONDecoder
 - Отображение информации на экранах. Многопоточность и асинхронность с помощью GCD
 - Навигация между экранами по средствам NavigationController
 - Отображение видео, по средствам WKWebView
 - Сохранение информации о фильме в память, по средствам CoreData
 - Удаление информации фильмов из CoreData
 - Отображение фильмов из CoreData
