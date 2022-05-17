Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 20:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353110AbiEQU7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 16:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353094AbiEQU7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:59:15 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE9C52E7F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:59:13 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id m6-20020a05683023a600b0060612720715so13009616ots.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5IZfdhz/4VvGttsXS64BLdybZC2nkRyX3oSeFQAvEqE=;
        b=fw5hJjp+KGPyBKgMxbOcgYXPvsf8UB9TzTy7q1B3qynre/0rHaTvPr3GzR3F3loFYV
         4eLHycI74A0UrG26lUcGCr2JzAWvIkG6qmwEPihr9HrgaHa0Q9bzkD2iSfWk436X83gK
         HjALCUQe6H+56pR4hF4+y5UjMjPePBcWkxunftiQKwezsKqe0HYrFQuJrwPV7TlM/msD
         A29WUeZxGBFn0MUmEBstcjZDlv+G0h7JpN9KmpcVTmaetzkd9+x1aW5i0F+VNqTbyi2f
         bH1EjjLtegof37NIfRaBoIrPVBCteS+tUyHJBegyhPoQH5Sh40YHExE1FIy4mQx8PKrP
         ENcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IZfdhz/4VvGttsXS64BLdybZC2nkRyX3oSeFQAvEqE=;
        b=JOCmRsOBxv66AAnm/UD1sbMCs63vWsg7AU7KdvXar4e8HBHOHsIyttQEp/bajJq++b
         CWtlVFKMKx6yzPLyg7IqTJ21qiVF6T4YY36OiOHXgN+YnSzZfwWsyTHsh3Kg1uzXHMRh
         Hjsg8a/d5+yoOUnp/4vNrc4IRqjoWvODqvMHEAQKZbsbJ2wo4XXVe/7hGSFbZ9JlGdfV
         6K0GTyfvD3Kx86TQ942tCmSIKYgHuhBPxs6CmcAvZfXkAzgLcfzkIFgvfP7X3lUXIZ44
         GDqbrAofp0FJYHDHEQj3EI5FzgA2NsP2P32SpK7W32Swrhd7F0+HPgerVneTmePuYIac
         BDCg==
X-Gm-Message-State: AOAM530KWGPy8LRw0QHMcoUioMDo+AkVIvJbTLdlFW/UcQ3aB4vvjr7p
        8OWZqh4UCCDKDNtgORVEYe4qAX9zwadf+u5qMhI=
X-Google-Smtp-Source: ABdhPJyg8WIx9Scy+M2Egp8B0zOo6dMp14vz6q9K/YKrL6H1TYLT5p6KN7sboSyPvKENA0dXMuRTkbvouCrhqPa50Xw=
X-Received: by 2002:a9d:6543:0:b0:605:e789:271e with SMTP id
 q3-20020a9d6543000000b00605e789271emr9054097otl.200.1652821152948; Tue, 17
 May 2022 13:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220517095746.7537-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20220517095746.7537-1-ruc_gongyuanjun@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 17 May 2022 16:59:01 -0400
Message-ID: <CADnq5_NxRBKeTe0QMVGD6oA2=rrksKKjSDPXyYwJ+1SPsGriHg@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd/pm: fix a potential gpu_metrics_table memory leak
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc:     Evan Quan <evan.quan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, May 17, 2022 at 9:13 AM Yuanjun Gong <ruc_gongyuanjun@163.com> wrote:
>
> From: Gong Yuanjun <ruc_gongyuanjun@163.com>
>
> gpu_metrics_table is allocated in yellow_carp_init_smc_tables() but
> not freed in yellow_carp_fini_smc_tables().
>
> Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index e2d099409123..c66c39ccf19c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -190,6 +190,9 @@ static int yellow_carp_fini_smc_tables(struct smu_context *smu)
>         kfree(smu_table->watermarks_table);
>         smu_table->watermarks_table = NULL;
>
> +       kfree(smu_table->gpu_metrics_table);
> +       smu_table->gpu_metrics_table = NULL;
> +
>         return 0;
>  }
>
> --
> 2.17.1
>
