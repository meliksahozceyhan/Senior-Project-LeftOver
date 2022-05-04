import { classToPlain, Exclude, instanceToPlain } from 'class-transformer'
import { IsNotEmpty, Length } from 'class-validator'
import { Item } from 'src/model/item/entity/item.entity'
import { Notification } from 'src/model/notification/entity/notification.entity'
import { Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm'

@Entity()
export class User {
	@PrimaryGeneratedColumn('uuid')
	id: string

	@CreateDateColumn()
	createdAt: Date

	@UpdateDateColumn()
	updatedAt: Date

	@IsNotEmpty()
	@Length(1, 64)
	@Column({ length: 128, nullable: false, unique: true })
	email: String

	@IsNotEmpty()
	@Column({ nullable: false })
	fullName: String

	@IsNotEmpty()
	@Exclude()
	@Column({ nullable: false })
	password: String

	@IsNotEmpty()
	@Column({ nullable: false })
	dateOfBirth: Date

	@IsNotEmpty()
	@Column({ nullable: false })
	city: String

	@IsNotEmpty()
	@Column({ nullable: false })
	address: String

	@OneToMany(() => Item, (item) => item.user)
	items: Item[]

	toJSON() {
		return instanceToPlain(this)
	}
}
