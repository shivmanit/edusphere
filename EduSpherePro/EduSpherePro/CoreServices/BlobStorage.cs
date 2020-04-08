using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure.Storage.Auth;

namespace EduSpherePro.CoreServices
{
    public class BlobStorage : IBlobStorage
    {
        public async Task<string> SaveLearnArt(string fileName,Stream content)
        {
            var baseUri         = new Uri("https://eduspherestorage.blob.core.windows.net/");
            var containerName   = "learnart";
            var credentials     = new StorageCredentials("eduspherestorage", "9eL6GnA/W5wxEQeM5fmFKoGdVQFa6nNHx4CRarDXt4WccqZPpI3GswUIgK3Xo07r+GxSyWUPHX2Xf5rd6CGYZA==");
            var blobclient      = new CloudBlobClient(baseUri,credentials);

            var container = blobclient.GetContainerReference(containerName);
            var blob = container.GetBlockBlobReference(fileName);
            await blob.UploadFromStreamAsync(content);
            return $"{baseUri}{containerName}/{fileName}";
        }
    }
}