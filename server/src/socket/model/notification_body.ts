import { Item } from 'src/model/item/entity/item.entity'
import { User } from 'src/model/user/entity/user.entity'

export class NotificationBody {
	from: User
	to: User
	requestedItem: Item
}
