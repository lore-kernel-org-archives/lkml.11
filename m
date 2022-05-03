Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3398CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 20:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiECUdQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 16:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiECUdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:33:07 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E775C32ED9
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:29:32 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id y32so32216846lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxrFWVN5VsHJB/otfl+bIpmkStn6Z3bAIZsPOXat8VI=;
        b=xotO3VRzHxwRoLrR8eTIFe1zwKAoDAmkEYfk+ywPQIbv80SbFtEsRclJWLP7tq3uE1
         ZC7eNrwyf3RhLgvYCMi8FPExIDKdK0RLM+mYveTotljlk27hQGZyAsBY/MGKRAAicES0
         GEFXLVg/OQ1Q85+d/axCM4cp4OJss7MsM7CEkWFhaNc9afqJwbPynkmviWQE2iwCN9/H
         Sy0th97QYit0850LmGrrE907UZndMLhOhsY+cH5TGkGDbDjRAm+S1R8ysPUmwxYnPRHB
         xZ6V/u+fJUxQO4VbQ54SYOV7/55MUDjCXT4PhqpB3Xq6wgnKvjKv89hjyIOdbMnRj4VX
         DhKg==
X-Gm-Message-State: AOAM5327t2PvRCldBp+PdpEsi0fdDza9M1KYsjpwxTa1ePx+vHsPJsX5
        ikYhV/R3dgLRk0fOEoP1vPJUGf5AFSuv6RAyv1c=
X-Google-Smtp-Source: ABdhPJzPENNrN4xPEOez8EviAj1u8aHC+cv8rZhQYLdkA/hXETuwFQUtk6xHFjs74JJKyw0hbR/tZAeW+twtdNHmpIk=
X-Received: by 2002:a05:6512:39d3:b0:472:4920:96d7 with SMTP id
 k19-20020a05651239d300b00472492096d7mr12715203lfu.47.1651609771069; Tue, 03
 May 2022 13:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220422162402.147958-1-adrian.hunter@intel.com> <20220422162402.147958-19-adrian.hunter@intel.com>
In-Reply-To: <20220422162402.147958-19-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 3 May 2022 13:29:20 -0700
Message-ID: <CAM9d7chPX314n6c_V+3c0HF1OKNSL3zS-s3L78oH39Ds7cSpEg@mail.gmail.com>
Subject: Re: [PATCH RFC 18/21] libperf evlist: Allow mixing per-thread and
 per-cpu mmaps
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:25 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> mmap_per_evsel() will skip events that do not match the CPU, so all CPUs
> can be iterated in any case.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
[...]
> @@ -561,9 +538,12 @@ static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
>  {
>         int nr_mmaps;
>
> +       /* One for each CPU */
>         nr_mmaps = perf_cpu_map__nr(evlist->all_cpus);
> -       if (perf_cpu_map__empty(evlist->all_cpus))
> -               nr_mmaps = perf_thread_map__nr(evlist->threads);
> +       /* One for each thread */
> +       nr_mmaps += perf_thread_map__nr(evlist->threads);
> +       /* Minus the dummy CPU or dummy thread */
> +       nr_mmaps -= 1;

I'm not sure it'd work for per-task events with default-per-cpu mode.

Thanks,
Namhyung

>
>         return nr_mmaps;
>  }
