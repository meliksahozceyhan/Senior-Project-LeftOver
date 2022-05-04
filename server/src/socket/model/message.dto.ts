import { Item } from 'src/model/item/entity/item.entity'
import { Room } from 'src/model/room/entity/room.entity'
import { User } from 'src/model/user/entity/user.entity'

export class MessageDTO {
	from: User
	to: Room
	content: string
	isRead: boolean
}
