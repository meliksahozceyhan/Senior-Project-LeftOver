import { IsNotEmpty } from 'class-validator'
import { Column, CreateDateColumn, Entity, Index, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm'

@Entity()
export class Map {
	@PrimaryGeneratedColumn('uuid')
	id: string

	@IsNotEmpty()
	@Column({ name: 'title', nullable: false })
	title: string

	@IsNotEmpty()
	@Column({ name: 'lat', nullable: false })
	lat: string

    @IsNotEmpty()
	@Column({ name: 'lon', nullable: false })
	lon: string
}