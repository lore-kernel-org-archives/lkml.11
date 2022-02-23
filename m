Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165CFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 08:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbiBWI7s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 03:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbiBWI7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:59:44 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2887C79E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:59:16 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so2097814pja.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2to3BP7Hk9Rhn4a/m99kEi4zOalhc4jbVth64Ox8bo=;
        b=Ioq3fZdQL5Go7nNoKOTcI6UkzVDslzikWseU5l/a6xLGDiYT2bcUe9ivpcNzD7K1Tv
         T03nES8J7htJdgJBrqq8sXjU3Qmx0RE90QkgNxV5QBgzUXXkQGndMG2n/ZDtTN39AUjc
         uBBxrkCjdwZrFE6qaODTqqvrTGXRaRD6i4/DzHhc/Rt+0VqiiyE/v3g4p8KIj1cL1ovV
         atI3/aEzA0lHOAWLTfrPiPQEEow8/gm+sCOAg7/HxWsTPJdWswhCLoj+zhReCoEgBbeC
         lla/EdI7SfKzDSHpVuUgdIOr18CcF3E51B/+tPq+GO8XUdrjEaaL821NGrzPGBPaKcUJ
         qMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2to3BP7Hk9Rhn4a/m99kEi4zOalhc4jbVth64Ox8bo=;
        b=4eoI9TQTKYGx5zkzK21yMQ7Mfwj4AZ77hdwF6qIRJv8PrSXGTcIBRfSkAVQ1B8n/oJ
         aCpeGReJ0CYOOJmI3tVI0Tqp1ZCgz6d/2Mfn27vU/YOtjKXGkBfV3EDZACs9WiZsXCm/
         zZ4KygxVhmtlpvTWW13i/hDhe48luraKtFFV9W8D2t5OkqE44Jawejs44iNRMgW349O7
         slLYtE6axJmg0dAgrKBoKA0yPChQ9uhAVmorHJwhlfyWUuAR5rwzZiZuHcRWoKTzuDLH
         r1rTFVl2iDp65rE8R7T3QzRcnf+P9yu0E2hliA1A4HtyrB9Uh56vri7m+gp5d8yVo7b7
         +KYA==
X-Gm-Message-State: AOAM530QmdY5iszN+CGzrAQa48DldEPoPX/mUMTjpC5yY6RfWMEaYM0h
        /rKUMsEY/i3E2wi8Nn5/yMY=
X-Google-Smtp-Source: ABdhPJxEbCWZhD20rDjbo+ruunHnyo4end5hE45bLbvCFRkuf+jTx5gSE41diVYb+XaE7XFzcnTTMw==
X-Received: by 2002:a17:902:ea02:b0:14f:fd0e:e433 with SMTP id s2-20020a170902ea0200b0014ffd0ee433mr1073572plg.24.1645606756292;
        Wed, 23 Feb 2022 00:59:16 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id u17sm16834351pfi.99.2022.02.23.00.59.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Feb 2022 00:59:15 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:57:40 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@yulong.com>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com,
        shaojunjun@coolpad.com
Subject: Re: [PATCH] erofs: fix ztailpacking on > 4GiB filesystems
Message-ID: <20220223165740.0000067a.zbestahu@gmail.com>
In-Reply-To: <20220222033118.20540-1-hsiangkao@linux.alibaba.com>
References: <20220222033118.20540-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 11:31:18 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> z_idataoff here is an absolute physical offset, so it should use
> erofs_off_t (64 bits at least). Otherwise, it'll get trimmed and
> cause the decompresion failure.
> 
> Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index b8272fb95fd6..5aa2cf2c2f80 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -325,7 +325,7 @@ struct erofs_inode {
>  			unsigned char  z_algorithmtype[2];
>  			unsigned char  z_logical_clusterbits;
>  			unsigned long  z_tailextent_headlcn;
> -			unsigned int   z_idataoff;
> +			erofs_off_t    z_idataoff;
>  			unsigned short z_idata_size;
>  		};
>  #endif	/* CONFIG_EROFS_FS_ZIP */

Reviewed-by: Yue Hu <huyue2@yulong.com>
