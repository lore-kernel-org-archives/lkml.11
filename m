Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE173C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 20:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbiEZUrM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 16:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbiEZUqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:46:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCBC12638
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:46:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c93so1840618edf.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=N06cOpR0fhGltUp7Tz8+3ysz8vx784Cgbf5RyQDoybc=;
        b=VjpYF8OdmX+re+xHpO8tjhO+FnfUoFPPtaKdJ++8fS/6WpgR8FMaLAZrJ6nj4dBfQr
         RIVlo/nG2s5U+jFfh8wMJDPP/tTLUBTEz8gqZwDvra39wWT9Pielk5G0w+LLwVTiTmvc
         qwtwpEhdN0vdVMESpLNA5TGZSpbnIR6uIb2lXhc0LbmCB1GhV447iFzu/NprYtXGdAnr
         a6ngjaFmBKFbUjPX5IVFWY/BcmFSOW6rD+TZTckTgvzGTl/1UMHdqCD7kqQ+qcnE+H4k
         oEcvrmwm2Sjy1w6mFb4mVG16BIdgcVPKduhDdAKUbd4DzrHdIRY5e8juItU3xMYkcrV9
         KfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=N06cOpR0fhGltUp7Tz8+3ysz8vx784Cgbf5RyQDoybc=;
        b=ROjjQqzRowRfDJKvlF9YA3Hkyzd2fja9GoSn183szjG41dOqmsaUcakamX2y4kKpFW
         VHIE1PzFJ2idbw4J6elyMHTRuO/sDWduLnQguBayg7qJ8mtuLSm0axA3Llz4WHaY2ebm
         VBdlADc5VG3Pu2kX1/eLgw+FMWeIBJRkH0Kirbe2Azp0vcDE9WxcQpLvDvvPOITJDNrk
         O13PdyQi9foTRDVZbB3xsx0uZCUvws3SUoH5LmVmpVGRMMDvkNV3upQXKa6HOLmMvELg
         VdU1Zi06o1Qfw8ZbHtrKRj24Ds2zCWqTWqZtWZGOGXvbo2dXE2iDlCMlyDnN/N6g1GwM
         0Oxg==
X-Gm-Message-State: AOAM5317PTi8NAMa5DRWD07luERdCavbsSnjJcLPdSfIEuHWKUQtCPbO
        AbRRHUjhiKn5NYGR412oXkrC8GTlKknpPSMnLQn7uA==
X-Google-Smtp-Source: ABdhPJzSjHfFP+9o6W7dtpiuHhbXpOi+Ely6T6jRghUPr+keMXC2TwImJEfBB4K3AtkK7mq6YZqiSSiPE4c7S1mdIWg=
X-Received: by 2002:a50:ea8b:0:b0:428:7d05:eb7e with SMTP id
 d11-20020a50ea8b000000b004287d05eb7emr40591268edo.185.1653597981396; Thu, 26
 May 2022 13:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220526203805.3659597-1-tatashin@google.com>
In-Reply-To: <20220526203805.3659597-1-tatashin@google.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 26 May 2022 16:45:45 -0400
Message-ID: <CA+CK2bDkKzp6uvy+f09K=COd3xn+EDa5nEu2j2o7Vyhd=aG0AA@mail.gmail.com>
Subject: Re: [PATCH] kexec_file: Increase maximum file size to 4G
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, rburanyi@google.com,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 4:38 PM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> In some case initrd can be large. For example, it could be a netboot
> image loaded by u-root, that is kexec'ing into it.
>
> The maximum size of initrd is arbitrary set to 2G. Also, the limit is
> not very obvious because it is hidden behind a generic INT_MAX macro.
>
> Theoretically, we could make it LONG_MAX, but it is safer to keep it
> sane, and just increase it to 4G.
>
> Increase the size to 4G, and make it obvious by having a new macro
> that specifies the maximum file size supported by kexec_file_load()
> syscall: KEXEC_FILE_SIZE_MAX.
>
> Signed-off-by: Pasha Tatashin <tatashin@google.com>

Should be instead:
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha

> ---
>  kernel/kexec_file.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 8347fc158d2b..1be2227b33e6 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -31,6 +31,9 @@
>
>  static int kexec_calculate_store_digests(struct kimage *image);
>
> +/* Maximum size in bytes for kernel/initrd files. */
> +#define KEXEC_FILE_SIZE_MAX    (4UL << 30)
> +
>  /*
>   * Currently this is the only default function that is exported as some
>   * architectures need it to do additional handlings.
> @@ -227,7 +230,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>         void *ldata;
>
>         ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
> -                                      INT_MAX, NULL, READING_KEXEC_IMAGE);
> +                                      KEXEC_FILE_SIZE_MAX, NULL,
> +                                      READING_KEXEC_IMAGE);
>         if (ret < 0)
>                 return ret;
>         image->kernel_buf_len = ret;
> @@ -247,7 +251,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>         /* It is possible that there no initramfs is being loaded */
>         if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>                 ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
> -                                              INT_MAX, NULL,
> +                                              KEXEC_FILE_SIZE_MAX, NULL,
>                                                READING_KEXEC_INITRAMFS);
>                 if (ret < 0)
>                         goto out;
> --
> 2.36.1.124.g0e6072fb45-goog
>
