Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8C0C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 20:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351636AbiFNUlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349615AbiFNUlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:41:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB60F4EDEA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:41:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m125-20020a1ca383000000b0039c63fe5f64so71091wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8NGtvySkiPSB+zn0JY0x0UuY41Ui727a0ykUUn2EYQ=;
        b=a/l4eCvdnakQS3KpCMyp32Xww3NIUpatJ18P3ccX7oxPe4vtciZZW/pfxTKoGM4esv
         neDFghgkurb9bKdbUYATC87VRXSFo+gxqj6MxI4RXB11BXFY83dtMZ4VJl8dKXqp/K0P
         V7HOgEprhYtSLylFL1B5iKgB7WO8j9ChWJoT6OGQVWtsvh7iSrjaVcxNbZxymS/uTHEq
         ofkfwP2twUd0MkiFGtbWS55wfhB4hjZxo36xbYYTnbuJtwcT1O5JJXDOLOzoE13ECrIe
         JHx1tJPfejv8wTLj/8zF6BbsMyXv6rVTN4XAo0f7S8weje2JTF66EvVZ3efUFLmFR8UA
         vQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8NGtvySkiPSB+zn0JY0x0UuY41Ui727a0ykUUn2EYQ=;
        b=E99hPkvl7PN3MflgQEaeDH1aZBsvH/EqXhp4kcALdS9pb1dK195mDB2zN6zyR4V1OD
         XmWXj0omCL5DqafrEtrp6FE8h58td2GS1ciD8imn1TCeD5mGHDfntCNz+6GCRjLn1CNP
         2ttqUKMYbTV8XIA1qNtUE6zP5BnZdCd8yZBfgvKZS8xdwF17SQv2qWSYgPYeY6XZnS+F
         kTXIeauO4xdpGh1UUD/9MaS0U1PspGvnL35xjy8hs/d/7loNItnQKTy+XRw8YM6el8gO
         x5azzt9KncczY9HIPOUM5HItjXFbxepZYgzqaDYq9rsmMYPROyd2CSIyerRjNaFb5hQX
         lBgQ==
X-Gm-Message-State: AOAM530jU00Sy/2zqCF/XZj7u4WZguHnVr5POC+4A4/LKQ5uapxf7do1
        ftY4NmJ4zBZwrHIAlm1HMlwk+6yxE8lCWM5yW0jwWg==
X-Google-Smtp-Source: ABdhPJz9NxbqGM6h4fim/9xoBiOe4UqSz8OL19+6SNUUG//vvbGW4DrkCH1euw3E+LrqPd5WKgTHcFSclnjjbKKWecU=
X-Received: by 2002:a7b:c7da:0:b0:39c:5b34:3019 with SMTP id
 z26-20020a7bc7da000000b0039c5b343019mr6112757wmk.115.1655239265112; Tue, 14
 Jun 2022 13:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220603055156.2830463-1-irogers@google.com> <165428101333.23591.13242354654538988127.git-patchwork-notify@kernel.org>
In-Reply-To: <165428101333.23591.13242354654538988127.git-patchwork-notify@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jun 2022 13:40:53 -0700
Message-ID: <CAP-5=fWwKkj1HtAvOXxGxcrG99gpy8v4ReW_Jh7uumbQMiJYng@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Fix is_pow_of_2
To:     andrii@kernel.org
Cc:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, netdev@vger.kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        chiyuze@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 11:30 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Thu,  2 Jun 2022 22:51:56 -0700 you wrote:
> > From: Yuze Chi <chiyuze@google.com>
> >
> > Move the correct definition from linker.c into libbpf_internal.h.
> >
> > Reported-by: Yuze Chi <chiyuze@google.com>
> > Signed-off-by: Yuze Chi <chiyuze@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > [...]
>
> Here is the summary with links:
>   - [v2] libbpf: Fix is_pow_of_2
>     https://git.kernel.org/bpf/bpf-next/c/f913ad6559e3
>
> You are awesome, thank you!

Will this patch get added to 5.19?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/bpf/libbpf.c#n4948

Thanks,
Ian

> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
