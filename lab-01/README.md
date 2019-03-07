# Клининговая компания

## Описание предметной области
Компания предоставляет услуги по уборке помещений. Каждый вызов клиента оформляется  в  виде  заказа.  В  заказе  указывается  клиент,  работник, назначенный на уборку, дата выполнения заказа и его стоимость. Компании необходимо вести учет выполненных заказов.

## Таблицы
* **Клиент** (ФИО, адрес, телефон)
* **Заказ** (Клиент, Работник, дата, стоимость)
* **Работник** (ФИО, стаж, телефон, адрес)

## Развитие постановки задачи
В ходе работы оказалось, что на некоторые виды заказов нужно направлять несколько  работников.  Кроме  того,  компания разработала  несколько различных  видов услуг  (уборка,  мойка  окон,  химчистка  и  т.п.),  услуги характеризуются  названием,  описанием  и  стоимостью.  Теперь  в  каждом заказе,  кроме  указанных  ранее  данных,  нужно  также  указывать  вид предоставляемых услуг.

## Запросы
Для каждого работника вывести общее количество выполненных заказов и их суммарную стоимость в каждом месяце за последние полгода. Если заказ выполнялся несколькими работниками, то стоимость заказа делится между ними поровну.

## View
Вывести информацию по каждому заказу: клиент, адрес, вид работ, стоимость заказа, дата, назначенные работники (через запятую).

## Триггер
В таблице `клиент` ввести поле `Сумма заказов`, при оформлении нового заказа, увеличивать общую сумму заказов у клиента на соответствующую сумму.