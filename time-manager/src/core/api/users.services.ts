import AxiosServices from "@/core/api/axios.services";
import axios from "axios";
import type {User} from "@/core/interfaces/user.interface";
import jwt_decode from "jwt-decode";

export default class UsersServices extends AxiosServices
{

    // TODO: implement promote, demote

    public async getUser(id: string) : Promise<User>
    {
        let response = await this.get(`/users/${id}`, { params: {} });
        return response.data.data;
    }

    public async getAllUser(email: string | undefined, username: string | undefined) : Promise<User>
    {
        let config : any = { params: {} };
        if (email)
        {
            config.params.email = email;
        }
        if (username)
        {
            config.params.username = username;
        }
        let response = await this.get(`/users`, config);
        return response.data.data;
    }

    public async postUser(id: number) : Promise<User>
    {
        let response = await this.post(`/users/${id}`, null, { params: {}});
        return response.data.data;
    }

    public async putUser(id: number, email: string | undefined, username: string | undefined) : Promise<User>
    {
        let body : any = { username, email };
        let response = await this.put(`/users/${id}`, body, { params: {}});
        return response.data.data;
    }

    public async deleteUser(id: number) : Promise<User>
    {
        let response = await this.delete(`/users/${id}`, { params: {}});
        return response.data.data;
    }

    public async loginUser(email: string, password: string) : Promise<User>
    {
        let body : any = { email, password };
        
        return this.post(`/auth/login`, body, { params: {}}).then(response => {

            // Set token and set id of current user in connectedAs
            localStorage.setItem('token', response.data.token);

            let decoded : any = jwt_decode(response.data.token);

            localStorage.setItem('connectedAs', decoded.user_id);

            return this.getUser(decoded.user_id);
        });
    }

    public async registerUser(email: string, username: string, password: string, password_confirmation: string) : Promise<User> {
        let config : any = { };
        let body = { email, username, password, password_confirmation }
        return this.post(`/auth/register`, body, config).then(response => {
            localStorage.setItem('token', JSON.stringify(response.data.token));

            let decoded : any = jwt_decode(response.data.token);

            return this.getUser(decoded.user_id);
        })
    }
}
