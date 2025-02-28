﻿// Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

namespace UkrGuru.WebJobs.Data;

public static class JobExtensions
{
    public static dynamic? CreateAction(this Job job)
    {
        ArgumentNullException.ThrowIfNull(job?.ActionType, "ActionType");

        var type = Type.GetType(job.ActionType) ?? Type.GetType($"UkrGuru.WebJobs.Actions.{job.ActionType}");
        ArgumentNullException.ThrowIfNull(type);

        dynamic? action = Activator.CreateInstance(type);

        action?.Init(job);

        return action;
    }
}
