import { IsNotEmpty, Length } from 'class-validator'
import { Column, CreateDateColumn, Entity, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm'

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
}
