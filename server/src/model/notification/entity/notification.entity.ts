import { Item } from 'src/model/item/entity/item.entity'
import { User } from 'src/model/user/entity/user.entity'
import { CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm'

@Entity()
export class Notification {
	@PrimaryGeneratedColumn('uuid')
	id: string

	@CreateDateColumn()
	createdAt: Date

	@UpdateDateColumn()
	updatedAt: Date

	@ManyToOne(() => User, { nullable: false, eager: true })
	@JoinColumn({ name: 'from_user_id' })
	from: User

	@ManyToOne(() => User, { nullable: false, eager: true })
	@JoinColumn({ name: 'to_user_id' })
	to: User

	@ManyToOne(() => Item, { nullable: false, eager: true })
	@JoinColumn({ name: 'requested_item_id' })
	requestedItem: Item
}
