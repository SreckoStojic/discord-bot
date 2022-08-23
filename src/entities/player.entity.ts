import { Region } from '@prisma/client';

export class Player {
  private _id: string;
  private _username: string;
  private _region: Region | null | undefined;
  private _email: string | null | undefined;

  constructor(
    id: string,
    username: string,
    email?: string | null | undefined,
    region?: Region | null | undefined
  ) {
    this._id = id;
    this._username = username;
    this._email = email;
    this._region = region;
  }

  public get id(): string {
    return this._id;
  }
  public set id(value: string) {
    this._id = value;
  }
  public get username(): string {
    return this._username;
  }
  public set username(value: string) {
    this._username = value;
  }
  public get email(): string | null | undefined {
    return this._email;
  }
  public set email(value: string | null | undefined) {
    this._email = value;
  }
  public get region(): Region | null | undefined {
    return this._region;
  }
  public set region(value: Region | null | undefined) {
    this._region = value;
  }
}
