﻿// Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

using UkrGuru.SqlJson;
using UkrGuru.WebJobs.Data;

namespace UkrGuru.WebJobs.Actions;

public class ProcItemsAction : BaseAction
{
    public override async Task<bool> ExecuteAsync(CancellationToken cancellationToken = default)
    {
        var fileId = More.GetValue("fileId").ThrowIfBlank("fileId");

        var itemNo = More.GetValue("itemNo", (int?)null);

        var proc = More.GetValue("proc").ThrowIfBlank("proc");

        var timeout = More.GetValue("timeout", (int?)null);
        
        int i = itemNo ?? 0;
        while (1 == 1)
        {
            int? result = 0; 

            var more = await DbHelper.FromProcAsync<string?>("WJbItems_Get_More", 
                new { FileId = fileId, ItemNo = i }, cancellationToken: cancellationToken);

            if (more == null) break;

            try
            {
                result = await DbHelper.FromProcAsync<int?>($"WJb_{proc}", 
                    more, timeout, cancellationToken: cancellationToken);
            }
            catch(Exception ex)
            {
                await LogHelper.LogErrorAsync(nameof(ProcItemsAction), 
                    new { jobId = JobId, fileId, itemNo = i, proc, errMsg = ex.Message }, cancellationToken);
            }
            finally
            {
                _ = await DbHelper.ExecProcAsync("WJbItems_Set_Result", 
                    new { FileId = fileId, ItemNo = i, Result = result }, timeout, cancellationToken: cancellationToken);
            }

            if (itemNo != null) break; else i++;
        }

        await LogHelper.LogInformationAsync(nameof(ProcItemsAction), 
            new { jobId = JobId, result = "OK", count = itemNo > 0 ? 1 : i + 1 }, cancellationToken);

        return true;
    }
}