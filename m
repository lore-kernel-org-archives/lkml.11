Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F84BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 23:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386598AbiEEXNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 19:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiEEXNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:13:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1F45EDD1
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:09:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v12so7860646wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WuzBTf8IxUuweKJQOza1TIA0enmZeWJHFha+QZubdB4=;
        b=i93qJ9q/iM4LnMJIyyFhHl1ur8D7wOKV36jLih7UNleIvM4ttAbwEMHdbVLISGnI2H
         aOJ2UPet4Y9JfbNrsz/91xM0weprQcid8t6u1ZwPSQG0jOnQvGcn6OxFPsZUqbzK0dln
         aCcX666foM3TPqTvxbsWEQVOvc2188NppHrYtcnFH4ezIyveHYAb/ZZklcYoyhGR9iRp
         Nu9A3oAMcbGYIKuIUmwxIcHX8W62kWYcvd3tLqdXVzwLZiPJ4v0Lg1LBUCPQJZuNHMGo
         CbBV8GrPsLHAP1WyNLkNraJLrourc2c8Yc4bB1Y1UgUUoE8aMEZjiikHT6KGll35rvah
         mNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WuzBTf8IxUuweKJQOza1TIA0enmZeWJHFha+QZubdB4=;
        b=xHKThZLnqBGNdzY6wReRjOyzpEeI/QaPk45lYRMXby0q4ZTaiQjFvPh0pAVGfcf6fs
         2L8pA0MJOMWz24YXMSkC3I2dJUY/57RzREOVKHsDUnhmSAN/Umm5JceyFjAk5gMU3Wi+
         6n7MS6A1fnHAFwQGSyJb0SWL8d8P5/q1k1g8nqpzmXXmVCNwX2T+Q6Hr0jenl23jOtZb
         qZuePBlSRNJRGOqQ/Ux9FhAHSyGPVzpnRNTornO+rPJkPnCaFaPzbQS3r6c10rYzRbEQ
         swxa6mlHC6NywnFku17KhGuEIKD3n4xr5gUH90r0sVue2ZtsmJPNNsPryG0tzqaQD71a
         A/Qg==
X-Gm-Message-State: AOAM530yQA6MUw34Kyx7az4plAm2/Tz+UM+ARgPGY75m13AoFQBTxZIL
        ER72ZMm+GirQHvW3NxT9EDvPpiTrsNQTlow6lD9aJQ==
X-Google-Smtp-Source: ABdhPJzbFlHLp4pCPdjJF9Tu2X60IxgKB8OFK+bQpzwIqMYA+Sgq9so/CMRXKI1d3CWg9UmW5Ye65edxu6Z20LR+GWk=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr292456wri.343.1651792176013; Thu, 05
 May 2022 16:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-8-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-8-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 16:09:22 -0700
Message-ID: <CAP-5=fX9_JRqA7zEhC_jdCoXtagWmiivnx=45Lfdjghet3p2zw@mail.gmail.com>
Subject: Re: [PATCH V1 07/23] libperf evlist: Move ->idx() into mmap_per_evsel()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 9:57 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Move ->idx() into mmap_per_evsel() in preparation for adding evsel as a
> parameter.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/perf/evlist.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 6d0fa7b2f417..673c267f900e 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -474,6 +474,9 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>                          */
>                         refcount_set(&map->refcnt, 2);
>
> +                       if (ops->idx)
> +                               ops->idx(evlist, mp, idx);
> +
>                         if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
>                                 return -1;
>
> @@ -516,9 +519,6 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>                 int output = -1;
>                 int output_overwrite = -1;
>
> -               if (ops->idx)
> -                       ops->idx(evlist, mp, thread);
> -
>                 if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
>                                    &output, &output_overwrite))
>                         goto out_unmap;
> @@ -543,9 +543,6 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>                 int output = -1;
>                 int output_overwrite = -1;
>
> -               if (ops->idx)
> -                       ops->idx(evlist, mp, cpu);
> -
>                 for (thread = 0; thread < nr_threads; thread++) {
>                         if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
>                                            thread, &output, &output_overwrite))
> --
> 2.25.1
>
