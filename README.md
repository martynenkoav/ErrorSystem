# Прототип системы для обработки ошибок

В качестве базы данных использовалась PostgreSQL
Краткое описание файлов:
* authentificationService.cfc - сервис для авторизации и регистрации, реализует методы login/logout
* dateService.cfc - сервис, в котором реализовано нахождение текущей даты
* dbService.cfc - сервис, в котором я сохранила скрипты для создания таблиц базы данных.
* errorDescriptionService.cfc - сервис, который содержит методы для получения всех статусов (статус, срочность, критичность)
* errorHistory.cfm - файл для вывода истории ошибки
* errorsList.cfm - файл для вывода списка ошибок, в нем также реализован переход по ссылке на определенную ошибку
* errorsService.cfc - сервис, со вспомогательными функциями для вывода ошибок, получения информации об ошибках
* loginForm.cfm - файл с формой логина
* menu.cfm - меню
* newError.cfm - файл для создания новой ошибки
* newUser.cfm - файл для создания нового пользователя (регистрации)
* profile.cfm - профиль
* users.cfm - файл для вывода списка пользоватей
* userService.cfc - вспомогательный сервис для вывода информации о пользователях
