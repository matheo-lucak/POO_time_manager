import axios, { type AxiosInstance, type AxiosRequestConfig } from 'axios'

export default class AxiosServices
{
    private axiosClient: AxiosInstance;
// server 10.134.198.1
    constructor() {
        this.axiosClient = axios.create({
            baseURL: "http://localhost:4000/api"
            // baseURL: process.env.API_BASE_URL ?? "http://10.134.198.1:4000/api"
        });
    }

    public async get(url: string, config : AxiosRequestConfig) : Promise<any>
    {
        return await this.axiosClient.get(url, {...config, ...this.authConfig()});

    }

    public async post(url: string, body: any, config: AxiosRequestConfig) : Promise<any>
    {
        return await this.axiosClient.post(url, body, {...config, ...this.authConfig()});
    }

    public async put(url: string, body: any, config: AxiosRequestConfig) : Promise<any>
    {
        return await this.axiosClient.put(url, body, {...config, ...this.authConfig()});
    }

    public async delete(url: string, config: AxiosRequestConfig) : Promise<any>
    {
        return await this.axiosClient.delete(url, {...config, ...this.authConfig()});
    }

    private authConfig() : AxiosRequestConfig
    {
        const config: AxiosRequestConfig = {}
        const token = localStorage.getItem('token');

        if (token)
        {
            config.headers = {
                'Authorization': `Bearer ${token}`
            }
        }
        return config
    } 
}