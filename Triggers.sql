----Trigger to update stock when an order is placed
create trigger trg_ConfirmStock on OrderDetail after insert as
begin update Book
	set bkStock = bkStock - (
		select odQuantity
		from inserted
		where odBookId = bkId
	)
	from Book
	join inserted on Book.bkId = inserted.odBookId
end
go

----Trigger to update stock when an ongoing order is canceled
create trigger trg_CancelOrder on OrderDetail for delete as
begin update Book
	set bkStock = bkStock + (
		select odQuantity
		from deleted 
		where odBookId = bkId
		)
	from Book
	join deleted on Book.bkId = deleted.odBookId
end
go

----Trigger to update stock after updating order quantity
create trigger trg_QuantityUpdate on OrderDetail after update as
begin update Book
	set bkStock = bkStock - 
		(select odQuantity from inserted where odBookId = bkId) +
		(select odQuantity from deleted where odBookId = bkId)
	from Book
	join deleted on Book.bkId = deleted.odBookId
end
go