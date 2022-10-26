-- 1. Add foreign keys

alter table room 
add foreign key (id_hotel)
references hotel(id_hotel);

alter table room 
add foreign key (id_room_category)
references room_category(id_room_category);

alter table booking
add foreign key (id_client)
references client(id_client);

alter table room_in_booking
add foreign key (id_booking)
references booking(id_booking),
add foreign key (id_room)
references room(id_room);


-- 2. Выдать информацию о клиентах гостиницы “Космос”,
--    проживающих в номерах категории “Люкс” на 1 апреля 2019г.
select distinct name, phone from client
right join
	(select * from
		(select * from booking
		right join (select * from room_in_booking
		where checkin_date <= '2019.04.01' and checkout_date > '2019.04.01') as room_in_booking
		using (id_booking)) as b
	left join
		(select id_room from room
		right join (
			select * from hotel 
			where name = 'Космос') as hotel 
		using (id_hotel)) as c
	using (id_room)) as clients_in_space
using (id_client)
order by name;

-- 3. Дать список свободных номеров всех гостиниц на 22 апреля.

select id_room, id_hotel, number, price from room 
left join 
	(select * from room_in_booking
	where '2019.04.22' between checkin_date and checkout_date) as booked_room
using (id_room)
where booked_room.id_room is NULL;

-- 4. Дать количество проживающих в гостинице “Космос” на 23 мартапо каждой категории номеров

select id_room_category, count(id_room_category) as count from room
right join
	(select * from room_in_booking
	where '2019.03.23' between checkin_date and checkout_date) as booked_room
using (id_room)
right join hotel
using (id_hotel) where name = 'Космос'
group by id_room_category
order by count;

--  5.Дать список последних проживавших клиентов по всем комнатам гостиницы “Космос”,
--	  выехавшим в апреле с указанием даты выезда.

select name, checkout_date from room_in_booking 
right join (
	select id_room, max(checkout_date) as max_date from room_in_booking
	where checkout_date between '2019.04.01' and '2019.04.30'
	and id_room in (
						select id_room from room
						where id_hotel in (select id_hotel from hotel
				  							where name = 'Космос')
					)
	group by id_room) as max_checkout_date
on room_in_booking.id_room = max_checkout_date.id_room 
and room_in_booking.checkout_date = max_checkout_date.max_date
left join booking
using (id_booking)
left join client
using (id_client);


-- 6.Продлить на 2 дня дату проживания в гостинице “Космос” всем клиентам комнат категории “Бизнес”, 
--   которые заселились 10мая.

update room_in_booking
set checkout_date = checkout_date + interval '1' day * 2
where checkin_date = '2019.05.10'
and id_room in 
	(select id_room from room
	left join room_category
	using (id_room_category)
	where id_hotel in (select id_hotel from hotel
						where name = 'Космос')
	and name = 'Бизнес');
	
	
	
-- 7.Найти все "пересекающиеся" вариантыпроживания. Правильноесостояние: 
--  не может бытьзабронированодин номер на одну дату несколько раз, т.к. нельзя заселиться нескольким клиентам в один номер.
--  Записивтаблицеroom_in_bookingсid_room_in_booking= 5и2154 являются примером неправильного состояния,
--	которые необходимо найти.Результирующий кортеж выборки должен содержать информацию о двух конфликтующих номерах.


	
select * from room_in_booking as a1
inner join room_in_booking as a2
on a1.id_room = a2.id_room and a1.id_booking != a2.id_booking 
and a1.checkin_date between a2.checkin_date and a2.checkout_date - interval '1' day;
	
	
-- 8.Создатьбронирование в транзакции.

select * from booking 
where booking_date > '2020.01.01';

begin;
insert into booking(id_booking, id_client, booking_date)
values(2001, 5,'2020.05.09');
commit;
end transaction;

-- 9.Добавить необходимые индексыдля всех таблиц.


create index IX_checkout_date on room_in_booking (checkout_date desc);
create index IX_id_booking on room_in_booking (id_booking desc);
create index IX_checkin_date on room_in_booking (checkin_date asc);
	
