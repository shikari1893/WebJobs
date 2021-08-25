﻿// Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

using System;
using System.Net;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using UkrGuru.SqlJson;
using UkrGuru.WebJobs.Data;

namespace UkrGuru.WebJobs.Actions
{
    public class Url2HtmlAction : BaseAction
    {
        public override async Task<bool> ExecuteAsync(CancellationToken cancellationToken)
        {
            var url = More.GetValue("url");
            if (string.IsNullOrEmpty(url)) throw new ArgumentNullException(nameof(url));

            var result_name = More.GetValue("result_name");
            if (string.IsNullOrEmpty(result_name)) result_name = "next_body";

            await LogHelper.LogDebugAsync("Url2HtmlAction", new { jobId = JobId, url, result_name });

            var html = string.Empty;

            using var client = new WebClient() { Encoding = Encoding.UTF8 };

            html = await client.DownloadStringTaskAsync(url);

            if (html?.Length > 200) html = await DbHelper.FromProcAsync("WJbFiles_Ins", 
                new { FileName = "body.html", FileContent = Encoding.UTF8.GetBytes(html) });

            More[result_name] = html;

            await LogHelper.LogInformationAsync("Url2HtmlAction", new { jobId = JobId, result = "OK", result_name, html });

            return true;
        }
    }
}