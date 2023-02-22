# Try Script

## Why Try Script
When you deploy a microservice, it need to be aware about readiness of the other microservice or backing services.
To do that you can execute Try Script with your own desired argument value to check if the service is ready or not.
There are some examples in the following.

## How to use
Download try.sh file to your computer and grant execution privilage to it as the following command.
```bash
sudo chmod +x try.sh
```
Now Try Script is ready for execution.
you can set parameters via environment variables as the following command:

```bash
export TRY_INTERVAL=10
export TRY_NUMBER= 12
export TRY_COMMAND=<Your Command>
```

or via passing arguments as the following options

### Arguments guid
- -i : Specifiy interval in seconds
- -n : Specify number of retring to executing your command
- -v : Enable verbose mode to show more information during the proccess

### Examples
```bash
./try.sh -i 5 -n <Your Command>
./try -i 5 <Your Command>
./try -i 10 -v <Your Command>
```
## How to contribute
If you are interested in this project you can help to make it better.
Feel free to fork this repository and make changes and send pull request.
I will check your commits and merge it to the main branch if it was interesting feature. 
