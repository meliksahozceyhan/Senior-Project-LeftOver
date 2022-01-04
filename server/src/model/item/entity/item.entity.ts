import { IsNotEmpty } from 'class-validator'
import { User } from 'src/model/user/entity/user.entity'
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm'

@Entity()
export class Item {
	@PrimaryGeneratedColumn('uuid')
	id: string

	@CreateDateColumn()
	createdAt: Date

	@UpdateDateColumn()
	updatedAt: Date

	@IsNotEmpty()
	@Column({ name: 'category', nullable: false })
	category: string

	@IsNotEmpty()
	@Column({ name: 'sub_category', nullable: false })
	subCategory: string

	@Column({ name: 'item_image', nullable: true })
	itemImage: string

	@ManyToOne(() => User, (item) => item.students, { nullable: false, eager: true })
	@JoinColumn({ name: 'user_id' })
	user: User

	@Column({ name: 'request_status', nullable: true })
	requestStatus: string

	@Column({ name: 'item_condition', nullable: true })
	itemCondition: string

	@Column({ name: 'expiration_date', nullable: true })
	expirationDate: Date
}
