import { IsNotEmpty, Length } from 'class-validator'
import { Item } from 'src/model/item/entity/item.entity'
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
	@Column({ nullable: false })
	password: String

	@Column({ nullable: true })
	dateOfBirth: Date

	@Column({ nullable: true })
	city: String

	@Column({ nullable: true })
	address: String

	@OneToMany(() => Item, (item) => item.user)
	students: Item[]
}
