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
	name: String

	@IsNotEmpty()
	@Column({ nullable: false })
	password: String
}
