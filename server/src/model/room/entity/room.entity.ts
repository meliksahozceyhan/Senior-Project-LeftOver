import { User } from 'src/model/user/entity/user.entity'
import { Check, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, Unique, UpdateDateColumn } from 'typeorm'

@Entity()
@Check('"participant1_id" <> "participant2_id"')
@Unique(['participant1', 'participant2'])
export class Room {
	[x: string]: any
	@PrimaryGeneratedColumn('uuid')
	id: string

	@CreateDateColumn()
	createdAt: Date

	@UpdateDateColumn()
	updatedAt: Date

	@ManyToOne(() => User, { nullable: false, eager: true })
	@JoinColumn({ name: 'participant1_id' })
	participant1: User

	@ManyToOne(() => User, { nullable: false, eager: true })
	@JoinColumn({ name: 'participant2_id' })
	participant2: User
}
