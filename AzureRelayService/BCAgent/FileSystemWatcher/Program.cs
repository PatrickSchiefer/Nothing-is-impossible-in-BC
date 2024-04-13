// See https://aka.ms/new-console-template for more information
using System.Net;
using System.Net.Http.Json;
using System.Text.Json.Nodes;

string path = "Z:\\watched";
string filename = "import.txt";

SendFileToBC(path, filename);
Console.WriteLine("Start filesystem watcher");
FileSystemWatcher watcher = new FileSystemWatcher();
watcher.Created += (s, e) =>
{
    SendFileToBC(path, filename);
};
watcher.Path = "Z:\\watched";
watcher.EnableRaisingEvents = true;

Console.WriteLine("Press any key to quit");
Console.ReadKey();

static void SendFileToBC(string path, string filename)
{
    HttpClient httpClient = new HttpClient();

    if (File.Exists(Path.Combine(path, filename)))
    {
        StreamReader streamReader = new StreamReader(new FileStream(Path.Combine(path, filename), FileMode.Open));
        string line = streamReader.ReadLine();
        while (line != null)
        {
            string[] splitLine = line.Split(";");
            foreach (string element in splitLine)
            {
                HttpRequestMessage httpRequestMessage = new HttpRequestMessage();
                httpRequestMessage.Method = HttpMethod.Post;
                httpRequestMessage.RequestUri = new Uri("https://cosmo-alpaca.westeurope.cloudapp.azure.com/f03a1ec20fd3rest/api/PatrickSchiefer/DOK/v1.0/importData");
                httpRequestMessage.Headers.Add("Authorization", "Basic UFNjaGllZmVyODM1MTpJZXJ2MzEyNQ==");
                httpRequestMessage.Content = JsonContent.Create(new { data = element });
                httpClient.Send(httpRequestMessage);
            }
            line = streamReader.ReadLine();
        }
    }
}