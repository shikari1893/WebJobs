﻿// Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

using System;
using System.ComponentModel.DataAnnotations;

namespace UkrGuru.WebJobs.Data;

public partial class JobQueue : Job { }
public partial class JobHistory : Job { }

public partial class Job : Rule
{
    [Display(Name = "Id")]
    public int JobId { get; set; }

    [Display(Name = "Priority")]
    public Priorities JobPriority { get; set; } = Priorities.Normal;

    [DisplayFormat(DataFormatString = "{0:HH:mm:ss.fff}")]
    public DateTime Created { get; set; }

    [DisplayFormat(DataFormatString = "{0:HH:mm:ss.fff}")]
    public DateTime? Started { get; set; }

    [DisplayFormat(DataFormatString = "{0:HH:mm:ss.fff}")]
    public DateTime? Finished { get; set; }

    [Display(Name = "More")]
    public string? JobMore { get; set; }

    [Display(Name = "Status")]
    public JobStatus JobStatus { get; set; }
}
