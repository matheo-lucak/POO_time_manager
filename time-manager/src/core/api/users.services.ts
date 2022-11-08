import AxiosServices from "@/core/api/axios.services";
import axios from "axios";
import type {User} from "@/core/interfaces/user.interface";
import jwt_decode from "jwt-decode";

export default class UsersServices extends AxiosServices
{
    public async getUser(userID: number) : Promise<User>
    {
        return this.get(`/users/${userID}`, { params: {} });
    }

    public async getAllUser(email: string | undefined, username: string | undefined) : Promise<User>
    {
        let config : any = {params: {        } };
        if (email)
        {
            config.params.email = email;
        }
        if (username)
        {
            config.params.username = username;
        }
        return this.get(`/users`, config)
    }

    public async postUser(userID: number) : Promise<User>
    {
        return this.post(`/users/${userID}`, null,null);
    }

    public async putUser(userID: number) : Promise<User>
    {
        return this.put(`/users/${userID}`, null, null);
    }

    public async deleteUser(userID: number) : Promise<User>
    {
        return this.delete(`/users/${userID}`, null);
    }

    public async loginUser(email: string, password: string) : Promise<User>
    {
        let body : any = { email, password };
        return this.post(`/auth/login`, body, null).then(response => {

            localStorage.setItem('token', response.data.token);

            let decoded : any = jwt_decode(response.data.token);

            console.log(decoded)
            return this.getUser(decoded.user_id);
        });
    }

    public async registerUser(email: string, username: string, password: string, password_confirmation: string) : Promise<User> {
        let config : any = { };
        let body = { email, username, password, password_confirmation }
        return this.post(`/auth/register`, body, config).then(response => {
            localStorage.setItem('token', JSON.stringify(response.data.token));

            let decoded : any = jwt_decode(response.data.token);

            console.log(decoded.userID)
            return this.getUser(decoded.userID);
        })
    }
}
